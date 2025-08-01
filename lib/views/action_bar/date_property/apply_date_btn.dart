import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/date_property.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/date_preporty.dart';
import 'package:once_power/providers/value.dart';
import 'package:once_power/utils/verify.dart';
import 'package:once_power/widgets/common/easy_elevated_btn.dart';

class ApplyDateBtn extends ConsumerWidget {
  const ApplyDateBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateProperty dateProperty = ref.watch(fileDatePropertyProvider);
    bool enable = dateProperty.createdDateChecked ||
        dateProperty.modifiedDateChecked ||
        dateProperty.accessedDateChecked;
    return EasyElevatedBtn(
      onPressed: disabledBtn(ref) || !enable ? null : () => modifyDate(ref),
      label: S.of(context).applyChange,
    );
  }
}
