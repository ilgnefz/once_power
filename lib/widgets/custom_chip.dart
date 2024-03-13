import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/provider.dart';

const borderRadius = BorderRadius.all(Radius.circular(8));

class CustomChip extends ConsumerWidget {
  const CustomChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    this.enable = true,
  });

  final String label;
  final bool selected;
  final void Function()? onTap;
  final bool enable;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mode = ref.watch(currentModeProvider);
    final locale = Localizations.localeOf(context);
    bool isEnglish = locale == const Locale('en', 'US');
    Color background = enable
        ? (selected
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColor.withOpacity(.2))
        : Colors.black12;
    Color text = enable
        ? (selected ? Colors.white : Theme.of(context).primaryColor)
        : Colors.grey;
    double fontSize = mode == FunctionMode.replace && isEnglish ? 13 : 14;

    return Ink(
      decoration: BoxDecoration(
        color: background,
        borderRadius: borderRadius,
      ),
      child: InkWell(
        onTap: enable ? onTap : null,
        borderRadius: borderRadius,
        child: Container(
          height: 32,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(fontSize: fontSize, color: text),
          ),
        ),
      ),
    );
  }
}
