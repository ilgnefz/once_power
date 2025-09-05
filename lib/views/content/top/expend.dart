import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widgets/common/click_icon.dart';

class ContentExpend extends ConsumerWidget {
  const ContentExpend({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RotatedBox(
      quarterTurns: 1,
      child: ClickIcon(
        icon: ref.watch(expandNewNameProvider)
            ? Icons.expand_rounded
            : Icons.compress_rounded,
        onPressed: ref.read(expandNewNameProvider.notifier).update,
      ),
    );
  }
}
