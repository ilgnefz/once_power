import 'package:once_power/model/file.dart';

class NormalInfo {
  final String match;
  final String modify;
  final bool isLen;
  final bool caseSen;

  NormalInfo({
    required this.match,
    required this.modify,
    required this.isLen,
    required this.caseSen,
  });
}

// class NormalIndexInfo {
//   final String date;
//   final bool caseFile;
//   final bool caseExt;
//   final bool isDate;
//   final int index;
//   final FileInfo file;
//   final Map<String, dynamic> classifyMap;
//
//   NormalIndexInfo({
//     required this.date,
//     required this.caseFile,
//     required this.caseExt,
//     required this.isDate,
//     required this.index,
//     required this.file,
//     required this.classifyMap,
//   });
// }
