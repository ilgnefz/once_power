enum FunctionMode { replace, reserve, remove }

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
