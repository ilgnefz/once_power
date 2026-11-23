import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/view/action/advanced/actions.dart';
import 'package:once_power/view/action/advanced/empty.dart';
import 'package:once_power/view/action/advanced/top.dart';

import '../add.dart';
import '../pick.dart';

class AdvancedView extends StatelessWidget {
  const AdvancedView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(vertical: AppNumber.spaceMedium),
      child: Column(
        children: const [
          AdvancedTop(),
          Expanded(child: DirectiveEmpty()),
          ActionsGroup(),
          SizedBox(height: AppNumber.spaceSmall),
          AddGroup(),
          SizedBox(height: AppNumber.spaceSmall),
          PickerGroup(),
        ],
      ),
    );
  }
}
