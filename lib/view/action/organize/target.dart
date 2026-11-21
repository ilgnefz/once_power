import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/icon.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/widget/action/input.dart';

class TargetInput extends StatelessWidget {
  const TargetInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: .symmetric(horizontal: AppNumber.padding),
      child: EasyInput(
        hintText: context.tr(AppL10n.target),
        onChanged: (value) {},
        suffixIcon: AppIcons.folder,
        onSuffixPressed: () {},
      ),
    );
  }
}
