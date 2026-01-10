import 'package:once_power/enums/date.dart';

class DateProperty {
  String createdDate;
  bool createdDateChecked;
  String modifiedDate;
  bool modifiedDateChecked;
  String accessedDate;
  bool accessedDateChecked;
  DateDiffType diffType;
  int interval;
  DateTimeUnit dateUnit;
  bool fullReplace;

  DateProperty({
    this.createdDate = '',
    this.createdDateChecked = true,
    this.modifiedDate = '',
    this.modifiedDateChecked = true,
    this.accessedDate = '',
    this.accessedDateChecked = true,
    this.diffType = DateDiffType.add,
    this.interval = 0,
    this.dateUnit = DateTimeUnit.day,
    this.fullReplace = false,
  });

  DateProperty copyWith({
    String? createdDate,
    bool? createdDateChecked,
    String? modifiedDate,
    bool? modifiedDateChecked,
    String? accessedDate,
    bool? accessedDateChecked,
    DateDiffType? diffType,
    int? interval,
    DateTimeUnit? dateUnit,
    bool? fullReplace,
  }) {
    return DateProperty(
      createdDate: createdDate ?? this.createdDate,
      createdDateChecked: createdDateChecked ?? this.createdDateChecked,
      modifiedDate: modifiedDate ?? this.modifiedDate,
      modifiedDateChecked: modifiedDateChecked ?? this.modifiedDateChecked,
      accessedDate: accessedDate ?? this.accessedDate,
      accessedDateChecked: accessedDateChecked ?? this.accessedDateChecked,
      diffType: diffType ?? this.diffType,
      interval: interval ?? this.interval,
      dateUnit: dateUnit ?? this.dateUnit,
      fullReplace: fullReplace ?? this.fullReplace,
    );
  }

  @override
  String toString() {
    return 'DateProperty{createdDate: $createdDate, '
        'createdDateChecked: $createdDateChecked, modifiedDate: $modifiedDate,'
        ' modifiedDateChecked: $modifiedDateChecked,'
        ' accessedDate: $accessedDate, accessedDateChecked: $accessedDateChecked, '
        'diffType: $diffType, interval: $interval, dateUnit: $dateUnit, fullReplace: $fullReplace}';
  }
}
