import 'dart:io';
import 'dart:isolate';

import 'package:file_selector/file_selector.dart';
import 'package:flutter/foundation.dart';
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
import 'package:once_power/src/rust/api/file_meta.dart';
import 'package:once_power/src/rust/api/file_type.dart';
import 'package:once_power/src/rust/frb_generated.dart';
import 'package:once_power/util/format.dart';
import 'package:once_power/util/info.dart';
import 'package:once_power/util/location.dart';
import 'package:once_power/util/notification.dart';
import 'package:path/path.dart' as path;

List<InfoDetail> _errs = [];

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

// 工作池处理文件信息生成
Future<void> _processFilesWithWorkerPool(
  List<String> paths,
  Function(FileInfo) onFileProcessed,
  Function(int) onProgress,
  int workerCount,
) async {
  // 如果文件数量较少，直接使用单个 isolate 处理
  if (paths.length < 10) {
    final receivePort = ReceivePort();
    final isolate = await Isolate.spawn(
      _isolateEntryPoint,
      _IsolateArgs(receivePort.sendPort, paths, 0),
    );

    int processedCount = 0;
    // 用于存储处理结果，按原始顺序添加
    final List<FileInfo?> results = List.filled(paths.length, null);

    await for (final message in receivePort) {
      if (message is _IndexedFileInfo) {
        // 存储带索引的文件信息
        results[message.index] = message.fileInfo;

        // 检查是否有连续的文件可以添加
        for (int i = 0; i < results.length; i++) {
          if (results[i] != null) {
            onFileProcessed(results[i]!);
            results[i] = null; // 标记为已添加
            processedCount++;
            onProgress(processedCount);
          } else {
            break; // 遇到空值，停止添加
          }
        }
      } else if (message is bool && message == true) {
        // 处理完成，添加剩余的文件
        for (int i = 0; i < results.length; i++) {
          if (results[i] != null) {
            onFileProcessed(results[i]!);
            processedCount++;
            onProgress(processedCount);
          }
        }
        break;
      }
    }

    isolate.kill();
    return;
  }

  final workerCountFinal = workerCount;
  final receivePort = ReceivePort();
  final List<Isolate> isolates = [];
  final List<List<String>> chunks = _splitList(paths, workerCountFinal);

  int processedCount = 0;
  int completedWorkers = 0;

  // 用于存储处理结果，按原始顺序添加
  final List<FileInfo?> results = List.filled(paths.length, null);

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
      // 存储带索引的文件信息
      results[message.index] = message.fileInfo;

      // 检查是否有连续的文件可以添加
      for (int i = 0; i < results.length; i++) {
        if (results[i] != null) {
          onFileProcessed(results[i]!);
          results[i] = null; // 标记为已添加
          processedCount++;
          onProgress(processedCount);
        } else {
          break; // 遇到空值，停止添加
        }
      }
    } else if (message is bool && message == true) {
      // 一个工作器完成
      completedWorkers++;
      if (completedWorkers >= workerCountFinal) {
        // 所有工作器完成，添加剩余的文件
        for (int i = 0; i < results.length; i++) {
          if (results[i] != null) {
            onFileProcessed(results[i]!);
            processedCount++;
            onProgress(processedCount);
          }
        }
        break;
      }
    }
  }

  // 清理所有 isolate
  for (final isolate in isolates) {
    isolate.kill();
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

// Isolate 入口点
void _isolateEntryPoint(_IsolateArgs args) async {
  try {
    await RustLib.init();
  } catch (e) {
    debugPrint('Error initializing RustLib: $e');
  }

  // 实时处理每个文件，减少批量更新的卡顿感
  for (int i = 0; i < args.paths.length; i++) {
    String path = args.paths[i];
    try {
      final fileInfo = await generateFileInfo(path);
      // 处理完一个文件就发送结果，附带原始索引，实现实时更新并保持顺序
      args.sendPort.send(_IndexedFileInfo(args.baseIndex + i, fileInfo));
    } catch (e) {
      _errs.add(InfoDetail(file: path, message: formatSystemError(e)));
      debugPrint('Error processing file $path: $e');
    }
  }
  // 发送完成信号
  args.sendPort.send(true);
}

// Isolate 参数类
class _IsolateArgs {
  final SendPort sendPort;
  final List<String> paths;
  final int baseIndex; // 基础索引，用于保持原始顺序
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

  // 过滤重复路径
  final Set<String> existingPaths = ref
      .read(fileListProvider)
      .map((e) => e.path)
      .toSet();

  // 根据文件数量决定处理方式
  if (paths.length <= AppNum.maxCount) {
    // 文件数量较少，使用串行处理
    int processedCount = 0;
    for (String path in paths) {
      try {
        final fileInfo = await generateFileInfo(path);
        if (!existingPaths.contains(fileInfo.path)) {
          ref.read(fileListProvider.notifier).add(fileInfo);
        }
        processedCount++;
        ref.read(countProvider.notifier).updateValue(processedCount);
      } catch (e) {
        _errs.add(InfoDetail(file: path, message: formatSystemError(e)));
        debugPrint('Error processing file $path: $e');
      }
    }
  } else {
    // 文件数量较多，使用工作池处理
    await _processFilesWithWorkerPool(
      paths,
      (fileInfo) {
        // 处理单个文件结果
        if (!existingPaths.contains(fileInfo.path)) {
          ref.read(fileListProvider.notifier).add(fileInfo);
        }
      },
      (progress) {
        // 更新进度
        ref.read(countProvider.notifier).updateValue(progress);
      },
      2, // 使用 2 个工作器
    );
  }

  if (ref.read(isViewModeProvider) &&
      !ref.read(currentModeProvider).isOrganize) {
    filterFile(ref);
  }
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
  if (type.isAudio) metaInfo = getAudioInfo(filePath);
  if (type.isImage) {
    resolution = await getImageDimensions(filePath);
    PhotoMetaInfo? photoMetaInfo = getImageMetaInfo(imagePath: filePath);
    if (photoMetaInfo != null) {
      String? captureStr = photoMetaInfo.capture;
      DateInfo? capture = captureStr == null
          ? null
          : getDateInfo(DateTime.tryParse(captureStr));
      double? longitude = photoMetaInfo.longitude;
      double? latitude = photoMetaInfo.latitude;
      // 避免在 Isolate 中调用可能涉及 UI 的函数
      String location = '';
      try {
        location = await getTrueLocation(longitude, latitude);
      } catch (e) {
        debugPrint('Error getting location: $e');
      }
      metaInfo = FileMetaInfo(
        make: photoMetaInfo.make ?? '',
        model: photoMetaInfo.model ?? '',
        capture: capture,
        latitude: latitude,
        longitude: longitude,
        location: location,
      );
    }
  }
  if (type.isVideo) {
    (Resolution, FileMetaInfo) result = await getVideoInfo(filePath);
    (resolution, metaInfo) = result;
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

void filterFile(WidgetRef ref) {
  final FileList provider = ref.read(fileListProvider.notifier);
  final int before = ref.watch(fileListProvider).length;
  provider.removeOtherClassify([FileType.image, FileType.video]);
  final int after = ref.watch(fileListProvider).length;
  showFilterNotification(before - after);
}
