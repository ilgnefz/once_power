import 'advance_menu_enum.dart';
import 'two_re_enum.dart';

class AdvancePreset {
  final String id;
  final String name;
  final List<AdvanceMenuModel> menus;

  AdvancePreset({required this.id, required this.name, required this.menus});

  factory AdvancePreset.fromJson(Map<String, dynamic> json) {
    List<AdvanceMenuModel> menus = [];
    for (var menu in json['menus']) {
      menus.add(AdvanceMenuModel.fromJson(menu));
    }
    return AdvancePreset(
      id: json['id'],
      name: json['name'],
      menus: menus,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> menusJson = [];
    for (var menu in menus) {
      menusJson.add(menu.toJson());
    }
    return {
      'id': id,
      'name': name,
      'menus': menusJson,
    };
  }
}

abstract class AdvanceMenuModel {
  String id;
  AdvanceType type;
  dynamic value;
  bool checked;
  AdvanceMenuModel({
    required this.id,
    required this.type,
    required this.value,
    required this.checked,
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
  final MatchLocation matchLocation;
  final int start;
  final int end;
  final List<DeleteType> deleteTypes;
  final bool deleteExt;

  AdvanceMenuDelete({
    required super.id,
    required super.checked,
    required String super.value,
    required this.matchLocation,
    required this.start,
    required this.end,
    required this.deleteTypes,
    required this.deleteExt,
  }) : super(type: AdvanceType.delete);

  @override
  AdvanceMenuDelete copyWith({
    String? id,
    List<DeleteType>? deleteTypes,
  }) {
    return AdvanceMenuDelete(
      id: id ?? this.id,
      checked: checked,
      value: value,
      matchLocation: matchLocation,
      start: start,
      end: end,
      deleteTypes: deleteTypes != null
          ? List<DeleteType>.from(deleteTypes) // 创建新数组
          : List<DeleteType>.from(this.deleteTypes),
      deleteExt: deleteExt,
    );
  }

  factory AdvanceMenuDelete.fromJson(Map<String, dynamic> json) =>
      AdvanceMenuDelete(
        id: json["id"],
        checked: json["checked"] ?? true,
        value: json["value"],
        matchLocation: MatchLocation.values[json["matchLocation"] ?? 0],
        start: json["start"] ?? 1,
        end: json["end"] ?? 1,
        deleteTypes: json["deleteTypes"] == null
            ? <DeleteType>[]
            : List<DeleteType>.from(
                json["deleteTypes"].map((x) => DeleteType.values[x])),
        deleteExt: json["deleteExt"] ?? false,
      );

  @override
  Map<String, dynamic> toJson() => {
        "type": type.index,
        "id": id,
        "checked": checked,
        "value": value,
        "matchLocation": matchLocation.index,
        "start": start,
        "end": end,
        "deleteTypes": List<dynamic>.from(deleteTypes.map((x) => x.index)),
        "deleteExt": deleteExt,
      };

  @override
  String toString() {
    return 'AdvanceMenuDelete{'
        'id: $id, '
        'checked: $checked, '
        'value: $value, '
        'matchLocation: $matchLocation, '
        'start: $start, '
        'end: $end, '
        'deleteTypes: $deleteTypes, '
        'deleteExt: $deleteExt}';
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
    required this.addPosition,
    required this.posIndex,
  }) : super(type: AdvanceType.add);

  @override
  AdvanceMenuAdd copyWith({
    String? id,
    List<String>? randomValue,
  }) {
    return AdvanceMenuAdd(
      id: id ?? this.id,
      checked: checked,
      value: value,
      digits: digits,
      start: start,
      randomValue: randomValue != null
          ? List<String>.from(randomValue) // 创建新数组
          : List<String>.from(this.randomValue),
      distinguishType: distinguishType,
      addType: addType,
      randomLen: randomLen,
      dateType: dateType,
      addPosition: addPosition,
      posIndex: posIndex,
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
        addPosition: AddPosition.values[json["addPosition"] ?? 1],
        posIndex: json["posIndex"] ?? 1,
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
        "addPosition": addPosition.index,
        "posIndex": posIndex,
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
        'addPosition: $addPosition, '
        'posIndex: $posIndex}';
  }
}

class AdvanceMenuReplace extends AdvanceMenuModel {
  final ReplaceMode replaceMode;
  final FillPosition fillPosition;
  final MatchLocation matchLocation;
  final int start;
  final int end;
  final CaseType caseType;
  final String wordSpacing;
  AdvanceMenuReplace({
    required super.id,
    required super.checked,
    required List<String> super.value,
    required this.replaceMode,
    required this.fillPosition,
    required this.matchLocation,
    required this.start,
    required this.end,
    required this.caseType,
    required this.wordSpacing,
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
      start: start,
      end: end,
      caseType: caseType,
      wordSpacing: wordSpacing,
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
        matchLocation: MatchLocation.values[json["matchLocation"] ?? 0],
        start: json["start"] ?? 1,
        end: json["end"] ?? 1,
        caseType: CaseType.values[json["caseType"] ?? 0],
        wordSpacing: json["wordSpacing"] ?? "",
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
        "start": start,
        "end": end,
        "caseType": caseType.index,
        "wordSpacing": wordSpacing,
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
        'start: $start, '
        'end: $end, '
        'caseType: $caseType, '
        'wordSpacing: $wordSpacing}';
  }
}
