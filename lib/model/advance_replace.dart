import 'package:once_power/enum/advance.dart';

import 'advance.dart';

class AdvanceMenuReplace extends AdvanceMenuModel {
  final ReplaceMode mode;
  final bool useRegex;
  final bool matchExtension;
  final FillPosition fillPosition;
  final int start;
  final int length;
  final AdvanceMatch match;
  final ConvertType convertType;
  final String wordSpacing;

  AdvanceMenuReplace({
    required super.id,
    required List<String> super.value,
    required this.useRegex,
    required this.matchExtension,
    required this.mode,
    required this.fillPosition,
    required this.start,
    required this.length,
    required this.match,
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
      mode: mode,
      fillPosition: fillPosition,
      start: start,
      length: length,
      match: match,
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
        mode: ReplaceMode.values[json["mode"] ?? 0],
        fillPosition: FillPosition.values[json["fillPosition"] ?? 0],
        start: json["start"] ?? 1,
        length: json["length"] ?? 1,
        match: AdvanceMatch.fromJson(json["match"]),
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
    "mode": mode.index,
    "fillPosition": fillPosition.index,
    "start": start,
    "length": length,
    "match": match.toJson(),
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
        'mode: $mode, '
        'fillPosition: $fillPosition, '
        'start: $start, '
        'length: $length, '
        'match: $match, '
        'convertType: $convertType, '
        'wordSpacing: $wordSpacing, '
        'group: $group, '
        'checked: $checked}';
  }
}
