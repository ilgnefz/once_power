import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';

class PresetButton extends StatelessWidget {
  const PresetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Text(context.tr(AppL10n.preset)),
    );
  }
}
