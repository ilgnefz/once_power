import 'package:easy_localization/easy_localization.dart';
import 'package:once_power/constant/l10n.dart';

enum ReplaceMode { input, part, format, convert, swap, inserter }

extension ReplaceModeExtension on ReplaceMode {
  String get label {
    switch (this) {
      case ReplaceMode.input:
        return tr(AppL10n.advanceEnter);
      case ReplaceMode.part:
        return tr(AppL10n.deletePart);
      case ReplaceMode.format:
        return tr(AppL10n.replaceFormat);
      case ReplaceMode.convert:
        return tr(AppL10n.replaceConvert);
      case ReplaceMode.swap:
        return tr(AppL10n.replaceSwap);
      case ReplaceMode.inserter:
        return tr(AppL10n.replaceWord);
    }
  }

  bool get isNormal => this == ReplaceMode.input;
  bool get isPart => this == ReplaceMode.part;
  bool get isFormat => this == ReplaceMode.format;
  bool get isConvert => this == ReplaceMode.convert;
  bool get isSwap => this == ReplaceMode.swap;
  bool get isSeparator => this == ReplaceMode.inserter;
}

enum FillPosition { front, behind }

extension FillPositionExtension on FillPosition {
  String get label {
    switch (this) {
      case FillPosition.front:
        return tr(AppL10n.replaceFront);
      case FillPosition.behind:
        return tr(AppL10n.replaceBehind);
    }
  }

  bool get isFront => this == FillPosition.front;
  bool get isBehind => this == FillPosition.behind;
}

enum ConvertType { uppercase, lowercase, toggleCase, traditional, simplified }

extension ConvertTypeExtension on ConvertType {
  String get label {
    switch (this) {
      case ConvertType.uppercase:
        return tr(AppL10n.replaceUpper);
      case ConvertType.lowercase:
        return tr(AppL10n.replaceLower);
      case ConvertType.toggleCase:
        return tr(AppL10n.replaceToggle);
      case ConvertType.traditional:
        return tr(AppL10n.replaceTradition);
      case ConvertType.simplified:
        return tr(AppL10n.replaceSimplified);
    }
  }

  bool get isUppercase => this == ConvertType.uppercase;
  bool get isLowercase => this == ConvertType.lowercase;
  bool get isToggleCase => this == ConvertType.toggleCase;
  bool get isTraditional => this == ConvertType.traditional;
  bool get isSimplified => this == ConvertType.simplified;
}

enum SwapType { reverse, custom }

extension SwapTypeExtension on SwapType {
  String get label {
    switch (this) {
      case SwapType.reverse:
        return tr(AppL10n.replaceReverse);
      case SwapType.custom:
        return tr(AppL10n.ordinal);
    }
  }

  bool get isReverse => this == SwapType.reverse;
  bool get isCustom => this == SwapType.custom;
}
