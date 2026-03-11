import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/enum/file.dart';
import 'package:once_power/provider/toggle.dart';

bool isChinese(String text) => RegExp(r'^[\u4e00-\u9fa5]').hasMatch(text);

// bool isEnglish(BuildContext context) => context.locale == Locale('en', 'US');

bool isCheckedClassify(WidgetRef ref, FileClassify classify) {
  if (classify.isAudio) return ref.watch(checkAudioProvider);
  if (classify.isOther) return ref.watch(checkOtherProvider);
  if (classify.isImage) return ref.watch(checkImageProvider);
  if (classify.isDoc) return ref.watch(checkTextProvider);
  if (classify.isVideo) return ref.watch(checkVideoProvider);
  if (classify.isArchive) return ref.watch(checkArchiveProvider);
  return ref.watch(checkFolderProvider);
}

Future<bool> isExist(bool isFolder, String filePath) async {
  if (isFolder) return await Directory(filePath).exists();
  return await File(filePath).exists();
}
