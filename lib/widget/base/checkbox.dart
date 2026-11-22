import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';

class const EasyCheckbox({
  super.key,

  /// null 表示部分选中（三态横杠）；传 null 时会自动打开 [Checkbox.tristate]。
  required final bool? checked,
  required final Function(bool?)? onChanged,
  final String? label,
  final double space = 0,
  final double splashRadius = 16.0,
  final Widget? child,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    Widget checkbox = Checkbox(
      value: checked,
      // 只有 checked 为 null 时才开三态，其它调用点行为不变；
      // 反过来 tristate: false 时 value 为 null 会触发断言。
      tristate: checked == null,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
      splashRadius: splashRadius,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      side: theme.checkboxTheme.side,
      checkColor: Colors.white,
      fillColor: theme.checkboxTheme.fillColor,
      mouseCursor: SystemMouseCursors.click,
      onChanged: onChanged,
    );

    Widget row = Row(
      mainAxisSize: .min,
      mainAxisAlignment: .start,
      crossAxisAlignment: .center,
      children: [
        checkbox,
        if (label != null)
          Text(
            label!,
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.5),
          ),
        if (space > 0) SizedBox(width: space),
        ?child,
      ],
    );

    // 外壳固定 widgetHeight，checkbox/文字保持原尺寸、垂直居中。
    return RepaintBoundary(
      child: SizedBox(
        height: AppNumber.widgetHeight,
        child: Row(
          mainAxisSize: .min,
          crossAxisAlignment: .center,
          children: [label == null && child == null ? checkbox : row],
        ),
      ),
    );
  }
}
