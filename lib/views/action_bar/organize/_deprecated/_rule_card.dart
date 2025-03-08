// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:once_power/constants/constants.dart';
// import 'package:once_power/providers/select.dart';
// import 'package:once_power/views/action_bar/advance/dialog/common_dialog.dart';
// import 'package:once_power/widgets/action_bar/folder_input.dart';
//
// import '_easy_expansion_tile.dart';
//
// class RuleCard extends ConsumerWidget {
//   const RuleCard({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final borderRadius = BorderRadius.circular(AppNum.smallG);
//
//     void showAllRule() {
//       showDialog(
//         context: context,
//         builder: (context) => CommonDialog(
//           title: '所有规则',
//           child: Expanded(
//             child: SingleChildScrollView(child: EasyExpansionTile()),
//           ),
//           onOk: () {},
//         ),
//       );
//     }
//
//     return Ink(
//       decoration: BoxDecoration(borderRadius: borderRadius),
//       child: InkWell(
//         borderRadius: borderRadius,
//         onTap: showAllRule,
//         child: Container(
//           height: AppNum.inputH,
//           padding: EdgeInsets.symmetric(horizontal: AppNum.mediumG),
//           decoration: BoxDecoration(borderRadius: borderRadius),
//           alignment: Alignment.center,
//           child: Text(
//             ref.watch(currentClassifyFileTypeProvider).label,
//             style: TextStyle(fontSize: 14),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class EasyChild extends StatelessWidget {
//   const EasyChild({super.key, required this.title});
//
//   final String title;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//           horizontal: AppNum.inputP, vertical: AppNum.smallG),
//       child: Row(
//         // spacing: AppNum.smallG,
//         children: [
//           Text('$title:'),
//           Expanded(child: FolderInput()),
//         ],
//       ),
//     );
//   }
// }
