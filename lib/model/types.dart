import 'package:once_power/generated/l10n.dart';

enum LoopType { disable, all, prefix, suffix }

extension LoopTypeExtension on LoopType {
  String get value {
    switch (this) {
      case LoopType.disable:
        return S.current.disable;
      case LoopType.all:
        return S.current.useAll;
      case LoopType.prefix:
        return S.current.onlyPrefix;
      case LoopType.suffix:
        return S.current.onlySuffix;
    }
  }
}

enum ModeType { general, reserved, length }

extension ModeTypeExtension on ModeType {
  String get value {
    switch (this) {
      case ModeType.general:
        return S.current.defaultMode;
      case ModeType.reserved:
        return S.current.reservedMode;
      case ModeType.length:
        return S.current.lengthMode;
    }
  }
}

enum UploadType { prefix, suffix }

enum MessageType { failure, success, warning }

enum LanguageType {
  chinese('中文'),
  english('English');

  final String value;
  const LanguageType(this.value);
}
