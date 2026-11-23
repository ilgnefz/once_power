import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/core/dialog.dart';
import 'package:once_power/model/actions.dart';
import 'package:once_power/widget/base/button.dart';

import 'preset.dart';

class ActionsGroup extends StatelessWidget {
  const ActionsGroup({super.key});

  @override
  Widget build(BuildContext context) {
    Localizations.localeOf(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppNumber.padding),
      child: Row(
        spacing: 4,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ...PresetAction.values.map((e) {
            return EasyButton(
              label: e.label,
              onPressed: () => showAdvanceView(context, e),
            );
          }),
          const Spacer(),
          const PresetButton(),
        ],
      ),
    );
  }
}
