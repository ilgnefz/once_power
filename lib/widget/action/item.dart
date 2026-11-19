import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/widget/base/text.dart';

import 'icon_box.dart';

class const ActionItem({
  super.key,
  final String? label,
  required final Widget child,
  required final String icon,
  required final String tip,
  required final bool checked,
  required final void Function() onIconPressed,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: AppNumber.padding),
      child: Row(
        spacing: AppNumber.spaceMedium,
        crossAxisAlignment: .center,
        children: [
          if (label != null) BaseText('${label!}:'),
          Expanded(child: child),
          IconBox(
            tip: tip,
            icon: icon,
            checked: checked,
            onPressed: onIconPressed,
          ),
        ],
      ),
    );
  }
}
