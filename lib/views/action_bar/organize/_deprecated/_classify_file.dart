// import 'package:flutter/material.dart';
// import 'package:once_power/generated/l10n.dart';
// import 'package:once_power/models/file_enum.dart';
//
// import '../rule_card.dart';
//
// class ClassifyFile {
//   final ClassifyFileType type;
//   final List<Widget> children;
//   ClassifyFile({required this.type, required this.children});
// }
//
// List<ClassifyFile> classifyFileList = [
//   ClassifyFile(
//     type: ClassifyFileType.type,
//     children: [
//       RuleCard(title: FileClassify.image.label),
//       RuleCard(title: FileClassify.video.label),
//       RuleCard(title: FileClassify.doc.label),
//       RuleCard(title: FileClassify.audio.label),
//       RuleCard(title: FileClassify.folder.label),
//       RuleCard(title: FileClassify.zip.label),
//       RuleCard(title: FileClassify.other.label),
//     ],
//   ),
//   ClassifyFile(type: ClassifyFileType.extension, children: []),
//   ClassifyFile(type: ClassifyFileType.name, children: []),
//   ClassifyFile(type: ClassifyFileType.time, children: []),
//   ClassifyFile(type: ClassifyFileType.folder, children: []),
// ];
//
// enum ClassifyFileType { type, extension, name, time, folder }
//
// extension ClassifyFileTypeExt on ClassifyFileType {
//   String get label {
//     switch (this) {
//       case ClassifyFileType.type:
//       return S.current.classifyType;
//       case ClassifyFileType.extension:
//       return S.current.classifyExtension;
//       case ClassifyFileType.name:
//       return S.current.classifyName;
//       case ClassifyFileType.time:
//       return S.current.classifyTime;
//       case ClassifyFileType.folder:
//       return S.current.classifyFolder;
//     }
//   }
//
//   bool isClassifyType() => this == ClassifyFileType.type;
//   bool isClassifyExtension() => this == ClassifyFileType.extension;
//   bool isClassifyName() => this == ClassifyFileType.name;
//   bool isClassifyTime() => this == ClassifyFileType.time;
//   bool isClassifyFolder() => this == ClassifyFileType.folder;
// }
