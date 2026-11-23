import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/view/action/organize/target.dart';

import '../add.dart';
import '../pick.dart';

class OrganizeView extends StatelessWidget {
  const OrganizeView({super.key});

  @override
  Widget build(BuildContext context) {
    const Widget space = SizedBox(height: AppNumber.spaceSmall);
    return Padding(
      padding: .symmetric(vertical: AppNumber.spaceMedium),
      child: Column(
        children: const [
          Expanded(child: Column()),
          TargetInput(),
          space,
          AddGroup(),
          space,
          PickerGroup(),
        ],
      ),
    );
  }
}
