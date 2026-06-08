import 'dart:io';
import 'dart:isolate';

import 'package:bot_toast/bot_toast.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/extension.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/update/update.dart';
import 'package:once_power/enum/app.dart';
import 'package:once_power/enum/file.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/model/notification.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/src/rust/api/file_info.dart';
import 'package:once_power/src/rust/api/file_type.dart';
import 'package:once_power/src/rust/frb_generated.dart';
import 'package:once_power/util/format.dart';
import 'package:once_power/util/info.dart';
import 'package:once_power/util/notification.dart';
import 'package:once_power/view/content/loading.dart';
import 'package:path/path.dart' as path;

List<InfoDetail> _errs = [];

// 获取最优的 worker 数量
int _getOptimalWorkerCount() {
  final int processors = Platform.numberOfProcessors;
  // 使用核心数的 75%，最少 2 个，最多 8 个
  return (processors * 0.75).clamp(2, 8).toInt();
}

Future<void> formatXFile(WidgetRef ref, List<XFile> files) async {
  final List<String> paths = files.map((e) => e.path).toList();
  await addFileInfo(ref, paths);
}

Future<void> formatFolder(WidgetRef ref, List<String> folders) async {
  bool addFolder = ref.read(isAddFolderProvider);
  bool addSubfolder = ref.read(isAddSubfolderProvider);
  List<String> paths = [];
  for (String folder in folders) {
    paths.addAll(await handleFolder(folder, addFolder, addSubfolder));
  }
  if (paths.isEmpty) return showEmptyNotification();
  await addFileInfo(ref, paths);
}

Future<void> formatPath(WidgetRef ref, List<String> paths) async {
  List<String> files = [];
  bool addFolder = ref.read(isAddFolderProvider);
  bool addSubfolder = ref.read(isAddSubfolderProvider);
  for (String p in paths) {
    bool isFile = await FileSystemEntity.isFile(p);
    isFile
        ? files.add(p)
        : files.addAll(await handleFolder(p, addFolder, addSubfolder));
  }
  if (files.isEmpty) return showEmptyNotification();
  await addFileInfo(ref, files);
}

Future<List<String>> handleFolder(
  String folder,
  bool addFolder,
  bool addSubfolder,
) async {
  List<String> list = [];
  if (addFolder) {
    addSubfolder
        ? list.addAll(await getAllPath(folder, true))
        : list.add(folder);
  } else {
    list.addAll(await getAllPath(folder, false));
  }
  return list;
}

Future<List<String>> getAllPath(String folder, bool addSubfolder) async {
  Directory directory = Directory(folder);
  List<String> children = <String>[];
  await for (FileSystemEntity entity in directory.list(recursive: true)) {
    final FileSystemEntityType type = await FileSystemEntity.type(entity.path);
    if (type == FileSystemEntityType.file && !addSubfolder) {
      String extension = path.extension(entity.path);
      String ext = extension.isEmpty ? extension : extension.substring(1);
      if (!AppExtension.filter.contains(ext)) children.add(entity.path);
    } else if (type == FileSystemEntityType.directory && addSubfolder) {
      children.add(entity.path);
    }
  }
  return children;
}

// 处理单个文件信息的公共函数
void _processSingleFile(
  WidgetRef ref,
  FileInfo fileInfo,
  Set<String> existingPaths,
) {
  if (!existingPaths.contains(fileInfo.path)) {
    ref.read(fileListProvider.notifier).add(fileInfo);
    existingPaths.add(fileInfo.path);
  }
}

// 工作池处理文件信息生成
Future<void> _processFilesWithWorkerPool(
  List<String> paths,
  Function(FileInfo) onFileProcessed,
  Function(int) onProgress,
  int workerCount,
) async {
  final workerCountFinal = workerCount;
  final receivePort = ReceivePort();
  final List<Isolate> isolates = [];
  final List<List<String>> chunks = _splitList(paths, workerCountFinal);

  int processedCount = 0;
  int completedWorkers = 0;

  // 计算每个 chunk 的基础索引
  int baseIndex = 0;
  final List<int> baseIndices = [];
  for (int i = 0; i < workerCountFinal; i++) {
    baseIndices.add(baseIndex);
    baseIndex += chunks[i].length;
  }

  // 创建工作池
  for (int i = 0; i < workerCountFinal; i++) {
    if (chunks[i].isNotEmpty) {
      final isolate = await Isolate.spawn(
        _isolateEntryPoint,
        _IsolateArgs(receivePort.sendPort, chunks[i], baseIndices[i]),
      );
      isolates.add(isolate);
    } else {
      completedWorkers++;
    }
  }

  // 接收处理结果
  await for (final message in receivePort) {
    if (message is _IndexedFileInfo) {
      onFileProcessed(message.fileInfo);
      processedCount++;
      onProgress(processedCount);
    } else if (message is _IndexedError) {
      _errs.add(InfoDetail(file: message.path, message: message.message));
    } else if (message is bool && message == true) {
      completedWorkers++;
      if (completedWorkers >= workerCountFinal) {
        break;
      }
    }
  }

  // 优雅关闭所有 isolate
  for (final isolate in isolates) {
    isolate.kill(priority: Isolate.immediate);
  }
}

// 将列表分割成指定数量的子列表
List<List<String>> _splitList(List<String> list, int parts) {
  final List<List<String>> result = [];
  final int length = list.length;
  final int chunkSize = (length / parts).ceil();

  for (int i = 0; i < parts; i++) {
    final int start = i * chunkSize;
    final int end = start + chunkSize > length ? length : start + chunkSize;
    if (start < length) {
      result.add(list.sublist(start, end));
    } else {
      result.add([]);
    }
  }

  return result;
}

// 带索引的文件信息
class _IndexedFileInfo {
  final int index;
  final FileInfo fileInfo;
  _IndexedFileInfo(this.index, this.fileInfo);
}

// 带索引的错误信息
class _IndexedError {
  final int index;
  final String path;
  final String message;
  _IndexedError(this.index, this.path, this.message);
}

// Isolate 入口点
void _isolateEntryPoint(_IsolateArgs args) async {
  try {
    await RustLib.init();
  } catch (e) {
    debugPrint('Error initializing RustLib: $e');
  }

  for (int i = 0; i < args.paths.length; i++) {
    String path = args.paths[i];
    try {
      final fileInfo = await generateFileInfo(path);
      args.sendPort.send(_IndexedFileInfo(args.baseIndex + i, fileInfo));
    } catch (e) {
      args.sendPort.send(
        _IndexedError(args.baseIndex + i, path, formatSystemError(e)),
      );
      debugPrint('Error processing file $path: $e');
    }
  }
  args.sendPort.send(true);
}

// Isolate 参数类
class _IsolateArgs {
  final SendPort sendPort;
  final List<String> paths;
  final int baseIndex;
  _IsolateArgs(this.sendPort, this.paths, this.baseIndex);
}

Future<void> addFileInfo(WidgetRef ref, List<String> paths) async {
  Stopwatch stopwatch = Stopwatch()..start();
  _errs.clear();
  bool isAppend = ref.read(isAppendModeProvider);
  if (!isAppend) ref.read(fileListProvider.notifier).clear();
  ref.read(totalProvider.notifier).update(paths.length);
  ref.read(countProvider.notifier).reset();
  ref.read(isApplyingProvider.notifier).start();

  final Set<String> existingPaths = ref
      .read(fileListProvider)
      .map((e) => e.path)
      .toSet();

  if (paths.length <= AppNum.maxCount) {
    int processedCount = 0;
    for (String path in paths) {
      try {
        final fileInfo = await generateFileInfo(path);
        _processSingleFile(ref, fileInfo, existingPaths);
        processedCount++;
        ref.read(countProvider.notifier).updateValue(processedCount);
      } catch (e) {
        _errs.add(InfoDetail(file: path, message: formatSystemError(e)));
        debugPrint('Error processing file $path: $e');
      }
    }
  } else {
    await _processFilesWithWorkerPool(
      paths,
      (fileInfo) => _processSingleFile(ref, fileInfo, existingPaths),
      (progress) => ref.read(countProvider.notifier).updateValue(progress),
      _getOptimalWorkerCount(),
    );
  }

  if (ref.read(isViewModeProvider) &&
      !ref.read(currentModeProvider).isOrganize) {
    filterFile(ref);
  }
  // 在主线程中补充视频文件的元信息（flutter_media_info 不能在 Isolate 中使用）
  final List<FileInfo> fileList = ref.read(fileListProvider);
  await populateVideoInfo(fileList);

  stopwatch.stop();
  double cost = stopwatch.elapsedMicroseconds / 1000000;
  ref.read(costProvider.notifier).update(cost);
  ref.read(isApplyingProvider.notifier).finish();
  if (_errs.isNotEmpty) showAddErrorNotification(_errs);
  updateName(ref);
}

Future<void> processFilesWithConcurrence(
  WidgetRef ref,
  List<String> paths,
) async {
  if (paths.isEmpty) return;
  final Set<String> existingPaths = ref
      .read(fileListProvider)
      .map((e) => e.path)
      .toSet();
  const int chunkSize = 10;
  for (int i = 0; i < paths.length; i += chunkSize) {
    final int end = (i + chunkSize < paths.length)
        ? i + chunkSize
        : paths.length;
    final List<String> chunk = paths.sublist(i, end);
    final List<FileInfo?> results = await Future.wait(
      chunk.map((filePath) async {
        if (existingPaths.contains(filePath)) return null;
        return await generateFileInfo(filePath);
      }),
    );
    for (var result in results) {
      if (result != null) {
        ref.read(fileListProvider.notifier).add(result);
      }
    }
  }
}

// 在 Isolate 中执行的文件信息生成（不包含视频信息）
Future<FileInfo> generateFileInfo(String filePath) async {
  RFileInfo fileInfo = getFileInfo(filePath: filePath);
  String name = fileInfo.name;
  String extension = fileInfo.ext;
  if (extension.isEmpty && name.startsWith('.')) {
    (name, extension) = ('', name.substring(1));
  }
  FileType type = fileInfo.isDir ? FileType.folder : getFileType(extension);
  FileMetaInfo? metaInfo;
  Resolution? resolution;
  Uint8List? thumbnail;

  if (type.isAudio) {
    metaInfo = getAudioInfo(filePath);
  } else if (type.isImage) {
    resolution = await getImageDimensions(filePath);
    if (!filePath.endsWith('.gif') &&
        !filePath.endsWith('.psd') &&
        !filePath.endsWith('.svg')) {
      metaInfo = await getImageMeta(filePath);
    }
  }

  return FileInfo(
    id: fileInfo.id,
    name: name,
    newName: name,
    extension: extension,
    newExtension: extension,
    parent: fileInfo.parent,
    path: filePath,
    tempPath: '',
    beforePath: filePath,
    createdDate: getDateInfo(intToDateTime(fileInfo.createTime))!,
    modifiedDate: getDateInfo(intToDateTime(fileInfo.modifyTime))!,
    accessedDate: getDateInfo(intToDateTime(fileInfo.accessTime))!,
    metaInfo: metaInfo,
    resolution: resolution,
    thumbnail: thumbnail,
    type: type,
    size: fileInfo.size.toInt(),
  );
}

// 在主线程中补充视频信息（flutter_media_info 只能在主线程使用）
// 分批处理以避免 UI 阻塞
Future<void> populateVideoInfo(List<FileInfo> files) async {
  // 过滤需要处理的视频文件
  final List<FileInfo> videoFiles = files
      .where((f) => f.type.isVideo && f.resolution == null)
      .toList();

  if (videoFiles.isEmpty) return;

  final int total = videoFiles.length;

  // 使用 ValueNotifier 管理进度状态，避免弹窗反复创建
  final progressNotifier = ValueNotifier<int>(0);

  // 只创建一次弹窗
  final cancelFunc = BotToast.showCustomLoading(
    toastBuilder: (_) => ReadVideoProgressWidget(
      progressNotifier: progressNotifier,
      total: total,
    ),
    backgroundColor: const Color(0x80000000),
    align: Alignment.center,
    duration: null,
  );

  const int batchSize = 3;

  try {
    for (var i = 0; i < videoFiles.length; i++) {
      final file = videoFiles[i];
      try {
        (Resolution, FileMetaInfo) result = await getVideoInfo(file.path);
        file.resolution = result.$1;
        file.metaInfo = result.$2;
      } catch (e) {
        debugPrint('Error getting video info for ${file.path}: $e');
      }

      // 更新进度状态（弹窗会自动刷新）
      progressNotifier.value = i + 1;

      // 每处理一批后让出主线程，避免 UI 阻塞
      if ((i + 1) % batchSize == 0) {
        await Future.delayed(const Duration(milliseconds: 10));
      }
    }
  } finally {
    // 确保关闭加载提示
    cancelFunc();
    BotToast.closeAllLoading();
  }
}

void filterFile(WidgetRef ref) {
  final FileList provider = ref.read(fileListProvider.notifier);
  final int before = ref.watch(fileListProvider).length;
  provider.removeOtherClassify([FileType.image, FileType.video]);
  final int after = ref.watch(fileListProvider).length;
  showFilterNotification(before - after);
}
