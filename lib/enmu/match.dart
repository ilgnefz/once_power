import 'package:easy_localization/easy_localization.dart';
import 'package:once_power/constant/l10n.dart';

enum ReplaceType { match, front, behind, between }

extension ReplaceTypeExtension on ReplaceType {
  String get label {
    switch (this) {
      case ReplaceType.match:
        return tr(AppL10n.self);
      case ReplaceType.front:
        return tr(AppL10n.front);
      case ReplaceType.behind:
        return tr(AppL10n.behind);
      case ReplaceType.between:
        return tr(AppL10n.between);
    }
  }
}

enum KeepType { capitalLetter, lowercaseLetter, nonLetter, digit, punctuation }

extension ReservedTypeExtension on KeepType {
  String get label {
    switch (this) {
      case KeepType.capitalLetter:
        return 'ABC';
      case KeepType.lowercaseLetter:
        return 'abc';
      case KeepType.nonLetter:
        return '中あ조བོད';
      case KeepType.digit:
        return '123';
      case KeepType.punctuation:
        return '!.?';
    }
  }
}
