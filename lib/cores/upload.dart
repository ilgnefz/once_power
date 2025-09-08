import 'dart:typed_data';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image/image.dart' as img;
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/cores/file.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/provider/theme.dart';

Future<void> uploadFile(WidgetRef ref) async {
  final List<XFile> files = await openFiles();
  if (files.isNotEmpty) {
    await formatXFile(ref, files);
    updateName(ref);
  }
}

Future<void> uploadFolder(WidgetRef ref) async {
  final List<String?> folders = await getDirectoryPaths();
  if (folders.isNotEmpty) {
    await formatFolder(ref, folders);
    updateName(ref);
  }
}

void dropFile(DropDoneDetails details, WidgetRef ref) async {
  List<XFile> paths = details.files;
  if (paths.isNotEmpty) {
    final files = paths.map((e) => e.path).toList();
    await formatPath(ref, files);
    updateName(ref);
  }
}

Future<Uint8List> compressImage(
  Uint8List bytes, {
  int quality = 80,
  int maxWidth = 1920,
  int maxHeight = 1080,
}) async {
  try {
    final image = img.decodeImage(bytes);
    if (image == null) return bytes;

    int width = image.width;
    int height = image.height;

    if (width > maxWidth || height > maxHeight) {
      final double ratio = width / height;
      if (ratio > 1) {
        width = maxWidth;
        height = (maxWidth / ratio).round();
      } else {
        height = maxHeight;
        width = (maxHeight * ratio).round();
      }
    }

    final resizedImage = img.copyResize(image, width: width, height: height);

    final compressedBytes = img.encodeJpg(resizedImage, quality: quality);
    return compressedBytes;
  } catch (e) {
    return bytes;
  }
}

Future<void> uploadImage(WidgetRef ref) async {
  final XTypeGroup xType = XTypeGroup(
    label: tr(AppL10n.dialogImage),
    extensions: ['jpg', 'png', 'jpeg', 'webp'],
  );
  final XFile? file = await openFile(acceptedTypeGroups: [xType]);
  if (file != null) {
    final Uint8List bytes = await file.readAsBytes();

    // 如果图片超过2MB，则进行压缩
    if (bytes.length > 2 * 1024 * 1024) {
      // 对于大图片，使用较低质量进行压缩
      final Uint8List compressedBytes = await compressImage(
        bytes,
        quality: 70, // 压缩质量
        maxWidth: 1600, // 最大宽度
        maxHeight: 900, // 最大高度
      );
      ref.read(backgroundImageProvider.notifier).update(compressedBytes);
    } else if (bytes.length > 1024 * 1024) {
      // 对于中等大小图片，使用中等质量进行压缩
      final Uint8List compressedBytes = await compressImage(
        bytes,
        quality: 80,
        maxWidth: 1920,
        maxHeight: 1080,
      );
      ref.read(backgroundImageProvider.notifier).update(compressedBytes);
    } else {
      // 小图片保持原样
      ref.read(backgroundImageProvider.notifier).update(bytes);
    }
  }
}
