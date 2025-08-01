import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/date_preporty.dart';
import 'package:once_power/providers/value.dart';

import 'date_property_title.dart';
import 'replace_date_input.dart';

class DateInputGroup extends ConsumerWidget {
  const DateInputGroup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateProperty dateProperty = ref.watch(fileDatePropertyProvider);
    return Expanded(
      child: Column(
        children: [
          DatePropertyTitle(
            label: S.of(context).createdDate,
            checked: dateProperty.createdDateChecked,
            value: dateProperty.createdDate,
            onChanged: (v) {
              ref
                  .read(fileDatePropertyProvider.notifier)
                  .update(dateProperty.copyWith(createdDateChecked: v));
            },
          ),
          ReplaceDateInput(
            onChange: (date) {
              ref.read(fileDatePropertyProvider.notifier).update(dateProperty
                  .copyWith(createdDate: date == null ? '' : '$date'));
            },
          ),
          DatePropertyTitle(
            label: S.of(context).modifiedDate,
            checked: dateProperty.modifiedDateChecked,
            value: dateProperty.modifiedDate,
            onChanged: (v) {
              ref
                  .read(fileDatePropertyProvider.notifier)
                  .update(dateProperty.copyWith(modifiedDateChecked: v));
            },
          ),
          ReplaceDateInput(
            onChange: (date) {
              ref.read(fileDatePropertyProvider.notifier).update(dateProperty
                  .copyWith(modifiedDate: date == null ? '' : '$date'));
            },
          ),
          DatePropertyTitle(
            label: S.of(context).accessedDate,
            checked: dateProperty.accessedDateChecked,
            value: dateProperty.accessedDate,
            onChanged: (v) {
              ref
                  .read(fileDatePropertyProvider.notifier)
                  .update(dateProperty.copyWith(accessedDateChecked: v));
            },
          ),
          ReplaceDateInput(
            onChange: (date) {
              ref.read(fileDatePropertyProvider.notifier).update(dateProperty
                  .copyWith(accessedDate: date == null ? '' : '$date'));
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: AppNum.defaultP,
              vertical: AppNum.mediumG,
            ),
            child: Text(
              S.of(context).accessedDateTip,
              style: TextStyle(fontSize: 13, color: Color(0xFF666666)),
            ),
          ),
        ],
      ),
    );
  }
}
