import 'package:once_power/const/extension.dart';
import 'package:once_power/enum/date.dart';
import 'package:once_power/enum/file.dart';
import 'package:once_power/model/file.dart';
import 'package:string_util_xx/StringUtilxx.dart';

import 'verify.dart';

FileClassify getFileClassify(String ext) {
  ext = ext.toLowerCase();
  if (AppExtension.image.contains(ext)) return FileClassify.image;
  if (AppExtension.video.contains(ext)) return FileClassify.video;
  if (AppExtension.doc.contains(ext)) return FileClassify.doc;
  if (AppExtension.audio.contains(ext)) return FileClassify.audio;
  if (AppExtension.archive.contains(ext)) return FileClassify.archive;
  if (AppExtension.folder == ext) return FileClassify.folder;
  return FileClassify.other;
}

DateInfo? getDateInfo(DateTime? date) {
  if (date == null) return null;
  DateInfo dateInfo = DateInfo(date, weekdayNames[date.weekday - 1]);
  return dateInfo;
}

String getFullName(String name, String extension) {
  if (extension == '' || extension == 'dir') return name;
  return '$name.$extension';
}

List<FileInfo> splitSortList(List<FileInfo> fileList, bool reverse) {
  List<FileInfo> chineseList = [];
  List<FileInfo> otherList = [];
  for (FileInfo e in fileList) {
    if (isChinese(e.name)) {
      chineseList.add(e);
    } else {
      otherList.add(e);
    }
  }
  if (reverse) {
    chineseList.sort((a, b) => StringUtilxx_c.compareExtend(b.name, a.name));
    otherList.sort((a, b) => b.name.compareTo(a.name));
    return [...chineseList, ...otherList];
  }
  chineseList.sort((a, b) => StringUtilxx_c.compareExtend(a.name, b.name));
  otherList.sort((a, b) => a.name.compareTo(b.name));
  return [...otherList, ...chineseList];
}
