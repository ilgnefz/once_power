import 'package:easy_localization/easy_localization.dart';
import 'package:once_power/constants/l10n.dart';

class GroupRule {
  InfoType infoType;
  ComparisonOperator operator;
  String value;
  String group;

  GroupRule({
    required this.infoType,
    required this.operator,
    required this.value,
    required this.group,
  });

  @override
  String toString() {
    return 'GroupRule(infoType: $infoType, operator: $operator, value: $value, group: $group)';
  }
}

enum InfoType {
  name,
  newName,
  folder,
  extension,
  createdDate,
  modifiedDate,
  accessedDate,
  capturedDate,
}

extension InfoTypeExtension on InfoType {
  String get label {
    switch (this) {
      case InfoType.name:
        return tr(AppL10n.eRuleName);
      case InfoType.newName:
        return tr(AppL10n.eRuleNewName);
      case InfoType.folder:
        return tr(AppL10n.eRuleFolder);
      case InfoType.extension:
        return tr(AppL10n.eRuleExt);
      case InfoType.createdDate:
        return tr(AppL10n.eDateCreate);
      case InfoType.modifiedDate:
        return tr(AppL10n.eDateModify);
      case InfoType.accessedDate:
        return tr(AppL10n.eDateAccess);
      case InfoType.capturedDate:
        return tr(AppL10n.eDateCapture);
    }
  }

  bool get isDateType =>
      this == InfoType.createdDate ||
      this == InfoType.modifiedDate ||
      this == InfoType.accessedDate ||
      this == InfoType.capturedDate;
}

enum ComparisonOperator {
  contain,
  notContain,
  equal,
  notEqual,
  before,
  after,
  beforeOrEqual,
  afterOrEqual
}

extension ComparisonOperatorExtension on ComparisonOperator {
  String get label {
    switch (this) {
      case ComparisonOperator.contain:
        return tr(AppL10n.eRuleContains);
      case ComparisonOperator.notContain:
        return tr(AppL10n.eRuleNotContains);
      case ComparisonOperator.equal:
        return tr(AppL10n.eRuleEqual);
      case ComparisonOperator.notEqual:
        return tr(AppL10n.eRuleNotEqual);
      case ComparisonOperator.before:
        return tr(AppL10n.eRuleBefore);
      case ComparisonOperator.after:
        return tr(AppL10n.eRuleAfter);
      case ComparisonOperator.beforeOrEqual:
        return tr(AppL10n.eRuleBeforeOrEqual);
      case ComparisonOperator.afterOrEqual:
        return tr(AppL10n.eRuleAfterOrEqual);
    }
  }
}
