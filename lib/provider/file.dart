import 'dart:developer';
import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:fvp/fvp.dart';
import 'package:image/image.dart' as img;
import 'package:once_power/enum/file.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/src/rust/api/file_info.dart';
import 'package:once_power/src/rust/api/models.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:video_player/video_player.dart';

part 'file.g.dart';

class _IsolateData {
  final SendPort sendPort;
  final Uint8List snapshotData;
  final int width;
  final int height;

  _IsolateData({
    required this.sendPort,
    required this.snapshotData,
    required this.width,
    required this.height,
  });
}

@riverpod
class FileList extends _$FileList {
  bool _cancelGeneration = false;

  @override
  List<FileInfo> build() => [];

  void add(FileInfo file) => state = [...state, file];

  void addAll(List<FileInfo> list) => state = list;

  void clear() {
    _cancelGeneration = true;
    state = [];
  }

  void checkAll(bool check) => state = state.map((e) {
    if (e.checked != check) e.checked = check;
    return e;
  }).toList();

  void checkReverse() => state = state.map((e) {
    e.checked = !e.checked;
    return e;
  }).toList();

  void checkClassify(FileType type, bool check) => state = state.map((e) {
    if (e.fileType == type) e.checked = check;
    return e;
  }).toList();

  void checkExtension(String ext) => state = state.map((e) {
    if (e.ext == ext) e.checked = !e.checked;
    return e;
  }).toList();

  void checkFolder(String folder) => state = state.map((e) {
    if (e.parent == folder) e.checked = !e.checked;
    return e;
  }).toList();

  void remove(FileInfo file) => state = state.where((e) => e != file).toList();

  void removeAt(int index) => state = state..removeAt(index);

  void removeCheck() => state = state.where((e) => !e.checked).toList();

  void removeFolder(String folder) =>
      state = state.where((e) => e.parent != folder).toList();

  void removeUncheck() => state = state.where((e) => e.checked).toList();

  void removeOtherClassify(List<FileType> classifyList) {
    state = state = state
        .where((e) => classifyList.contains(e.fileType))
        .toList();
  }

  void updateCheck(String id, bool value) => state = state.map((e) {
    if (e.id == id) e.checked = value;
    return e;
  }).toList();

  void updateCreatedDate(String id, DateTime? createdDate) =>
      state = state.map((e) {
        if (e.id == id) e.created = getDateInfo(date: createdDate) ?? e.created;
        return e;
      }).toList();

  void updateModifiedDate(String id, DateTime? modifiedDate) {
    state = state.map((e) {
      if (e.id == id) {
        e.modified = getDateInfo(date: modifiedDate) ?? e.modified;
      }
      return e;
    }).toList();
  }

  void updateAccessedDate(String id, DateTime? accessedDate) {
    state = state.map((e) {
      if (e.id == id) {
        e.accessed = getDateInfo(date: accessedDate) ?? e.accessed;
      }
      return e;
    }).toList();
  }

  void updateFolder(String id, String value) => state = state.map((e) {
    if (e.id == id) e.parent = value;
    return e;
  }).toList();

  void updateGroup(String id, String value) => state = state.map((e) {
    if (e.id == id && e.group != value) e.group = value;
    return e;
  }).toList();

  void updateNewExtension(String id, String value) => state = state.map((e) {
    if (e.id == id && !e.fileType.isFolder) e.newExt = value;
    return e;
  }).toList();

  void updateNewName(String id, String value) => state = state.map((e) {
    if (e.id == id) e.newName = value;
    return e;
  }).toList();

  void updateOriginName(String id, String value) => state = state.map((e) {
    if (e.id == id) e.name = value;
    return e;
  }).toList();

  void updateOriginExtension(String id, String value) => state = state.map((e) {
    if (e.id == id) e.ext = value;
    return e;
  }).toList();

  void updatePath(String id, String value) => state = state.map((e) {
    if (e.id == id) e.path = value;
    return e;
  }).toList();

  void updateTempPath(String id, String value) => state = state.map((e) {
    if (e.id == id) e.tempPath = value;
    return e;
  }).toList();

  void updateThumbnail(String id, Uint8List value) => state = state.map((e) {
    if (e.id == id) e.thumbnail = value;
    return e;
  }).toList();

  Future<void> generateVideoThumbnails({int concurrency = 5}) async {
    final noThumbnails = state
        .where((e) => e.fileType.isVideo && e.thumbnail == null)
        .toList();
    if (noThumbnails.isEmpty) return;

    log('共 ${noThumbnails.length} 个视频待生成封面');

    _cancelGeneration = false;
    int index = 0;

    Future<void> runSlot() async {
      while (!_cancelGeneration && index < noThumbnails.length) {
        final file = noThumbnails[index];
        index++;
        if (_cancelGeneration) break;
        await _generateSingleThumbnail(file);
        if (_cancelGeneration) break;
      }
    }

    final runners = List.generate(
      concurrency.clamp(1, noThumbnails.length),
      (_) => runSlot(),
    );

    await Future.wait(runners);

    log('全部封面生成结束');
  }

  Future<void> _generateSingleThumbnail(FileInfo file) async {
    log('开始生成 ${file.name}');
    VideoPlayerController? controller;
    try {
      controller = VideoPlayerController.file(File(file.path));
      await controller.initialize().catchError((e) {
        updateThumbnail(file.id, Uint8List(0));
        log('生成失败 ${file.name}: 初始化失败，$e');
        return;
      });
      if (_cancelGeneration) return;
      await controller.setVolume(0);
      await controller.play();
      await Future.delayed(const Duration(seconds: 1));
      if (_cancelGeneration) return;
      await controller.pause();
      final videoInfo = controller.getMediaInfo()?.video;
      if (videoInfo == null || videoInfo.isEmpty) {
        updateThumbnail(file.id, Uint8List(0));
        log('生成失败 ${file.name}: 无法获取视频信息');
        return;
      }

      final info = videoInfo[0].codec;
      final width = info.width;
      final height = info.height;
      final Uint8List? snapshot = await controller.snapshot();
      if (_cancelGeneration) return;
      if (snapshot == null || snapshot.isEmpty) {
        updateThumbnail(file.id, Uint8List(0));
        log('生成失败 ${file.name}: 截图数据为空');
        return;
      }

      Uint8List imageBytes = await _generateThumbnailInIsolate(
        snapshot.buffer.asUint8List(),
        width,
        height,
      );

      if (_cancelGeneration) return;
      if (imageBytes.isNotEmpty) {
        updateThumbnail(file.id, imageBytes);
        log('生成完成 ${file.name}');
      } else {
        updateThumbnail(file.id, Uint8List(0));
        log('生成失败 ${file.name}: 图片处理失败');
      }
    } catch (e) {
      updateThumbnail(file.id, Uint8List(0));
      log('生成失败 ${file.name}: $e');
    } finally {
      controller?.dispose();
    }
  }

  Future<Uint8List> _generateThumbnailInIsolate(
    Uint8List snapshotData,
    int width,
    int height,
  ) async {
    final receivePort = ReceivePort();
    await Isolate.spawn(
      _isolateGenerateThumbnail,
      _IsolateData(
        sendPort: receivePort.sendPort,
        snapshotData: snapshotData,
        width: width,
        height: height,
      ),
    );
    return await receivePort.first as Uint8List;
  }

  static void _isolateGenerateThumbnail(_IsolateData data) {
    try {
      final image = img.Image.fromBytes(
        width: data.width,
        height: data.height,
        bytes: data.snapshotData.buffer,
        numChannels: 4,
        rowStride: data.width * 4,
      );
      final Uint8List imageBytes = img.encodeJpg(image, quality: 85);
      data.sendPort.send(imageBytes);
    } catch (e) {
      data.sendPort.send(Uint8List(0));
    }
  }

  void insertAt(int index, FileInfo file) {
    if (index == 0) {
      state = [file, ...state];
    } else if (index == state.length) {
      state = [...state, file];
    } else {
      state = [...state.take(index), file, ...state.skip(index)];
    }
  }

  void insertCenter(List<FileInfo> files) => state = [
    ...state.take(state.length ~/ 2),
    ...files,
    ...state.skip(state.length ~/ 2),
  ];

  void insertFirst(List<FileInfo> files) => state = [...files, ...state];

  void insertLast(List<FileInfo> files) => state = [...state, ...files];

  void insertPosition(int index, List<FileInfo> files) {
    state = [...state.take(index), ...files, ...state.skip(index)];
  }
}

@riverpod
class SelectAll extends _$SelectAll {
  @override
  bool build() {
    if (ref.watch(fileListProvider).isEmpty) return true;
    int checked = ref
        .watch(fileListProvider)
        .where((e) => e.checked == true)
        .toList()
        .length;
    int total = ref.watch(fileListProvider).length;
    return checked >= total / 2;
  }

  void update() {
    state = !state;
    ref.read(fileListProvider.notifier).checkAll(state);
  }
}

@riverpod
class PrefixUploadMark extends _$PrefixUploadMark {
  @override
  UploadMarkInfo? build() => null;
  void update(UploadMarkInfo? value) => state = value;
  void clear() => state = null;
}

@riverpod
class SuffixUploadMark extends _$SuffixUploadMark {
  @override
  UploadMarkInfo? build() => null;
  void update(UploadMarkInfo? value) => state = value;
  void clear() => state = null;
}
