class DateProperty {
  String createdDate;
  bool createdDateChecked;
  String modifiedDate;
  bool modifiedDateChecked;
  String accessedDate;
  bool accessedDateChecked;

  DateProperty({
    this.createdDate = '',
    this.createdDateChecked = true,
    this.modifiedDate = '',
    this.modifiedDateChecked = true,
    this.accessedDate = '',
    this.accessedDateChecked = true,
  });

  DateProperty copyWith({
    String? createdDate,
    bool? createdDateChecked,
    String? modifiedDate,
    bool? modifiedDateChecked,
    String? accessedDate,
    bool? accessedDateChecked,
  }) {
    return DateProperty(
      createdDate: createdDate ?? this.createdDate,
      createdDateChecked: createdDateChecked ?? this.createdDateChecked,
      modifiedDate: modifiedDate ?? this.modifiedDate,
      modifiedDateChecked: modifiedDateChecked ?? this.modifiedDateChecked,
      accessedDate: accessedDate ?? this.accessedDate,
      accessedDateChecked: accessedDateChecked ?? this.accessedDateChecked,
    );
  }

  @override
  String toString() {
    return 'DateProperty{createdDate: $createdDate, createdDateChecked: $createdDateChecked, modifiedDate: $modifiedDate, modifiedDateChecked: $modifiedDateChecked, accessedDate: $accessedDate, accessedDateChecked: $accessedDateChecked}';
  }
}
