import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/enum/app.dart';
import 'package:once_power/provider/theme.dart';
import 'package:once_power/widget/bottom/icon.dart';

class ThemeButton extends ConsumerWidget {
  const ThemeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeType type = ref.watch(currentThemeProvider);
    return BottomClickIcon(
      tip: type.label,
      icon: type.icon,
      onPressed: ref.read(currentThemeProvider.notifier).update,
    );
  }
}
