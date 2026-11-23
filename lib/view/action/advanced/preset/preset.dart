import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/view/action/advanced/preset/action.dart';
import 'package:once_power/view/action/advanced/preset/list.dart';
import 'package:once_power/widget/action/preset_button.dart';
import 'package:once_power/widget/base/popover.dart';
import 'package:once_power/widget/base/text.dart';

class PresetButton extends StatelessWidget {
  const PresetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return EasyPopover(
      content: SizedBox(
        width: AppNumber.presetWidth,
        child: Column(
          mainAxisSize: .min,
          children: [
            const PresetList(),
            const PresetAction(),
            PresetButtonItem(
              width: AppNumber.presetWidth,
              label: context.tr(AppL10n.presetAdd),
              onTap: () {},
            ),
          ],
        ),
      ),
      child: Container(
        height: AppNumber.widgetHeight,
        alignment: .center,
        child: BaseText(
          context.tr(AppL10n.preset),
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
