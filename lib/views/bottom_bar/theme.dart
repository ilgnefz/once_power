import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/utils/info.dart';
import 'package:once_power/widgets/common/tooltip_icon.dart';

class ThemeBtn extends ConsumerWidget {
  const ThemeBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TooltipIcon(
      tip: getThemeModeName(ref.watch(currentThemeModeProvider)),
      // icon: ref.watch(currentThemeModeProvider) == ThemeMode.light
      //     ? Icons.light_mode_rounded
      //     : Icons.dark_mode_rounded,
      icon: getThemeModeIcon(ref.watch(currentThemeModeProvider)),
      selected: false,
      onTap: ref.read(currentThemeModeProvider.notifier).update,
    );
  }
}
