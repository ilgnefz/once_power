import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/enums/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/toggle.dart';

bool isEnglish(BuildContext context) => context.locale == Locale('en', 'US');

bool isChinese(String text) => RegExp(r'[\u4e00-\u9fa5]').hasMatch(text);

bool isExist(WidgetRef ref, String filePath) =>
    ref.watch(fileListProvider).any((e) => e.path == filePath);

bool isCheck(WidgetRef ref, FileClassify classify) {
  if (classify.isAudio) return ref.watch(checkAudioProvider);
  if (classify.isOther) return ref.watch(checkOtherProvider);
  if (classify.isImage) return ref.watch(checkImageProvider);
  if (classify.isDoc) return ref.watch(checkTextProvider);
  if (classify.isVideo) return ref.watch(checkVideoProvider);
  if (classify.isArchive) return ref.watch(checkArchiveProvider);
  return ref.watch(checkFolderProvider);
}
