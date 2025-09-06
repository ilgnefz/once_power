import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/cores/date.dart';
import 'package:once_power/models/date.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/widgets/base/easy_elevated_btn.dart';

final _enableProvider = Provider((ref) {
  DateProperty dateProperty = ref.watch(fileDatePropertyProvider);
  return dateProperty.createdDateChecked ||
      dateProperty.modifiedDateChecked ||
      dateProperty.accessedDateChecked;
});

class ApplyModify extends ConsumerWidget {
  const ApplyModify({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EasyElevatedBtn(
      label: tr(AppL10n.renameApply),
      onPressed: ref.watch(_enableProvider) ? () => modifyDate(ref) : null,
    );
  }
}
