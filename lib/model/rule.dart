import 'package:once_power/enum/rule.dart';

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

class FilterRule {
  InfoType infoType;
  ComparisonOperator operator;
  String value;
  ActionType action;

  FilterRule({
    required this.infoType,
    required this.operator,
    required this.value,
    required this.action,
  });

  @override
  String toString() {
    return 'FilterRule(infoType: $infoType, operator: $operator, value: $value, actionType: $action)';
  }
}
