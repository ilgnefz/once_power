import 'package:easy_localization/easy_localization.dart';
import 'package:once_power/constant/l10n.dart';

enum DeleteMode { enter, part, type, extension }

extension DeleteModeExtension on DeleteMode {
  // TODO：删除 label
  String get label {
    switch (this) {
      case DeleteMode.enter:
        return tr(AppL10n.advanceEnter);
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

enum DeleteExtensionType { all, type, input }

extension ExtensionTypeExtension on DeleteExtensionType {
  String get label {
    switch (this) {
      case DeleteExtensionType.all:
        return tr(AppL10n.all);
      case DeleteExtensionType.type:
        return '';
      case DeleteExtensionType.input:
        return '';
    }
  }

  bool get isAll => this == DeleteExtensionType.all;
  bool get isType => this == DeleteExtensionType.type;
  bool get isInput => this == DeleteExtensionType.input;
}
