import 'advance_menu_enum.dart';

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
  AdvanceMenuModel({required this.id, required this.type, required this.value});

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
    required String super.value,
    required this.matchLocation,
    required this.start,
    required this.end,
    required this.deleteTypes,
    required this.deleteExt,
  }) : super(type: AdvanceType.delete);

  @override
  AdvanceMenuDelete copyWith({String? id}) {
    return AdvanceMenuDelete(
      id: id ?? this.id,
      value: value,
      matchLocation: matchLocation,
      start: start,
      end: end,
      deleteTypes: deleteTypes,
      deleteExt: deleteExt,
    );
  }

  factory AdvanceMenuDelete.fromJson(Map<String, dynamic> json) =>
      AdvanceMenuDelete(
        id: json["id"],
        value: json["value"],
        matchLocation: MatchLocation.values[json["matchLocation"]],
        start: json["start"],
        end: json["end"],
        deleteTypes: List<DeleteType>.from(
            json["deleteTypes"].map((x) => DeleteType.values[x])),
        deleteExt: json["deleteExt"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "type": type.index,
        "id": id,
        "value": value,
        "matchLocation": matchLocation.index,
        "start": start,
        "end": end,
        "deleteTypes": List<dynamic>.from(deleteTypes.map((x) => x.index)),
        "deleteExt": deleteExt,
      };

  @override
  String toString() {
    return 'AdvanceMenuDelete{id: $id, value: $value, matchLocation: $matchLocation, start: $start, end: $end, deleteTypes: $deleteTypes, deleteExt: $deleteExt}';
  }
}

class AdvanceMenuAdd extends AdvanceMenuModel {
  final int digits;
  final int start;
  final List<String> randomValue;
  final DistinguishType distinguishType;
  final AddType addType;
  final int randomLen;
  final AddPosition addPosition;
  final int posIndex;

  AdvanceMenuAdd({
    required super.id,
    required String super.value,
    required this.digits,
    required this.start,
    required this.randomValue,
    required this.distinguishType,
    required this.addType,
    required this.randomLen,
    required this.addPosition,
    required this.posIndex,
  }) : super(type: AdvanceType.add);

  @override
  AdvanceMenuAdd copyWith({String? id}) {
    return AdvanceMenuAdd(
      id: id ?? this.id,
      value: value,
      digits: digits,
      start: start,
      randomValue: randomValue,
      distinguishType: distinguishType,
      addType: addType,
      randomLen: randomLen,
      addPosition: addPosition,
      posIndex: posIndex,
    );
  }

  factory AdvanceMenuAdd.fromJson(Map<String, dynamic> json) => AdvanceMenuAdd(
        id: json["id"],
        value: json["value"],
        digits: json["digits"],
        start: json["start"],
        randomValue: List<String>.from(json["randomValue"].map((x) => x)),
        distinguishType: DistinguishType.values[json["distinguishType"]],
        addType: AddType.values[json["addType"]],
        randomLen: json["randomLen"],
        addPosition: AddPosition.values[json["addPosition"]],
        posIndex: json["posIndex"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "type": type.index,
        "id": id,
        "value": value,
        "digits": digits,
        "start": start,
        "randomValue": List<String>.from(randomValue.map((x) => x)),
        "distinguishType": distinguishType.index,
        "addType": addType.index,
        "randomLen": randomLen,
        "addPosition": addPosition.index,
        "posIndex": posIndex,
      };

  @override
  String toString() {
    return 'AdvanceMenuAdd{id: $id, value: $value, digits: $digits, start: $start,  randomValue: $randomValue,  distinguishType: $distinguishType, addType: $addType, randomLen: $randomLen, addPosition: $addPosition, posIndex: $posIndex}';
  }
}

class AdvanceMenuReplace extends AdvanceMenuModel {
  final ReplaceMode replaceMode;
  final FillPosition fillPosition;
  final MatchLocation matchLocation;
  final int start;
  final int end;
  final CaseType caseType;

  AdvanceMenuReplace({
    required super.id,
    required List<String> super.value,
    required this.replaceMode,
    required this.fillPosition,
    required this.matchLocation,
    required this.start,
    required this.end,
    required this.caseType,
  }) : super(type: AdvanceType.replace);

  @override
  AdvanceMenuReplace copyWith({String? id}) {
    return AdvanceMenuReplace(
      id: id ?? this.id,
      value: value,
      replaceMode: replaceMode,
      fillPosition: fillPosition,
      matchLocation: matchLocation,
      start: start,
      end: end,
      caseType: caseType,
    );
  }

  factory AdvanceMenuReplace.fromJson(Map<String, dynamic> json) =>
      AdvanceMenuReplace(
        id: json["id"],
        value: List<String>.from(json["value"].map((x) => x)),
        replaceMode: ReplaceMode.values[json["replaceMode"]],
        fillPosition: FillPosition.values[json["fillPosition"]],
        matchLocation: MatchLocation.values[json["matchLocation"]],
        start: json["start"],
        end: json["end"],
        caseType: CaseType.values[json["caseType"]],
      );

  @override
  Map<String, dynamic> toJson() => {
        "type": type.index,
        "id": id,
        "value": List<String>.from(value.map((x) => x)),
        "replaceMode": replaceMode.index,
        "fillPosition": fillPosition.index,
        "matchLocation": matchLocation.index,
        "start": start,
        "end": end,
        "caseType": caseType.index,
      };

  @override
  String toString() {
    return 'AdvanceMenuReplace{id: $id, value: $value, replaceMode: $replaceMode, fillPosition: $fillPosition, matchLocation: $matchLocation, start: $start, end: $end, caseType: $caseType}';
  }
}
