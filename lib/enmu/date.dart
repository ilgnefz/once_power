import 'package:easy_localization/easy_localization.dart';
import 'package:once_power/constant/l10n.dart';

enum DateType { created, modified, accessed, exif, earliest, latest }

extension DateTypeExtension on DateType {
  String get label {
    switch (this) {
      case DateType.created:
        return tr(AppL10n.created);
      case DateType.modified:
        return tr(AppL10n.modified);
      case DateType.accessed:
        return tr(AppL10n.accessed);
      case DateType.exif:
        return tr(AppL10n.captured);
      case DateType.earliest:
        return tr(AppL10n.earliest);
      case DateType.latest:
        return tr(AppL10n.latest);
    }
  }

  bool get isCreated => this == DateType.created;
  bool get isModified => this == DateType.modified;
  bool get isAccessed => this == DateType.accessed;
  bool get isExif => this == DateType.exif;
  bool get isEarliest => this == DateType.earliest;
  bool get isLatest => this == DateType.latest;
}
