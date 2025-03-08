import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/providers/select.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/widgets/common/easy_checkbox.dart';

class ExtraFunctionBtn extends ConsumerStatefulWidget {
  const ExtraFunctionBtn({super.key});

  @override
  ConsumerState<ExtraFunctionBtn> createState() => _EnableOrganizeState();
}

class _EnableOrganizeState extends ConsumerState<ExtraFunctionBtn> {
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

  @override
  Widget build(BuildContext context) {
    bool enable = ref.watch(openExtraFunctionProvider);

    void onChange() {
      ref.read(openExtraFunctionProvider.notifier).update();
      FunctionMode currentMode = ref.watch(currentModeProvider);
      FunctionMode mode = enable
          ? FunctionMode.advance
          : currentMode.isAdvance
              ? FunctionMode.replace
              : currentMode;
      ref.read(currentModeProvider.notifier).update(mode);
    }

    return InkWell(
      onTap: onChange,
      onHover: toggleColor,
      child: EasyCheckbox(
        label: S.of(context).advanceMenu,
        height: AppNum.bottomBarH - 4,
        checked: enable,
        style: TextStyle(fontSize: 13, color: color).useSystemChineseFont(),
        fillColor: WidgetStateProperty.resolveWith(getColor),
        borderColor: color,
        onChanged: (v) => onChange(),
      ),
    );
  }
}
