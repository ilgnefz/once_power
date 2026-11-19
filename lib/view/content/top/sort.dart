import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/icon.dart';
import 'package:once_power/widget/base/icon.dart';

class TopSort extends StatelessWidget {
  const TopSort({super.key});

  @override
  Widget build(BuildContext context) {
    return ClickIcon(onPressed: () {}, svg: AppIcons.sort);
  }
}
