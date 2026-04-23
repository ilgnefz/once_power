import 'package:once_power/enum/date.dart';
import 'package:once_power/enum/rule.dart';

class GroupRule {
  InfoType infoType;
  ComparisonOperator operator;
  String value;
  String group;

  GroupRule({
    required this.infoType,
    this.operator = ComparisonOperator.contain,
    required this.value,
    this.group = '',
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

class DateGroupInfo {
  DateType type;
  bool year;
  bool month;
  bool day;
  bool week;

  DateGroupInfo({
    this.type = DateType.created,
    this.year = true,
    this.month = true,
    this.day = false,
    this.week = false,
  });

  DateGroupInfo copyWith({
    DateType? type,
    bool? year,
    bool? month,
    bool? day,
    bool? week,
  }) {
    return DateGroupInfo(
      type: type ?? this.type,
      year: year ?? this.year,
      month: month ?? this.month,
      day: day ?? this.day,
      week: week ?? this.week,
    );
  }

  @override
  String toString() {
    return 'DateGroup(type: $type, year: $year, month: $month, day: $day, week: $week)';
  }
}
