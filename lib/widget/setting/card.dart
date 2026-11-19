import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/widget/base/text.dart';

class SettingCard extends StatelessWidget {
  const SettingCard({super.key, required this.title, required this.children});

  final String title;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .only(top: AppNumber.padding),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .start,
        spacing: AppNumber.spaceMedium,
        children: [
          BaseText(title, fontSize: 16, fontWeight: .w600),
          // SizedBox(height: AppNumber.spaceMedium),
          ...children,
        ],
      ),
    );
  }
}
