import 'package:once_power/enums/advance.dart';
import 'package:once_power/enums/file.dart';

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
  final MatchContent matchLocation;
  final int start;
  final int end;
  final int front;
  final int back;
  final List<DeleteType> deleteTypes;
  final bool deleteExt;
  final bool useRegex;

  AdvanceMenuDelete({
    required super.id,
    required super.checked,
    required String super.value,
    required this.matchLocation,
    required this.front,
    required this.back,
    required this.start,
    required this.end,
    required this.deleteTypes,
    required this.deleteExt,
    required this.useRegex,
    required super.group,
  }) : super(type: AdvanceType.delete);

  @override
  AdvanceMenuDelete copyWith({String? id, List<DeleteType>? deleteTypes}) {
    return AdvanceMenuDelete(
      id: id ?? this.id,
      checked: checked,
      value: value,
      matchLocation: matchLocation,
      front: front,
      back: back,
      start: start,
      end: end,
      deleteTypes: deleteTypes != null
          ? List<DeleteType>.from(deleteTypes)
          : List<DeleteType>.from(this.deleteTypes),
      deleteExt: deleteExt,
      useRegex: useRegex,
      group: group,
    );
  }

  factory AdvanceMenuDelete.fromJson(Map<String, dynamic> json) =>
      AdvanceMenuDelete(
        id: json["id"],
        checked: json["checked"] ?? true,
        value: json["value"],
        matchLocation: MatchContent.values[json["matchLocation"] ?? 0],
        front: json["front"] ?? 1,
        back: json["back"] ?? 1,
        start: json["start"] ?? 1,
        end: json["end"] ?? 1,
        deleteTypes: json["deleteTypes"] == null
            ? <DeleteType>[]
            : List<DeleteType>.from(
                json["deleteTypes"].map((x) => DeleteType.values[x]),
              ),
        deleteExt: json["deleteExt"] ?? false,
        useRegex: json["useRegex"] ?? false,
        group: json["group"] ?? 'all',
      );

  @override
  Map<String, dynamic> toJson() => {
    "type": type.index,
    "id": id,
    "checked": checked,
    "value": value,
    "matchLocation": matchLocation.index,
    "front": front,
    "back": back,
    "start": start,
    "end": end,
    "deleteTypes": List<dynamic>.from(deleteTypes.map((x) => x.index)),
    "deleteExt": deleteExt,
    "useRegex": useRegex,
    "group": group,
  };

  @override
  String toString() {
    return 'AdvanceMenuDelete{'
        'id: $id, '
        'checked: $checked, '
        'value: $value, '
        'matchLocation: $matchLocation, '
        'front: $front, '
        'back: $back, '
        'start: $start, '
        'end: $end, '
        'deleteTypes: $deleteTypes, '
        'deleteExt: $deleteExt, '
        'useRegex: $useRegex, '
        'group: $group}';
  }
}

class AdvanceMenuAdd extends AdvanceMenuModel {
  final int digits;
  final int start;
  final List<String> randomValue;
  final DistinguishType distinguishType;
  final AddType addType;
  final int randomLen;
  final DateType dateType;
  final DateSplitType dateSplit;
  final FileMetaData metaData;
  final AddPosition addPosition;
  final int posIndex;

  AdvanceMenuAdd({
    required super.id,
    required super.checked,
    required String super.value,
    required this.digits,
    required this.start,
    required this.randomValue,
    required this.distinguishType,
    required this.addType,
    required this.randomLen,
    required this.dateType,
    required this.dateSplit,
    required this.metaData,
    required this.addPosition,
    required this.posIndex,
    required super.group,
  }) : super(type: AdvanceType.add);

  @override
  AdvanceMenuAdd copyWith({String? id, List<String>? randomValue}) {
    return AdvanceMenuAdd(
      id: id ?? this.id,
      checked: checked,
      value: value,
      digits: digits,
      start: start,
      randomValue: randomValue != null
          ? List<String>.from(randomValue)
          : List<String>.from(this.randomValue),
      distinguishType: distinguishType,
      addType: addType,
      randomLen: randomLen,
      dateType: dateType,
      dateSplit: dateSplit,
      metaData: metaData,
      addPosition: addPosition,
      posIndex: posIndex,
      group: group,
    );
  }

  factory AdvanceMenuAdd.fromJson(Map<String, dynamic> json) => AdvanceMenuAdd(
    id: json["id"],
    checked: json["checked"] ?? true,
    value: json["value"],
    digits: json["digits"] ?? 0,
    start: json["start"] ?? 1,
    randomValue: json["randomValue"] == null
        ? <String>[]
        : List<String>.from(json["randomValue"].map((x) => x)),
    distinguishType: DistinguishType.values[json["distinguishType"] ?? 0],
    addType: AddType.values[json["addType"] ?? 0],
    randomLen: json["randomLen"] ?? 1,
    dateType: DateType.values[json["dateType"] ?? 0],
    dateSplit: DateSplitType.values[json["dateSplit"] ?? 0],
    metaData: FileMetaData.values[json["metaData"] ?? 0],
    addPosition: AddPosition.values[json["addPosition"] ?? 1],
    posIndex: json["posIndex"] ?? 1,
    group: json["group"] ?? 'all',
  );

  @override
  Map<String, dynamic> toJson() => {
    "type": type.index,
    "id": id,
    "checked": checked,
    "value": value,
    "digits": digits,
    "start": start,
    "randomValue": List<String>.from(randomValue.map((x) => x)),
    "distinguishType": distinguishType.index,
    "addType": addType.index,
    "randomLen": randomLen,
    "dateType": dateType.index,
    "dateSplit": dateSplit.index,
    "metaData": metaData.index,
    "addPosition": addPosition.index,
    "posIndex": posIndex,
    "group": group,
  };

  @override
  String toString() {
    return 'AdvanceMenuAdd{'
        'id: $id, '
        'checked: $checked, '
        'value: $value, '
        'digits: $digits, '
        'start: $start,  '
        'randomValue: $randomValue, '
        'distinguishType: $distinguishType, '
        'addType: $addType, '
        'randomLen: $randomLen, '
        'dateType: $dateType, '
        'dateSplit: $dateSplit, '
        'metaData: $metaData, '
        'addPosition: $addPosition, '
        'posIndex: $posIndex, '
        'group: $group}';
  }
}

class AdvanceMenuReplace extends AdvanceMenuModel {
  final ReplaceMode replaceMode;
  final FillPosition fillPosition;
  final MatchContent matchLocation;
  final int front;
  final int back;
  final int start;
  final int end;
  final ConvertType convertType;
  final String wordSpacing;
  final bool useRegex;
  final bool matchExt;

  AdvanceMenuReplace({
    required super.id,
    required super.checked,
    required List<String> super.value,
    required this.replaceMode,
    required this.fillPosition,
    required this.matchLocation,
    required this.front,
    required this.back,
    required this.start,
    required this.end,
    required this.convertType,
    required this.wordSpacing,
    required this.useRegex,
    required this.matchExt,
    required super.group,
  }) : super(type: AdvanceType.replace);

  @override
  AdvanceMenuReplace copyWith({String? id}) {
    return AdvanceMenuReplace(
      id: id ?? this.id,
      checked: checked,
      value: value,
      replaceMode: replaceMode,
      fillPosition: fillPosition,
      matchLocation: matchLocation,
      front: front,
      back: back,
      start: start,
      end: end,
      convertType: convertType,
      wordSpacing: wordSpacing,
      useRegex: useRegex,
      matchExt: matchExt,
      group: group,
    );
  }

  factory AdvanceMenuReplace.fromJson(Map<String, dynamic> json) =>
      AdvanceMenuReplace(
        id: json["id"],
        checked: json["checked"] ?? true,
        value: json["value"] == null
            ? <String>[]
            : List<String>.from(json["value"].map((x) => x)),
        replaceMode: ReplaceMode.values[json["replaceMode"] ?? 0],
        fillPosition: FillPosition.values[json["fillPosition"] ?? 0],
        matchLocation: MatchContent.values[json["matchLocation"] ?? 0],
        front: json["front"] ?? 1,
        back: json["back"] ?? 1,
        start: json["start"] ?? 1,
        end: json["end"] ?? 1,
        convertType: ConvertType.values[json["convertType"] ?? 0],
        wordSpacing: json["wordSpacing"] ?? "",
        useRegex: json["useRegex"] ?? false,
        matchExt: json["matchExt"] ?? false,
        group: json["group"] ?? 'all',
      );

  @override
  Map<String, dynamic> toJson() => {
    "type": type.index,
    "id": id,
    "checked": checked,
    "value": List<String>.from(value.map((x) => x)),
    "replaceMode": replaceMode.index,
    "fillPosition": fillPosition.index,
    "matchLocation": matchLocation.index,
    "front": front,
    "back": back,
    "start": start,
    "end": end,
    "convertType": convertType.index,
    "wordSpacing": wordSpacing,
    "useRegex": useRegex,
    "matchExt": matchExt,
    "group": group,
  };

  @override
  String toString() {
    return 'AdvanceMenuReplace{'
        'id: $id, '
        'checked: $checked, '
        'value: $value, '
        'replaceMode: $replaceMode, '
        'fillPosition: $fillPosition, '
        'matchLocation: $matchLocation, '
        'front: $front, '
        'back: $back, '
        'start: $start, '
        'end: $end, '
        'convertType: $convertType, '
        'wordSpacing: $wordSpacing, '
        'useRegex: $useRegex, '
        'matchExt: $matchExt, '
        'group: $group}';
  }
}
