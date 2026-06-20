import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/images.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/widget/base/text.dart';

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: AppNum.spaceLarge,
      mainAxisAlignment: .center,
      children: [
        Image.asset(AppImages.loading),
        BaseText('正在获取文件信息'),
        SizedBox(
          width: MediaQuery.of(context).size.width * .5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Consumer(
              builder: (BuildContext context, WidgetRef ref, Widget? child) {
                int currentSize = ref.watch(countProvider);
                int totalSize = ref.watch(totalProvider);
                double progress = currentSize / totalSize;
                return TweenAnimationBuilder<double>(
                  tween: Tween(begin: progress, end: progress),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  builder: (_, value, _) => LinearProgressIndicator(
                    value: value,
                    valueColor: AlwaysStoppedAnimation(
                      Theme.of(context).primaryColor,
                    ),
                    backgroundColor: Colors.grey[200],
                    minHeight: 8,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
