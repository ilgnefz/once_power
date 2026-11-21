import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/widget/base/text.dart';

class const SettingCard({
  super.key,
  required final String title,
  required final List<Widget> children,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .only(top: AppNumber.padding),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        spacing: AppNumber.spaceMedium,
        children: [
          BaseText(title, style: Theme.of(context).textTheme.titleMedium),
          ...children,
        ],
      ),
    );
  }
}
