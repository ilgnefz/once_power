// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:once_power/provider/progress.dart';
// import 'package:once_power/widgets/click_text.dart';
//
// class LoadingView extends ConsumerWidget {
//   const LoadingView({super.key});
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     int count = ref.watch(countProvider);
//     int total = ref.watch(totalProvider);
//
//     return Center(
//         child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Image.asset('assets/images/loading.gif'),
//         const SizedBox(height: 24),
//         const ClipRRect(
//           borderRadius: BorderRadius.all(Radius.circular(8)),
//           child: SizedBox(
//             width: 400,
//             height: 8,
//             child: LinearProgressIndicator(),
//           ),
//         ),
//         const SizedBox(height: 12),
//         Text('正在添加 $count/$total'),
//         const SizedBox(height: 12),
//         SizedBox(width: 64, child: ClickText('取消', onTap: () {})),
//       ],
//     ));
//   }
// }
