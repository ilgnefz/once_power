import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/provider/provider.dart';

class EnableOrganize extends ConsumerStatefulWidget {
  const EnableOrganize({super.key});

  @override
  ConsumerState<EnableOrganize> createState() => _EnableOrganizeState();
}

class _EnableOrganizeState extends ConsumerState<EnableOrganize> {
  final String arrangeFile = '整理文件';
  Color color = Colors.grey;

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.selected,
      MaterialState.focused,
      MaterialState.pressed,
    };
    if (states.any(interactiveStates.contains)) return color;
    return Colors.transparent;
  }

  void toggleColor(bool hover) {
    color = hover ? Theme.of(context).primaryColor : Colors.grey;
    setState(() {});
  }

  void onChange() {
    ref.read(enableArrangeProvider.notifier).update();
    ref.read(fileListProvider.notifier).clear();
    bool enable = ref.read(enableArrangeProvider);
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
                value: ref.watch(enableArrangeProvider),
                fillColor: MaterialStateProperty.resolveWith(getColor),
                side: BorderSide(color: color, width: 2),
                onChanged: (v) => onChange(),
              ),
            ),
          ),
          Text(arrangeFile, style: TextStyle(fontSize: 13, color: color)),
        ],
      ),
    );
  }
}
