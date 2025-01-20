import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';
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

  void onChange() {
    ref.read(extraFunctionProvider.notifier).update();
    bool enable = ref.read(extraFunctionProvider);
    FunctionMode currentMode = ref.watch(currentModeProvider);
    FunctionMode mode = enable
        ? FunctionMode.advance
        : currentMode == FunctionMode.advance
            ? FunctionMode.replace
            : currentMode;
    ref.read(currentModeProvider.notifier).update(mode);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChange,
      onHover: toggleColor,
      child: EasyCheckbox(
        S.of(context).advanceMenu,
        height: AppNum.bottomBarH - 4,
        checked: ref.watch(extraFunctionProvider),
        style: TextStyle(fontSize: 13, color: color).useSystemChineseFont(),
        fillColor: WidgetStateProperty.resolveWith(getColor),
        borderColor: color,
        onChanged: (v) => onChange(),
      ),
    );
  }
}
