import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/dialog.dart';
import 'package:once_power/enums/app.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/widgets/common/tooltip_icon.dart';

class ThemeSwitch extends ConsumerWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeType type = ref.watch(currentThemeProvider);
    return TooltipIcon(
      tip: type.label,
      icon: type.icon,
      onPressed: ref.read(currentThemeProvider.notifier).update,
      onLongPress: () => showThemeView(context),
    );
  }
}
