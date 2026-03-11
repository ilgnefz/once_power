import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/model/date.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/view/action/add.dart';
import 'package:once_power/view/action/date/interval.dart';
import 'package:once_power/view/action/date/title.dart';
import 'package:once_power/view/action/date/top.dart';
import 'package:once_power/view/action/picker.dart';

import 'apply.dart';
import 'input.dart';
import 'menu.dart';

class DateView extends ConsumerWidget {
  const DateView({super.key});

  final double space = AppNum.spaceSmall;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateProperty dateProperty = ref.watch(fileDatePropertyProvider);
    FileDateProperty provider = ref.read(fileDatePropertyProvider.notifier);
    return SizedBox(
      width: AppNum.actionWidth,
      child: Column(
        children: [
          const DateTop(),
          if (Platform.isWindows) ...[
            DateTitle(
              title: tr(AppL10n.eDateCreate),
              label: dateProperty.createdDate,
              checked: dateProperty.createdDateChecked,
              fullReplace: dateProperty.fullReplace,
              selfAdjust: dateProperty.selfAdjust,
              onChanged: (value) {
                provider.update(
                  dateProperty.copyWith(createdDateChecked: value),
                );
              },
            ),
            SizedBox(height: space),
            TimeInput(
              date: dateProperty.createdDate,
              onChange: (date) {
                String value = date == null ? '' : '$date';
                provider.update(dateProperty.copyWith(createdDate: value));
              },
            ),
            SizedBox(height: space),
          ],
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
          SizedBox(height: space),
          TimeInput(
            date: dateProperty.modifiedDate,
            onChange: (date) {
              String value = date == null ? '' : '$date';
              provider.update(dateProperty.copyWith(modifiedDate: value));
            },
          ),
          SizedBox(height: space),
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
          SizedBox(height: space),
          TimeInput(
            date: dateProperty.accessedDate,
            onChange: (date) {
              String value = date == null ? '' : '$date';
              provider.update(dateProperty.copyWith(accessedDate: value));
            },
          ),
          SizedBox(height: AppNum.spaceMedium),
          IntervalGroup(dateProperty: dateProperty, provider: provider),
          SizedBox(height: AppNum.spaceMedium),
          MenuGroup(dateProperty: dateProperty, provider: provider),
          SizedBox(height: space),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppNum.padding),
            child: Text(
              tr(AppL10n.dateNote),
              style: TextStyle(fontSize: 13, color: Color(0xFF666666)),
            ),
          ),
          Spacer(),
          AddGroup(),
          SizedBox(height: space),
          FilePickerGroup(slot: ApplyModify()),
          SizedBox(height: 8),
        ],
      ),
    );
  }
}
