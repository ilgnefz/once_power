import 'package:material_ui/material_ui.dart';
import 'package:once_power/config/theme/button.dart';
import 'package:once_power/constant/number.dart';

class EasyButton extends StatelessWidget {
  const EasyButton({super.key, required this.label, required this.onPressed});

  final String label;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Material(
      color: theme.colorScheme.primary.withValues(alpha: .2),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: .circular(AppNumber.radius),
        // side: BorderSide(color: theme.colorScheme.primary, width: 1),
      ),
      clipBehavior: Clip.antiAlias,
      child: Ink(
        child: InkWell(
          mouseCursor: SystemMouseCursors.click,
          onTap: onPressed,
          child: Container(
            height: AppNumber.widgetHeight,
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            alignment: Alignment.center,
            child: Text(
              label,
              style: theme.extension<EasyButtonTheme>()?.textStyle,
            ),
          ),
        ),
      ),
    );
  }
}
