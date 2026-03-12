import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/core/organize.dart';
import 'package:once_power/widget/action/elevated_button.dart';

class ApplyOrganize extends ConsumerWidget {
  const ApplyOrganize({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EasyElevatedButton(
      label: tr(AppL10n.organizeApply),
      onPressed: () async => await organize(ref),
    );
  }
}
