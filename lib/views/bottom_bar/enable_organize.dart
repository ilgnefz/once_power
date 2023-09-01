import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/select.dart';
import 'package:once_power/provider/toggle.dart';

class EnableOrganize extends ConsumerStatefulWidget {
  const EnableOrganize({super.key});

  @override
  ConsumerState<EnableOrganize> createState() => _EnableOrganizeState();
}

class _EnableOrganizeState extends ConsumerState<EnableOrganize> {
  Color color = Colors.grey;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.selected,
      MaterialState.focused,
      MaterialState.pressed,
    };
    if (states.any(interactiveStates.contains)) {
      return color;
    }
    return Colors.transparent;
  }

  void onHover(bool hover) {
    color = hover ? Theme.of(context).primaryColor : Colors.grey;
    setState(() {});
  }

  void onChange() {
    ref.read(useOrganizeProvider.notifier).update();
    ref.read(fileListProvider.notifier).clear();
    bool enable = ref.read(useOrganizeProvider);
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
      onHover: onHover,
      child: Row(
        children: [
          SizedBox(
            height: AppNum.bottomBarH - 4,
            child: FittedBox(
              fit: BoxFit.fill,
              child: Checkbox(
                value: ref.watch(useOrganizeProvider),
                fillColor: MaterialStateProperty.resolveWith(getColor),
                side: BorderSide(color: color, width: 2),
                onChanged: (v) => onChange(),
              ),
            ),
          ),
          Text('整理文件', style: TextStyle(fontSize: 13, color: color)),
        ],
      ),
    );
  }
}
