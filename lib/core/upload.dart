import 'dart:io';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:charset/charset.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:once_power/const/l10n.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/provider/setting.dart';
import 'package:once_power/util/notification.dart';
import 'package:path/path.dart' as path;

import 'file.dart';

void dropFile(DropDoneDetails details, WidgetRef ref) async {
  List<XFile> paths = details.files;
  if (paths.isNotEmpty) {
    final List<String> files = paths.map((e) => e.path).toList();
    await formatPath(ref, files);
  }
}

Future<void> uploadFile(WidgetRef ref) async {
  final List<XFile> files = await openFiles();
  if (files.isNotEmpty) {
    await formatXFile(ref, files);
  }
}

Future<void> uploadFolder(WidgetRef ref) async {
  final List<String?> folders = await getDirectoryPaths();
  final List<String> validFolders = folders
      .whereType<String>()
      .where((f) => f.isNotEmpty)
      .toList();
  if (validFolders.isNotEmpty) {
    await formatFolder(ref, validFolders);
  }
}

Future<UploadMarkInfo?> uploadTextFile(String filePath) async {
  String fileName = path.basename(filePath);
  String content = '';
  final File file = File(filePath);
  try {
    content = await file.readAsString();
  } catch (e) {
    try {
      final bytes = await file.readAsBytes();
      content = gbk.decode(bytes);
    } catch (gbError) {
      showTxtDecodeNotification(gbError.toString());
      return null;
    }
  }
  return UploadMarkInfo(name: fileName, content: content);
}

// 压缩图片的参数
class CompressImageParams {
  final Uint8List bytes;
  final int quality;
  final int maxWidth;
  final int maxHeight;

  CompressImageParams({
    required this.bytes,
    required this.quality,
    required this.maxWidth,
    required this.maxHeight,
  });
}

// 在 isolate 中执行图片压缩
Uint8List _compressImageIsolate(CompressImageParams params) {
  try {
    final image = img.decodeImage(params.bytes);
    if (image == null) {
      return params.bytes;
    }
    int width = image.width;
    int height = image.height;
    if (width > params.maxWidth || height > params.maxHeight) {
      final double ratio = width / height;
      if (ratio > 1) {
        width = params.maxWidth;
        height = (params.maxWidth / ratio).round();
      } else {
        height = params.maxHeight;
        width = (params.maxHeight * ratio).round();
      }
    }
    final resizedImage = img.copyResize(image, width: width, height: height);
    final compressedBytes = img.encodeJpg(
      resizedImage,
      quality: params.quality,
    );
    return compressedBytes;
  } catch (e) {
    return params.bytes;
  }
}

Future<Uint8List> compressImage(
  Uint8List bytes, {
  int quality = 80,
  int maxWidth = 1920,
  int maxHeight = 1080,
}) async {
  final params = CompressImageParams(
    bytes: bytes,
    quality: quality,
    maxWidth: maxWidth,
    maxHeight: maxHeight,
  );
  return await Isolate.run(() => _compressImageIsolate(params));
}

Future<void> uploadImage(WidgetRef ref) async {
  final XTypeGroup xType = XTypeGroup(
    label: tr(AppL10n.dialogImage),
    extensions: ['jpg', 'png', 'jpeg', 'webp'],
  );
  final XFile? file = await openFile(acceptedTypeGroups: [xType]);
  if (file != null) {
    final provider = ref.read(themeSettingProvider.notifier);
    provider.updateBackground(tr(AppL10n.settingUploading));
    final Uint8List bytes = await file.readAsBytes();
    if (bytes.length > 1024 * 1024) {
      // 对于大于1MB的图片，使用isolate进行压缩，避免阻塞UI
      final Uint8List compressedBytes = await compressImage(
        bytes,
        quality: bytes.length > 2 * 1024 * 1024 ? 70 : 80,
        maxWidth: 1920,
        maxHeight: 1080,
      );
      provider.updateBackgroundBytes(compressedBytes);
    } else {
      provider.updateBackgroundBytes(bytes);
    }
    provider.updateBackground(file.path);
  }
}
