import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/models/date.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/views/action/add_group.dart';
import 'package:once_power/views/action/apply_group.dart';
import 'package:once_power/views/action/date/apply.dart';
import 'package:once_power/views/action/date/input.dart';
import 'package:once_power/views/action/date/title.dart';
import 'package:once_power/views/action/date/top.dart';
import 'package:once_power/widgets/base/easy_checkbox.dart';

import 'interval.dart';

class DateView extends ConsumerWidget {
  const DateView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateProperty dateProperty = ref.watch(fileDatePropertyProvider);
    final provider = ref.read(fileDatePropertyProvider.notifier);
    return SizedBox(
      width: AppNum.action,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DateTop(),
          DateTitle(
            title: tr(AppL10n.eDateCreate),
            label: dateProperty.createdDate,
            checked: dateProperty.createdDateChecked,
            fullReplace: dateProperty.fullReplace,
            selfAdjust: dateProperty.selfAdjust,
            onChanged: (value) {
              provider.update(dateProperty.copyWith(createdDateChecked: value));
            },
          ),
          SizedBox(height: 6),
          TimeInput(
            date: dateProperty.createdDate,
            onChange: (date) {
              String value = date == null ? '' : '$date';
              provider.update(dateProperty.copyWith(createdDate: value));
            },
          ),
          SizedBox(height: 6),
          DateTitle(
            title: tr(AppL10n.eDateModify),
            label: dateProperty.modifiedDate,
            checked: dateProperty.modifiedDateChecked,
            fullReplace: dateProperty.fullReplace,
            selfAdjust: dateProperty.selfAdjust,
            onChanged: (value) {
              provider.update(
                dateProperty.copyWith(modifiedDateChecked: value),
              );
            },
          ),
          SizedBox(height: 6),
          TimeInput(
            date: dateProperty.modifiedDate,
            onChange: (date) {
              String value = date == null ? '' : '$date';
              provider.update(dateProperty.copyWith(modifiedDate: value));
            },
          ),
          SizedBox(height: 6),
          DateTitle(
            title: tr(AppL10n.eDateAccess),
            label: dateProperty.accessedDate,
            checked: dateProperty.accessedDateChecked,
            fullReplace: dateProperty.fullReplace,
            selfAdjust: dateProperty.selfAdjust,
            onChanged: (value) {
              provider.update(
                dateProperty.copyWith(accessedDateChecked: value),
              );
            },
          ),
          SizedBox(height: 6),
          TimeInput(
            date: dateProperty.accessedDate,
            onChange: (date) {
              String value = date == null ? '' : '$date';
              provider.update(dateProperty.copyWith(accessedDate: value));
            },
          ),
          SizedBox(height: 8),
          IntervalGroup(
            diffType: dateProperty.diffType,
            interval: dateProperty.interval,
            dateType: dateProperty.dateUnit,
            onDiffTypeChanged: (value) {
              provider.update(dateProperty.copyWith(diffType: value));
            },
            onIntervalChanged: (value) {
              provider.update(dateProperty.copyWith(interval: value));
            },
            onDateTypeChanged: (value) {
              provider.update(dateProperty.copyWith(dateUnit: value));
            },
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(
                left: AppNum.spaceMedium, right: AppNum.padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                EasyCheckbox(
                  checked: dateProperty.fullReplace,
                  label: tr(AppL10n.dateFullReplace),
                  onChanged: (value) {
                    provider.update(dateProperty.copyWith(fullReplace: value));
                  },
                ),
                EasyCheckbox(
                  checked: dateProperty.selfAdjust,
                  label: tr(AppL10n.dateSelf),
                  onChanged: (value) {
                    provider.update(dateProperty.copyWith(selfAdjust: value));
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 4),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppNum.padding),
            child: Text(
              tr(AppL10n.dateNote),
              style: TextStyle(fontSize: 13, color: Color(0xFF666666)),
            ),
          ),
          Spacer(),
          AddGroup(),
          SizedBox(height: 6),
          ApplyGroup(slot: ApplyModify()),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
