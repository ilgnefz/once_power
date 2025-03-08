import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/organize.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/providers/file.dart';
import 'package:once_power/widgets/common/easy_elevated_btn.dart';

class ApplyOrganizeBtn extends ConsumerWidget {
  const ApplyOrganizeBtn({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return EasyElevatedBtn(
      onPressed: ref.watch(fileListProvider).isEmpty
          ? null
          : () => organizeFolder(ref),
      label: S.of(context).organizeBtn,
    );
  }
}
