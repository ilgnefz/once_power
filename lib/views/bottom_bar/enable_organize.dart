import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';

class EnableOrganizeBtn extends ConsumerStatefulWidget {
  const EnableOrganizeBtn({super.key});

  @override
  ConsumerState<EnableOrganizeBtn> createState() => _EnableOrganizeState();
}

class _EnableOrganizeState extends ConsumerState<EnableOrganizeBtn> {
  Color color = Colors.grey;

  Color getColor(Set<WidgetState> states) {
    const Set<WidgetState> interactiveStates = <WidgetState>{
      WidgetState.selected,
      WidgetState.focused,
      WidgetState.pressed,
    };
    if (states.any(interactiveStates.contains)) return color;
    return Colors.transparent;
  }

  void toggleColor(bool hover) {
    color = hover ? Theme.of(context).primaryColor : Colors.grey;
    setState(() {});
  }

  void onChange() {
    ref.read(enableOrganizeProvider.notifier).update();
    bool enable = ref.read(enableOrganizeProvider);
    FunctionMode currentMode = ref.watch(currentModeProvider);
    FunctionMode mode = enable
        ? FunctionMode.organize
        : currentMode == FunctionMode.organize
            ? FunctionMode.replace
            : currentMode;
    ref.read(currentModeProvider.notifier).update(mode);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChange,
      onHover: toggleColor,
      child: Row(
        children: [
          SizedBox(
            height: AppNum.bottomBarH - 4,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Checkbox(
                value: ref.watch(enableOrganizeProvider),
                fillColor: WidgetStateProperty.resolveWith(getColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                side: BorderSide(color: color, width: 1),
                onChanged: (v) => onChange(),
              ),
            ),
          ),
          Text(
            S.of(context).organizeMenu,
            style: TextStyle(fontSize: 13, color: color).useSystemChineseFont(),
          ),
        ],
      ),
    );
  }
}
