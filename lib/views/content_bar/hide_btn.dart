import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/widgets/common/click_icon.dart';

class HideBtn extends ConsumerWidget {
  const HideBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    bool active = ref.watch(showChangeProvider);
    return ClickIcon(
      size: 32,
      iconSize: AppNum.defaultIconS,
      icon: active ? Icons.visibility_off : Icons.visibility,
      color: active ? theme.primaryColor : theme.iconTheme.color,
      onTap: ref.read(showChangeProvider.notifier).update,
    );
  }
}
