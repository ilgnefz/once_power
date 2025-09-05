import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widgets/common/click_icon.dart';

class ContentVisible extends ConsumerWidget {
  const ContentVisible({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ThemeData theme = Theme.of(context);
    bool active = ref.watch(onlyChangeProvider);
    return ClickIcon(
      icon: active ? Icons.visibility_off : Icons.visibility,
      color: active ? theme.primaryColor : theme.iconTheme.color,
      onPressed: ref.read(onlyChangeProvider.notifier).update,
    );
  }
}
