import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/widget/base/text.dart';

class ShortcutContent extends StatelessWidget {
  const ShortcutContent({super.key, required this.keys, required this.label});

  final List<String> keys;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppNumber.widgetHeight,
      child: Row(
        children: [
          SizedBox(
            width: AppNumber.shortcutWidth,
            child: Row(
              spacing: AppNumber.spaceSmall,
              children: [
                ...keys.length > 1
                    ? [KeyBox(keys.first), BaseText('+'), KeyBox(keys.last)]
                    : [KeyBox(keys.single)],
              ],
            ),
          ),
          // 文案区可伸缩：多语言（如英文/德文）较长时 ellipsis，不再撑爆 Row。
          Expanded(child: BaseText(label, textAlign: .right)),
        ],
      ),
    );
  }
}

class KeyBox extends StatelessWidget {
  const KeyBox(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    final double size = AppNumber.widgetHeight - 4.0;
    final BorderSide side = BorderSide(color: Colors.grey, width: 1);
    return Container(
      height: size,
      padding: .symmetric(horizontal: AppNumber.spaceMedium),
      alignment: .centerLeft,
      constraints: BoxConstraints(minWidth: size),
      decoration: BoxDecoration(
        borderRadius: .circular(AppNumber.radiusSmall),
        border: Border(
          left: side,
          top: side,
          right: side,
          bottom: BorderSide(color: Colors.grey, width: 2),
        ),
      ),
      child: BaseText(label),
    );
  }
}
