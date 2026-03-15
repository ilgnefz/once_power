import 'package:once_power/enum/advance.dart';
import 'package:once_power/enum/date.dart';
import 'package:once_power/enum/file.dart';

import 'advance_add.dart';
import 'advance_delete.dart';
import 'advance_replace.dart';

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

class AdvanceMatch {
  final MatchContent content;
  final int contentIndex;
  final MatchPosition position;
  final int frontIndex;
  final int behindIndex;

  AdvanceMatch({
    this.content = MatchContent.number,
    this.contentIndex = 1,
    this.position = MatchPosition.self,
    this.frontIndex = 1,
    this.behindIndex = 1,
  });

  AdvanceMatch copyWith({
    MatchContent? content,
    int? contentIndex,
    MatchPosition? position,
    int? frontIndex,
    int? behindIndex,
  }) {
    return AdvanceMatch(
      content: content ?? this.content,
      contentIndex: contentIndex ?? this.contentIndex,
      position: position ?? this.position,
      frontIndex: frontIndex ?? this.frontIndex,
      behindIndex: behindIndex ?? this.behindIndex,
    );
  }

  factory AdvanceMatch.fromJson(Map<String, dynamic> json) {
    return AdvanceMatch(
      content: MatchContent.values[json['content']],
      contentIndex: json['contentIndex'],
      position: MatchPosition.values[json['position']],
      frontIndex: json['frontIndex'],
      behindIndex: json['behindIndex'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content.index,
      'contentIndex': contentIndex,
      'position': position.index,
      'frontIndex': frontIndex,
      'behindIndex': behindIndex,
    };
  }

  @override
  String toString() {
    return 'AdvanceMatch{content: $content, contentIndex: $contentIndex, position: $position, frontIndex: $frontIndex, behindIndex: $behindIndex}';
  }
}
