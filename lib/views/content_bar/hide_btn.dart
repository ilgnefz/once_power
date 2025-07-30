import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/widgets/common/click_icon.dart';

class HideBtn extends ConsumerWidget {
  const HideBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ClickIcon(
      size: 32,
      iconSize: AppNum.defaultIconS,
      icon: ref.watch(showChangeProvider)
          ? Icons.visibility_off
          : Icons.visibility,
      color: Theme.of(context).iconTheme.color,
      onTap: ref.read(showChangeProvider.notifier).update,
    );
  }
}
