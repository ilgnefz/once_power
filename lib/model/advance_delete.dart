import 'package:once_power/enum/advance.dart';

import 'advance.dart';

class AdvanceMenuDelete extends AdvanceMenuModel {
  final bool useRegex;
  final DeleteMode mode;
  final int start;
  final int length;
  final AdvanceMatch match;
  final List<DeleteType> deleteTypes;

  AdvanceMenuDelete({
    required super.id,
    required String super.value,
    required this.mode,
    required this.useRegex,
    required this.start,
    required this.length,
    required this.match,
    required this.deleteTypes,
    required super.group,
    required super.checked,
  }) : super(type: AdvanceType.delete);

  @override
  AdvanceMenuDelete copyWith({String? id}) {
    return AdvanceMenuDelete(
      id: id ?? this.id,
      value: value,
      useRegex: useRegex,
      mode: mode,
      start: start,
      length: length,
      match: match,
      deleteTypes: deleteTypes,
      group: group,
      checked: checked,
    );
  }

  factory AdvanceMenuDelete.fromJson(Map<String, dynamic> json) =>
      AdvanceMenuDelete(
        id: json["id"],
        value: json["value"] ?? '',
        useRegex: json["useRegex"] ?? false,
        mode: DeleteMode.values[json["mode"] ?? 0],
        start: json["start"] ?? 1,
        length: json["length"] ?? 1,
        match: AdvanceMatch.fromJson(json["match"]),
        deleteTypes: json["deleteTypes"] == null
            ? <DeleteType>[]
            : List<DeleteType>.from(
                json["deleteTypes"].map((x) => DeleteType.values[x]),
              ),
        group: json["group"] ?? 'all',
        checked: json["checked"] ?? true,
      );

  @override
  Map<String, dynamic> toJson() => {
    "type": type.index,
    "id": id,
    "value": value,
    "useRegex": useRegex,
    "mode": mode.index,
    "start": start,
    "length": length,
    "match": match.toJson(),
    "deleteTypes": List<dynamic>.from(deleteTypes.map((x) => x.index)),
    "group": group,
    "checked": checked,
  };

  @override
  String toString() {
    return 'AdvanceMenuDelete{'
        'id: $id, '
        'value: $value, '
        'useRegex: $useRegex, '
        'mode: $mode, '
        'start: $start, '
        'length: $length, '
        'match: $match, '
        'deleteTypes: $deleteTypes, '
        'group: $group, '
        'checked: $checked}';
  }
}
