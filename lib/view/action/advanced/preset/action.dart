import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/widget/action/preset_button.dart';

class PresetAction extends StatelessWidget {
  const PresetAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PresetButtonItem(
          width: AppNumber.presetWidth / 2,
          label: context.tr(AppL10n.presetImport),
          onTap: () {},
        ),
        PresetButtonItem(
          width: AppNumber.presetWidth / 2,
          label: context.tr(AppL10n.presetExport),
          onTap: () {},
        ),
      ],
    );
  }
}
