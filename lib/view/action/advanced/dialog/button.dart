import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/widget/base/dropdown.dart';
import 'package:once_power/widget/base/text.dart';

class ButtonGroup extends StatelessWidget {
  const ButtonGroup({
    super.key,
    required this.group,
    required this.onComplete,
    required this.onCompleteExit,
    required this.onGroupChange,
  });

  final String group;
  final void Function() onComplete;
  final void Function() onCompleteExit;
  final void Function(String) onGroupChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppNumber.widgetHeight,
      padding: .symmetric(horizontal: AppNumber.padding),
      child: Row(
        spacing: AppNumber.spaceSmall,
        children: [
          BaseText('${context.tr(AppL10n.applyGroup)}:'),
          EasyTextDropdown<String>(
            value: group == 'all' ? context.tr(AppL10n.all) : group,
            // TODO: 更改
            items: [
              context.tr(AppL10n.all),
              '0',
              '1',
              '2',
            ].map((e) => TextDropdownItem<String>(e, label: e)).toList(),
            onChanged: onGroupChange,
          ),
          const Spacer(),
          TextButton(
            onPressed: onComplete,
            child: Text(context.tr(AppL10n.ok)),
          ),
          TextButton(
            onPressed: onCompleteExit,
            child: Text(context.tr(AppL10n.okExist)),
          ),
        ],
      ),
    );
  }
}
