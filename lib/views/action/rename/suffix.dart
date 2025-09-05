import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/icons.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/cores/normal.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/input.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/utils/debounce.dart';
import 'package:once_power/widgets/action/action_item.dart';
import 'package:once_power/widgets/action/upload.dart';

class SuffixInput extends ConsumerWidget {
  const SuffixInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionItem(
      label: tr(AppL10n.renameSuffix),
      tip: tr(AppL10n.renameSuffixCircle),
      icon: AppIcons.cycle,
      checked: ref.watch(isCycleSuffixProvider),
      onPressed: () {
        ref.read(isCycleSuffixProvider.notifier).update();
        Debounce.run(() => updateName(ref));
      },
      child: UploadInput(
        hintText: tr(AppL10n.renameSuffixHint),
        controller: ref.watch(suffixControllerProvider),
        show: ref.watch(suffixClearProvider),
        info: ref.watch(suffixUploadMarkProvider),
        onClear: () {
          ref.read(suffixControllerProvider.notifier).clear();
          ref.read(suffixUploadMarkProvider.notifier).clear();
        },
        onUpload: (value) async {
          UploadMarkInfo? info = await readUploadFile(value);
          if (info != null) {
            info.copyWith(isPrefix: false);
            ref.read(suffixUploadMarkProvider.notifier).update(info);
            updateName(ref);
          }
        },
      ),
    );
  }
}
