import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';

class EasyRadio<T> extends StatelessWidget {
  const EasyRadio({
    super.key,
    required this.label,
    this.mainAxisSize = MainAxisSize.min,
    required this.value,
    this.space = 8,
    this.trailing,
  });

  final String label;
  final MainAxisSize mainAxisSize;
  final T value;
  final double space;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // 外壳固定 widgetHeight，radio 与文字保持原尺寸、垂直居中。
    return SizedBox(
      height: AppNumber.widgetHeight,
      child: Row(
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: .center,
        children: [
          Radio<T>(
            mouseCursor: SystemMouseCursors.click,
            value: value,
            side: theme.checkboxTheme.side,
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          Text(label, style: theme.textTheme.bodyMedium?.copyWith(height: 1.5)),
          if (trailing != null) ...[SizedBox(width: space), trailing!],
        ],
      ),
    );
  }
}
