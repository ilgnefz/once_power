import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/core/date.dart';
import 'package:once_power/model/date.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/widget/action/elevated_button.dart';

final Provider<bool> _enableProvider = Provider((Ref ref) {
  DateProperty dateProperty = ref.watch(fileDatePropertyProvider);
  return dateProperty.createdDateChecked ||
      dateProperty.modifiedDateChecked ||
      dateProperty.accessedDateChecked;
});

class ApplyModify extends ConsumerWidget {
  const ApplyModify({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EasyElevatedButton(
      label: tr(AppL10n.renameApply),
      onPressed: ref.watch(_enableProvider) ? () => updateDate(ref) : null,
    );
  }
}
