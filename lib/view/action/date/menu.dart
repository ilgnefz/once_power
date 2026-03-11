import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/model/date.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/widget/common/checkbox.dart';

class MenuGroup extends StatelessWidget {
  const MenuGroup({
    super.key,
    required this.dateProperty,
    required this.provider,
  });

  final DateProperty dateProperty;
  final FileDateProperty provider;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: AppNum.spaceMedium,
        right: AppNum.padding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          EasyCheckbox(
            checked: dateProperty.fullReplace,
            label: tr(AppL10n.dateFullReplace),
            onChanged: (value) =>
                provider.update(dateProperty.copyWith(fullReplace: value)),
          ),
          EasyCheckbox(
            checked: dateProperty.selfAdjust,
            label: tr(AppL10n.dateSelf),
            onChanged: (value) =>
                provider.update(dateProperty.copyWith(selfAdjust: value)),
          ),
        ],
      ),
    );
  }
}
