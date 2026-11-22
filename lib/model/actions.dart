import 'package:easy_localization/easy_localization.dart';
import 'package:once_power/constant/l10n.dart';

enum PresetAction { delete, add, replace }

extension PresetActionExtension on PresetAction {
  String get label {
    switch (this) {
      case PresetAction.delete:
        return tr(AppL10n.deleteAction);
      case PresetAction.add:
        return tr(AppL10n.addAction);
      case PresetAction.replace:
        return tr(AppL10n.replaceAction);
    }
  }

  String get title {
    switch (this) {
      case PresetAction.delete:
        return tr(AppL10n.deleteMenu);
      case PresetAction.add:
        return tr(AppL10n.addMenu);
      case PresetAction.replace:
        return tr(AppL10n.replaceMenu);
    }
  }

  bool get isDelete => this == PresetAction.delete;
  bool get isAdd => this == PresetAction.add;
  bool get isReplace => this == PresetAction.replace;
}
