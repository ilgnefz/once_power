// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:once_power/constants/constants.dart';
// import 'package:once_power/providers/select.dart';
// import 'package:once_power/widgets/common/click_icon.dart';
//
// import '_classify_file.dart';
//
// class EasyExpansionTile extends ConsumerStatefulWidget {
//   const EasyExpansionTile({super.key});
//
//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() =>
//       _EasyExpansionTileState();
// }
//
// class _EasyExpansionTileState extends ConsumerState<EasyExpansionTile> {
//   ExpansionPanelRadio buildExpansionPanelRadio({
//     required bool select,
//     required String title,
//     required void Function() onTap,
//     required List<Widget> children,
//   }) {
//     return ExpansionPanelRadio(
//       value: UniqueKey(),
//       canTapOnHeader: true,
//       headerBuilder: (context, isExpanded) => ListTile(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
//         title: Row(
//           spacing: AppNum.smallG,
//           children: [
//             ClickIcon(
//               icon: select ? Icons.check_circle_rounded : Icons.circle_outlined,
//               color: Theme.of(context).primaryColor,
//               onTap: onTap,
//             ),
//             Text(title),
//           ],
//         ),
//       ),
//       backgroundColor: Colors.white,
//       body: Column(
//         children: children.isEmpty
//             ? [
//                 Container(
//                   height: AppNum.inputH,
//                   alignment: Alignment.center,
//                   child: Text('暂无任何内容'),
//                 )
//               ]
//             : children,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ExpansionPanelList.radio(
//       dividerColor: Colors.transparent,
//       materialGapSize: 0,
//       elevation: 0,
//       expandedHeaderPadding: EdgeInsets.zero,
//       children: [
//         ...classifyFileList.map((e) {
//           return buildExpansionPanelRadio(
//             select: ref.watch(currentClassifyFileTypeProvider) == e.type,
//             title: e.type.label,
//             children: e.children,
//             onTap: () {
//               ref.read(currentClassifyFileTypeProvider.notifier).update(e.type);
//             },
//           );
//         }),
//       ],
//     );
//   }
// }
