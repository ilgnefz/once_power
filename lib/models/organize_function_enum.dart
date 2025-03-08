enum OrganizeFunction { rule, topParent, type, time, none }

extension OrganizeFunctionEnumExtension on OrganizeFunction {
  bool get isRule => this == OrganizeFunction.rule;
  bool get isTopParent => this == OrganizeFunction.topParent;
  bool get isType => this == OrganizeFunction.type;
  bool get isTime => this == OrganizeFunction.time;
  bool get isNone => this == OrganizeFunction.none;
}
