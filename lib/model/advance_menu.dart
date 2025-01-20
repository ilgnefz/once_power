import 'package:once_power/model/enum.dart';

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

  Map<String, dynamic> toJson();
}

class AdvanceMenuDelete extends AdvanceMenuModel {
  final MatchLocation matchLocation;

  AdvanceMenuDelete({
    required super.id,
    required String super.value,
    required this.matchLocation,
  }) : super(type: AdvanceType.delete);

  factory AdvanceMenuDelete.fromJson(Map<String, dynamic> json) =>
      AdvanceMenuDelete(
        id: json["id"],
        value: json["value"],
        matchLocation: MatchLocation.values[json["matchLocation"]],
      );

  @override
  Map<String, dynamic> toJson() => {
        "type": type.index,
        "id": id,
        "value": value,
        "matchLocation": matchLocation.index,
      };

  @override
  String toString() {
    return 'AdvanceMenuDelete{id: $id, value: $value, matchLocation: $matchLocation}';
  }
}

class AdvanceMenuAdd extends AdvanceMenuModel {
  final int digits;
  final int start;
  final AddType addType;
  final AddPosition addPosition;

  AdvanceMenuAdd({
    required super.id,
    required String super.value,
    required this.digits,
    required this.start,
    required this.addType,
    required this.addPosition,
  }) : super(type: AdvanceType.add);

  factory AdvanceMenuAdd.fromJson(Map<String, dynamic> json) => AdvanceMenuAdd(
        id: json["id"],
        value: json["value"],
        digits: json["digits"],
        start: json["start"],
        addType: AddType.values[json["addType"]],
        addPosition: AddPosition.values[json["addPosition"]],
      );

  @override
  Map<String, dynamic> toJson() => {
        "type": type.index,
        "id": id,
        "value": value,
        "digits": digits,
        "start": start,
        "addType": addType.index,
        "addPosition": addPosition.index,
      };

  @override
  String toString() {
    return 'AdvanceMenuAdd{id: $id, value: $value, digits: $digits, start: $start, addType: $addType, addPosition: $addPosition}';
  }
}

class AdvanceMenuReplace extends AdvanceMenuModel {
  final MatchLocation matchLocation;
  final CaseType caseType;
  AdvanceMenuReplace({
    required super.id,
    required List<String> super.value,
    required this.matchLocation,
    required this.caseType,
  }) : super(type: AdvanceType.replace);

  factory AdvanceMenuReplace.fromJson(Map<String, dynamic> json) =>
      AdvanceMenuReplace(
        id: json["id"],
        value: List<String>.from(json["value"].map((x) => x)),
        matchLocation: MatchLocation.values[json["matchLocation"]],
        caseType: CaseType.values[json["caseType"]],
      );

  @override
  Map<String, dynamic> toJson() => {
        "type": type.index,
        "id": id,
        "value": List<String>.from(value.map((x) => x)),
        "matchLocation": matchLocation.index,
        "caseType": caseType.index,
      };

  @override
  String toString() {
    return 'AdvanceMenuReplace{id: $id, value: $value, matchLocation: $matchLocation, caseType: $caseType}';
  }
}
