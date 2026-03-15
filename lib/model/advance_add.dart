import 'package:once_power/enum/advance.dart';
import 'package:once_power/enum/date.dart';
import 'package:once_power/enum/file.dart';

import 'advance.dart';

class AdvanceMenuAdd extends AdvanceMenuModel {
  final AddMode mode;
  final AdvanceDate advanceDate;
  final AdvanceMetaData metaData;
  final AdvanceIndex advanceIndex;
  final int randomLength;
  final List<String> randomValue;
  final AddPosition addPosition;
  final int positionIndex;

  AdvanceMenuAdd({
    required super.id,
    required String super.value,
    required this.mode,
    required this.advanceDate,
    required this.metaData,
    required this.advanceIndex,
    required this.randomLength,
    required this.randomValue,
    required this.addPosition,
    required this.positionIndex,
    required super.group,
    required super.checked,
  }) : super(type: AdvanceType.add);

  @override
  AdvanceMenuAdd copyWith({String? id}) {
    return AdvanceMenuAdd(
      id: id ?? this.id,
      value: value,
      mode: mode,
      advanceDate: advanceDate,
      metaData: metaData,
      advanceIndex: advanceIndex,
      randomLength: randomLength,
      randomValue: randomValue,
      addPosition: addPosition,
      positionIndex: positionIndex,
      group: group,
      checked: checked,
    );
  }

  factory AdvanceMenuAdd.fromJson(Map<String, dynamic> json) => AdvanceMenuAdd(
    id: json["id"],
    value: json["value"] ?? '',
    mode: AddMode.values[json["mode"] ?? 0],
    advanceDate: AdvanceDate.fromJson(json["advanceDate"]),
    metaData: AdvanceMetaData.fromJson(json["metaData"]),
    advanceIndex: AdvanceIndex.fromJson(json["advanceIndex"]),
    randomLength: json["randomLength"] ?? 1,
    randomValue: json["randomValue"] == null
        ? <String>[]
        : List<String>.from(json["randomValue"].map((x) => x)),
    addPosition: AddPosition.values[json["addPosition"] ?? 0],
    positionIndex: json["positionIndex"] ?? 1,
    group: json["group"] ?? 'all',
    checked: json["checked"] ?? true,
  );

  @override
  Map<String, dynamic> toJson() => {
    "type": type.index,
    "id": id,
    "value": value,
    "mode": mode.index,
    "advanceDate": advanceDate.toJson(),
    "metaData": metaData.toJson(),
    "advanceIndex": advanceIndex.toJson(),
    "randomLength": randomLength,
    "randomValue": List<String>.from(randomValue.map((x) => x)),
    "addPosition": addPosition.index,
    "positionIndex": positionIndex,
    "group": group,
    "checked": checked,
  };

  @override
  String toString() {
    return 'AdvanceMenuAdd{mode: $mode, advanceDate: $advanceDate, metaData: $metaData, advanceIndex: $advanceIndex, randomLength: $randomLength, randomValue: $randomValue, addPosition: $addPosition, positionIndex: $positionIndex}';
  }
}

class AdvanceDate {
  final DateType type;
  final DateStyle dateStyle;
  final WeekdayStyle weekdayStyle;
  final TimeStyle timeStyle;
  final DateSeparate dateSeparate;
  final String separate;

  AdvanceDate({
    this.type = DateType.created,
    this.dateStyle = DateStyle.none,
    this.weekdayStyle = WeekdayStyle.none,
    this.timeStyle = TimeStyle.none,
    this.dateSeparate = DateSeparate.none,
    this.separate = '',
  });

  AdvanceDate copyWith({
    DateType? type,
    DateStyle? dateStyle,
    WeekdayStyle? weekdayStyle,
    TimeStyle? timeStyle,
    DateSeparate? dateSeparate,
    String? separate,
  }) {
    return AdvanceDate(
      type: type ?? this.type,
      dateStyle: dateStyle ?? this.dateStyle,
      weekdayStyle: weekdayStyle ?? this.weekdayStyle,
      timeStyle: timeStyle ?? this.timeStyle,
      dateSeparate: dateSeparate ?? this.dateSeparate,
      separate: separate ?? this.separate,
    );
  }

  factory AdvanceDate.fromJson(Map<String, dynamic> json) => AdvanceDate(
    type: DateType.values[json['type'] ?? 0],
    dateStyle: DateStyle.values[json['dateStyle'] ?? 1],
    weekdayStyle: WeekdayStyle.values[json['weekdayStyle'] ?? 0],
    timeStyle: TimeStyle.values[json['timeStyle'] ?? 0],
    dateSeparate: DateSeparate.values[json['dateSeparate'] ?? 0],
    separate: json['separate'] ?? '',
  );

  Map<String, dynamic> toJson() => {
    'type': type.index,
    'dateStyle': dateStyle.index,
    'weekdayStyle': weekdayStyle.index,
    'timeStyle': timeStyle.index,
    'dateSeparate': dateSeparate.index,
    'separate': separate,
  };

  @override
  String toString() {
    return 'AdvanceDate{type: $type, dateStyle: $dateStyle, weekdayStyle: $weekdayStyle, timeStyle: $timeStyle, dateSeparate: $dateSeparate, separate: $separate}';
  }
}

class AdvanceMetaData {
  final MetaDataType type;
  final String prefix;
  final String suffix;

  AdvanceMetaData({
    this.type = MetaDataType.title,
    this.prefix = '',
    this.suffix = '',
  });

  AdvanceMetaData copyWith({
    MetaDataType? type,
    String? prefix,
    String? suffix,
  }) {
    return AdvanceMetaData(
      type: type ?? this.type,
      prefix: prefix ?? this.prefix,
      suffix: suffix ?? this.suffix,
    );
  }

  factory AdvanceMetaData.fromJson(Map<String, dynamic> json) =>
      AdvanceMetaData(
        type: MetaDataType.values[json['type'] ?? 0],
        prefix: json['prefix'] ?? '',
        suffix: json['suffix'] ?? '',
      );

  Map<String, dynamic> toJson() => {
    'type': type.index,
    'prefix': prefix,
    'suffix': suffix,
  };

  @override
  String toString() {
    return 'AdvanceMetaData{type: $type, prefix: $prefix, suffix: $suffix}';
  }
}

class AdvanceIndex {
  final int width;
  final int start;
  final IndexDistinction distinction;
  final DateType dateType;

  AdvanceIndex({
    this.width = 1,
    this.start = 1,
    this.distinction = IndexDistinction.none,
    this.dateType = DateType.created,
  });

  AdvanceIndex copyWith({
    int? width,
    int? start,
    IndexDistinction? distinction,
    DateType? dateType,
  }) {
    return AdvanceIndex(
      width: width ?? this.width,
      start: start ?? this.start,
      distinction: distinction ?? this.distinction,
      dateType: dateType ?? this.dateType,
    );
  }

  factory AdvanceIndex.fromJson(Map<String, dynamic> json) => AdvanceIndex(
    width: json['width'] ?? 1,
    start: json['start'] ?? 1,
    distinction: IndexDistinction.values[json['distinction'] ?? 0],
    dateType: DateType.values[json['dateType'] ?? 0],
  );

  Map<String, dynamic> toJson() => {
    'width': width,
    'start': start,
    'distinction': distinction.index,
    'dateType': dateType.index,
  };

  @override
  String toString() {
    return 'AdvanceIndex{width: $width, start: $start, distinction: $distinction, dateType: $dateType}';
  }
}
