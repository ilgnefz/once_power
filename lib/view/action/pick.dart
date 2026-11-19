import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/widget/base/button.dart';

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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          EasyButton(label: context.tr(AppL10n.addFile), onPressed: () {}),
          EasyButton(label: context.tr(AppL10n.selectFolder), onPressed: () {}),
          ElevatedButton(
            child: Text(context.tr(AppL10n.apply)),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
