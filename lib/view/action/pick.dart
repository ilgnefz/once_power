import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/widget/base/button.dart';
import 'package:once_power/widget/base/text.dart';

class PickerGroup extends StatelessWidget {
  const PickerGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: AppNumber.paddingMedium,
        right: AppNumber.padding,
      ),
      child: Row(
        children: [
          EasyButton(label: context.tr(AppL10n.addFile), onPressed: () {}),
          const SizedBox(width: AppNumber.paddingSmall),
          EasyButton(label: context.tr(AppL10n.selectFolder), onPressed: () {}),
          const Spacer(),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              enabledMouseCursor: SystemMouseCursors.click,
            ),
            onPressed: () {},
            child: BaseText(context.tr(AppL10n.apply), color: Colors.white),
          ),
        ],
      ),
    );
  }
}
