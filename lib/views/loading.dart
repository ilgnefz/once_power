import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/provider/progress.dart';

class LoadingView extends ConsumerWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int count = ref.watch(countProvider);
    int total = ref.watch(totalProvider);

    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/loading.gif'),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 160),
              child: LinearProgressIndicator(
                value: total == 0 ? null : count / total,
                minHeight: 6,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            const SizedBox(height: 12),
            Text('当前进度$count/$total'),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {},
              child: const Text('取消'),
            ),
          ],
        ),
      ),
    );
  }
}
