class CsvRenameInfo {
  String nameA;
  String nameB;

  CsvRenameInfo({required this.nameA, required this.nameB});

  @override
  String toString() {
    return 'CsvRenameInfo(nameA: $nameA, nameB: $nameB)';
  }
}
