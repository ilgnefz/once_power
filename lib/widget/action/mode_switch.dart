import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/widget/base/text.dart';

class const ModeSwitchItem({
  super.key,
  required final bool selected,
  required final String label,
  required final void Function() onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(color: Colors.white),
        child: InkWell(
          mouseCursor: SystemMouseCursors.click,
          borderRadius: .circular(100),
          onTap: onTap,
          child: Container(
            height: AppNumber.widgetHeight,
            padding: .symmetric(
              horizontal: AppNumber.padding,
              vertical: AppNumber.paddingSmall,
            ),
            // alignment: .center,
            child: BaseText(
              label,
              color: selected ? Theme.of(context).colorScheme.primary : null,
              fontWeight: selected ? .bold : .normal,
            ),
          ),
        ),
      ),
    );
  }
}
