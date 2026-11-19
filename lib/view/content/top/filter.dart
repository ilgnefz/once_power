import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/widget/base/icon.dart';

class TopFilter extends StatelessWidget {
  const TopFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppNumber.topIconWidth,
      alignment: .center,
      child: ClickIcon(onPressed: () {}, icon: Icons.filter_alt),
    );
  }
}
