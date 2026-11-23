import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';

class const PresetButtonItem({
  super.key,
  required final double width,
  required final String label,
  required final void Function() onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Material(
      child: Ink(
        child: InkWell(
          mouseCursor: SystemMouseCursors.click,
          onTap: onTap,
          child: Container(
            width: width,
            height: AppNumber.widgetHeight,
            alignment: .center,
            child: Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
