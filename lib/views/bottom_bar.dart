import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/widgets/click_text.dart';

import '../constants/constants.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    const String over = '加载完成';
    const String loading = '加载中';
    const TextStyle style = TextStyle(fontSize: 12, color: Colors.grey);

    return Container(
      height: AppNum.bottomBarH,
      padding: const EdgeInsets.symmetric(horizontal: AppNum.bottomBarP),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: AppColors.line, width: 1)),
      ),
      child: Consumer(
        builder: (context, ref, child) {
          int count = ref.watch(countProvider);
          int total = ref.watch(totalProvider);

          return Row(
            children: [
              Text('$count/$total', style: style),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: AppNum.gapW),
                width: 100,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  child: LinearProgressIndicator(
                    value: count == total ? 1 : count / total,
                  ),
                ),
              ),
              Text(count == total ? over : loading, style: style),
              ClickText(
                '取消',
                style: style,
                onTap: ref.read(cancelProvider.notifier).update,
              ),
            ],
          );
        },
      ),
    );
  }
}
