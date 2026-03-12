import 'package:once_power/enum/advance.dart';
import 'package:once_power/enum/date.dart';
import 'package:once_power/enum/file.dart';

class AdvancePreset {
  final String id;
  final String name;
  final List<AdvanceMenuModel> menus;

  AdvancePreset({required this.id, required this.name, required this.menus});

  AdvancePreset copyWith({
    String? id,
    String? name,
    List<AdvanceMenuModel>? menus,
  }) {
    return AdvancePreset(
      id: id ?? this.id,
      name: name ?? this.name,
      menus: menus ?? this.menus,
    );
  }

  factory AdvancePreset.fromJson(Map<String, dynamic> json) {
    List<AdvanceMenuModel> menus = [];
    for (var menu in json['menus']) {
      menus.add(AdvanceMenuModel.fromJson(menu));
    }
    return AdvancePreset(id: json['id'], name: json['name'], menus: menus);
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> menusJson = [];
    for (var menu in menus) {
      menusJson.add(menu.toJson());
    }
    return {'id': id, 'name': name, 'menus': menusJson};
  }

  @override
  String toString() {
    return 'AdvancePreset{id: $id, name: $name, menus: $menus}';
  }
}

abstract class AdvanceMenuModel {
  String id;
  AdvanceType type;
  dynamic value;
  bool checked;
  String group;
  AdvanceMenuModel({
    required this.id,
    required this.type,
    required this.value,
    required this.checked,
    required this.group,
  });

  factory AdvanceMenuModel.fromJson(Map<String, dynamic> json) {
    AdvanceType advanceType = AdvanceType.values[json['type']];
    json.remove('type');
    switch (advanceType) {
      case AdvanceType.delete:
        return AdvanceMenuDelete.fromJson(json);
      case AdvanceType.add:
        return AdvanceMenuAdd.fromJson(json);
      case AdvanceType.replace:
        return AdvanceMenuReplace.fromJson(json);
    }
  }

  AdvanceMenuModel copyWith({String? id});

  Map<String, dynamic> toJson();
}

class AdvanceMenuDelete extends AdvanceMenuModel {
  final MatchContent matchContent;
  final int number;
  final int front;
  final int behind;
  final int start;
  final int end;
  final List<DeleteType> deleteTypes;
  final bool deleteExtension;
  final bool useRegex;

  AdvanceMenuDelete({
    required super.id,
    required String super.value,
    required this.matchContent,
    required this.number,
    required this.front,
    required this.behind,
    required this.start,
    required this.end,
    required this.deleteTypes,
    required this.deleteExtension,
    required this.useRegex,
    required super.group,
    required super.checked,
  }) : super(type: AdvanceType.delete);

  @override
  AdvanceMenuDelete copyWith({String? id, List<DeleteType>? deleteTypes}) {
    return AdvanceMenuDelete(
      id: id ?? this.id,
      value: value,
      matchContent: matchContent,
      number: number,
      front: front,
      behind: behind,
      start: start,
      end: end,
      deleteTypes: deleteTypes != null
          ? List<DeleteType>.from(deleteTypes)
          : List<DeleteType>.from(this.deleteTypes),
      deleteExtension: deleteExtension,
      useRegex: useRegex,
      group: group,
      checked: checked,
    );
  }

  factory AdvanceMenuDelete.fromJson(Map<String, dynamic> json) =>
      AdvanceMenuDelete(
        id: json["id"],
        value: json["value"],
        matchContent: MatchContent.values[json["matchContent"] ?? 0],
        number: json["number"] ?? 1,
        front: json["front"] ?? 1,
        behind: json["behind"] ?? 1,
        start: json["start"] ?? 1,
        end: json["end"] ?? 1,
        deleteTypes: json["deleteTypes"] == null
            ? <DeleteType>[]
            : List<DeleteType>.from(
                json["deleteTypes"].map((x) => DeleteType.values[x]),
              ),
        deleteExtension: json["deleteExtension"] ?? false,
        useRegex: json["useRegex"] ?? false,
        group: json["group"] ?? 'all',
        checked: json["checked"] ?? true,
      );

  @override
  Map<String, dynamic> toJson() => {
    "type": type.index,
    "id": id,
    "value": value,
    "matchContent": matchContent.index,
    "number": number,
    "front": front,
    "behind": behind,
    "start": start,
    "end": end,
    "deleteTypes": List<dynamic>.from(deleteTypes.map((x) => x.index)),
    "deleteExtension": deleteExtension,
    "useRegex": useRegex,
    "group": group,
    "checked": checked,
  };

  @override
  String toString() {
    return 'AdvanceMenuDelete{'
        'id: $id, '
        'value: $value, '
        'matchContent: $matchContent, '
        'number: $number, '
        'front: $front, '
        'behind: $behind, '
        'start: $start, '
        'end: $end, '
        'deleteTypes: $deleteTypes, '
        'deleteExtension: $deleteExtension, '
        'useRegex: $useRegex, '
        'group: $group, '
        'checked: $checked}';
  }
}

class AdvanceMenuAdd extends AdvanceMenuModel {
  final int digits;
  final int start;
  final DistinguishType distinguishType;
  final AddType addType;
  final int randomLen;
  final DateType dateType;
  final DateStyle dateStyle;
  final WeekdayStyle weekdayStyle;
  final TimeStyle timeStyle;
  final DateSeparateType dateSeparate;
  final String customSeparate;
  final MetaDataType metaData;
  final String metaPrefix;
  final String metaSuffix;
  final DateType distinguishDateType;
  final List<String> randomValue;
  final AddPosition addPosition;
  final int positionIndex;

  AdvanceMenuAdd({
    required super.id,
    required String super.value,
    required this.digits,
    required this.start,
    required this.distinguishType,
    required this.addType,
    required this.randomLen,
    required this.dateType,
    required this.dateStyle,
    required this.weekdayStyle,
    required this.timeStyle,
    required this.dateSeparate,
    required this.customSeparate,
    required this.metaData,
    required this.metaPrefix,
    required this.metaSuffix,
    required this.distinguishDateType,
    required this.randomValue,
    required this.addPosition,
    required this.positionIndex,
    required super.group,
    required super.checked,
  }) : super(type: AdvanceType.add);

  @override
  AdvanceMenuAdd copyWith({String? id, List<String>? randomValue}) {
    return AdvanceMenuAdd(
      id: id ?? this.id,
      value: value,
      digits: digits,
      start: start,
      distinguishType: distinguishType,
      addType: addType,
      randomLen: randomLen,
      dateType: dateType,
      dateStyle: dateStyle,
      timeStyle: timeStyle,
      weekdayStyle: weekdayStyle,
      dateSeparate: dateSeparate,
      customSeparate: customSeparate,
      metaData: metaData,
      metaPrefix: metaPrefix,
      metaSuffix: metaSuffix,
      distinguishDateType: distinguishDateType,
      randomValue: randomValue != null
          ? List<String>.from(randomValue)
          : List<String>.from(this.randomValue),
      addPosition: addPosition,
      positionIndex: positionIndex,
      group: group,
      checked: checked,
    );
  }

  factory AdvanceMenuAdd.fromJson(Map<String, dynamic> json) => AdvanceMenuAdd(
    id: json["id"],
    value: json["value"],
    digits: json["digits"] ?? 0,
    start: json["start"] ?? 1,

    distinguishType: DistinguishType.values[json["distinguishType"] ?? 0],
    addType: AddType.values[json["addType"] ?? 0],
    randomLen: json["randomLen"] ?? 1,
    dateType: DateType.values[json["dateType"] ?? 0],
    dateStyle: DateStyle.values[json["dateStyle"] ?? 1],
    weekdayStyle: WeekdayStyle.values[json["weekdayStyle"] ?? 0],
    timeStyle: TimeStyle.values[json["timeStyle"] ?? 0],
    dateSeparate: DateSeparateType.values[json["dateSeparate"] ?? 0],
    customSeparate: json["customSeparate"] ?? '',
    metaData: MetaDataType.values[json["metaData"] ?? 0],
    metaPrefix: json["metaPrefix"] ?? '',
    metaSuffix: json["metaSuffix"] ?? '',
    distinguishDateType: DateType.values[json["distinguishDateType"] ?? 0],
    randomValue: json["randomValue"] == null
        ? <String>[]
        : List<String>.from(json["randomValue"].map((x) => x)),
    addPosition: AddPosition.values[json["addPosition"] ?? 1],
    positionIndex: json["positionIndex"] ?? 1,
    group: json["group"] ?? 'all',
    checked: json["checked"] ?? true,
  );

  @override
  Map<String, dynamic> toJson() => {
    "type": type.index,
    "id": id,
    "value": value,
    "digits": digits,
    "start": start,
    "distinguishType": distinguishType.index,
    "addType": addType.index,
    "randomLen": randomLen,
    "dateType": dateType.index,
    "dateStyle": dateStyle.index,
    "weekdayStyle": weekdayStyle.index,
    "timeStyle": timeStyle.index,
    "dateSeparate": dateSeparate.index,
    "customSeparate": customSeparate,
    "metaData": metaData.index,
    "metaPrefix": metaPrefix,
    "metaSuffix": metaSuffix,
    "distinguishDateType": distinguishDateType.index,
    "randomValue": List<String>.from(randomValue.map((x) => x)),
    "addPosition": addPosition.index,
    "positionIndex": positionIndex,
    "group": group,
    "checked": checked,
  };

  @override
  String toString() {
    return 'AdvanceMenuAdd{'
        'id: $id, '
        'value: $value, '
        'digits: $digits, '
        'start: $start,  '
        'distinguishType: $distinguishType, '
        'addType: $addType, '
        'randomLen: $randomLen, '
        'dateType: $dateType, '
        'dateStyle: $dateStyle, '
        'weekdayStyle: $weekdayStyle, '
        'timeStyle: $timeStyle, '
        'dateSeparate: $dateSeparate, '
        'customSeparate: $customSeparate, '
        'metaData: $metaData, '
        'metaPrefix: $metaPrefix, '
        'metaSuffix: $metaSuffix, '
        'distinguishDateType: $distinguishDateType,'
        'randomValue: $randomValue, '
        'addPosition: $addPosition, '
        'positionIndex: $positionIndex, '
        'group: $group, '
        'checked: $checked}';
  }
}

class AdvanceMenuReplace extends AdvanceMenuModel {
  final ReplaceMode replaceMode;
  final bool useRegex;
  final bool matchExtension;
  final FillPosition fillPosition;
  final MatchContent matchContent;
  final int number;
  final int front;
  final int behind;
  final int start;
  final int end;
  final ConvertType convertType;
  final String wordSpacing;

  AdvanceMenuReplace({
    required super.id,
    required List<String> super.value,
    required this.useRegex,
    required this.matchExtension,
    required this.replaceMode,
    required this.fillPosition,
    required this.matchContent,
    required this.number,
    required this.front,
    required this.behind,
    required this.start,
    required this.end,
    required this.convertType,
    required this.wordSpacing,
    required super.group,
    required super.checked,
  }) : super(type: AdvanceType.replace);

  @override
  AdvanceMenuReplace copyWith({String? id}) {
    return AdvanceMenuReplace(
      id: id ?? this.id,
      value: value,
      useRegex: useRegex,
      matchExtension: matchExtension,
      replaceMode: replaceMode,
      fillPosition: fillPosition,
      matchContent: matchContent,
      number: number,
      front: front,
      behind: behind,
      start: start,
      end: end,
      convertType: convertType,
      wordSpacing: wordSpacing,
      group: group,
      checked: checked,
    );
  }

  factory AdvanceMenuReplace.fromJson(Map<String, dynamic> json) =>
      AdvanceMenuReplace(
        id: json["id"],
        value: json["value"] == null
            ? <String>[]
            : List<String>.from(json["value"].map((x) => x)),
        useRegex: json["useRegex"] ?? false,
        matchExtension: json["matchExtension"] ?? false,
        replaceMode: ReplaceMode.values[json["replaceMode"] ?? 0],
        fillPosition: FillPosition.values[json["fillPosition"] ?? 0],
        matchContent: MatchContent.values[json["matchContent"] ?? 0],
        number: json["number"] ?? 1,
        front: json["front"] ?? 1,
        behind: json["back"] ?? 1,
        start: json["start"] ?? 1,
        end: json["end"] ?? 1,
        convertType: ConvertType.values[json["convertType"] ?? 0],
        wordSpacing: json["wordSpacing"] ?? "",
        group: json["group"] ?? 'all',
        checked: json["checked"] ?? true,
      );

  @override
  Map<String, dynamic> toJson() => {
    "type": type.index,
    "id": id,
    "value": List<String>.from(value.map((x) => x)),
    "useRegex": useRegex,
    "matchExtension": matchExtension,
    "replaceMode": replaceMode.index,
    "fillPosition": fillPosition.index,
    "matchContent": matchContent.index,
    "number": number,
    "front": front,
    "back": behind,
    "start": start,
    "end": end,
    "convertType": convertType.index,
    "wordSpacing": wordSpacing,
    "group": group,
    "checked": checked,
  };

  @override
  String toString() {
    return 'AdvanceMenuReplace{'
        'id: $id, '
        'value: $value, '
        'useRegex: $useRegex, '
        'matchExtension: $matchExtension, '
        'replaceMode: $replaceMode, '
        'fillPosition: $fillPosition, '
        'matchContent: $matchContent, '
        'number: $number, '
        'front: $front, '
        'back: $behind, '
        'start: $start, '
        'end: $end, '
        'convertType: $convertType, '
        'wordSpacing: $wordSpacing, '
        'group: $group, '
        'checked: $checked}';
  }
}
