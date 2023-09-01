import 'package:once_power/constants/constants.dart';

enum FunctionMode { replace, reserve, organize }

enum DateType {
  createDate('创建日期'),
  modifyDate('修改日期'),
  exifDate('拍摄日期'),
  earliestDate('最早日期'),
  latestDate('最晚日期');

  final String value;
  const DateType(this.value);
}

enum ReserveType {
  capitalLetter,
  lowercaseLetter,
  nonLetter,
  digit,
  punctuation
}

extension ReservedTypeExtension on ReserveType {
  String get value {
    switch (this) {
      case ReserveType.capitalLetter:
        return 'ABC';
      case ReserveType.lowercaseLetter:
        return 'abc';
      case ReserveType.nonLetter:
        return '中あ조བོད';
      case ReserveType.digit:
        return '123';
      case ReserveType.punctuation:
        return '!.?';
    }
  }
}

enum RemoveType { match, before, after, middle }

extension RemoveTypeExtension on RemoveType {
  String get value {
    switch (this) {
      case RemoveType.match:
        return '匹配的';
      case RemoveType.before:
        return '之前的';
      case RemoveType.middle:
        return '中间的';
      case RemoveType.after:
        return '之后的';
    }
  }
}

enum SortType {
  defaultSort,
  nameDescending,
  nameAscending,
  checkDescending,
  checkAscending
}

extension SortTypeExtension on SortType {
  String get value {
    switch (this) {
      case SortType.defaultSort:
        return AppIcons.sort;
      case SortType.nameDescending:
        return AppIcons.nameDescending;
      case SortType.nameAscending:
        return AppIcons.nameAscending;
      case SortType.checkDescending:
        return AppIcons.checkDescending;
      case SortType.checkAscending:
        return AppIcons.checkAscending;
    }
  }
}

enum FileClassify { image, video, text, audio, folder, zip, other }

extension FileClassifyExtension on FileClassify {
  String get value {
    switch (this) {
      case FileClassify.image:
        return '图片';
      case FileClassify.video:
        return '视频';
      case FileClassify.text:
        return '文本';
      case FileClassify.audio:
        return '音频';
      case FileClassify.folder:
        return '文件夹';
      case FileClassify.zip:
        return '压缩包';
      case FileClassify.other:
        return '其他';
    }
  }
}

enum FileUploadType { prefix, suffix }

enum MessageType { failure, success, warning }
