import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/toggle.dart';

const borderRadius = BorderRadius.all(Radius.circular(8));

class EasyChip extends ConsumerWidget {
  const EasyChip({
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
    LanguageType type = ref.watch(currentLanguageProvider);
    bool isEnglish = type == LanguageType.english;
    Color background = enable
        ? (selected
            ? Theme.of(context).primaryColor
            : Theme.of(context).primaryColor.withValues(alpha: .2))
        : Colors.black12;
    Color text = enable
        ? (selected ? Colors.white : Theme.of(context).primaryColor)
        : Colors.grey;
    double fontSize = mode == FunctionMode.replace && isEnglish ? 13 : 14;
    // double fontSize = 13;

    return Ink(
      decoration: BoxDecoration(
        color: background,
        borderRadius: borderRadius,
      ),
      child: InkWell(
        onTap: enable ? onTap : null,
        borderRadius: borderRadius,
        child: Container(
          height: AppNum.inputH,
          padding: const EdgeInsets.symmetric(horizontal: AppNum.defaultP),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(fontSize: fontSize, color: text)
                .useSystemChineseFont(),
          ),
        ),
      ),
    );
  }
}
