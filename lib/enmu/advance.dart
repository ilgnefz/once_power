import 'package:easy_localization/easy_localization.dart';
import 'package:once_power/constant/l10n.dart';

enum DeleteMode { input, part, type, extension }

extension DeleteModeExtension on DeleteMode {
  // TODO：删除 label
  String get label {
    switch (this) {
      case DeleteMode.input:
        return tr(AppL10n.deleteInput);
      case DeleteMode.type:
        return tr(AppL10n.deleteType);
      case DeleteMode.part:
        return tr(AppL10n.deletePart);
      case DeleteMode.extension:
        return tr(AppL10n.deleteExtension);
    }
  }
}

enum DeleteType { digit, capital, lowercase, nonLetter, punctuation, space }

extension DeleteTypeExtension on DeleteType {
  String get label {
    switch (this) {
      case DeleteType.digit:
        return tr(AppL10n.deleteDigit);
      case DeleteType.capital:
        return tr(AppL10n.deleteCapital);
      case DeleteType.lowercase:
        return tr(AppL10n.deleteLowercase);
      case DeleteType.nonLetter:
        return tr(AppL10n.deleteNonLetter);
      case DeleteType.punctuation:
        return tr(AppL10n.deletePunctuation);
      case DeleteType.space:
        return tr(AppL10n.deleteSpace);
    }
  }
}

enum MatchContent { number, last, all }

extension MatchContentExtension on MatchContent {
  String get label {
    switch (this) {
      case MatchContent.number:
        return tr(AppL10n.ordinal);
      case MatchContent.last:
        return tr(AppL10n.last);
      case MatchContent.all:
        return tr(AppL10n.all);
    }
  }

  bool get isNumber => this == MatchContent.number;
  bool get isLast => this == MatchContent.last;
  bool get isAll => this == MatchContent.all;
}

enum MatchPosition { self, front, behind }

extension MatchLocationExtension on MatchPosition {
  String get label {
    switch (this) {
      case MatchPosition.self:
        return tr(AppL10n.advanceSelf);
      case MatchPosition.front:
        return tr(AppL10n.advanceFront);
      case MatchPosition.behind:
        return tr(AppL10n.advanceBehind);
    }
  }

  bool get isSelf => this == MatchPosition.self;
  bool get isFront => this == MatchPosition.front;
  bool get isBehind => this == MatchPosition.behind;
}
