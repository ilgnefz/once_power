import 'package:easy_localization/easy_localization.dart';
import 'package:once_power/constants/l10n.dart';

enum ReplaceType { match, before, after, between }

extension RemoveTypeExtension on ReplaceType {
  String get label {
    switch (this) {
      case ReplaceType.match:
        return tr(AppL10n.eReplaceMatch);
      case ReplaceType.before:
        return tr(AppL10n.eReplaceBefore);
      case ReplaceType.between:
        return tr(AppL10n.eReplaceBetween);
      case ReplaceType.after:
        return tr(AppL10n.eReplaceAfter);
    }
  }
}

enum ReserveType {
  capitalLetter,
  lowercaseLetter,
  nonLetter,
  digit,
  punctuation,
}

extension ReservedTypeExtension on ReserveType {
  String get label {
    switch (this) {
      case ReserveType.capitalLetter:
        return 'ABC';
      case ReserveType.lowercaseLetter:
        return 'abc';
      case ReserveType.nonLetter:
        return '中あ조བོད';
      case ReserveType.digit:
        return '123';
      case ReserveType.punctuation:
        return '!.?';
    }
  }
}
