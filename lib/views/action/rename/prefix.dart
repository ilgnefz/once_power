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

class PrefixInput extends ConsumerWidget {
  const PrefixInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionItem(
      label: tr(AppL10n.renamePrefix),
      tip: tr(AppL10n.renamePrefixCircle),
      icon: AppIcons.cycle,
      checked: ref.watch(isCyclePrefixProvider),
      onPressed: () {
        ref.read(isCyclePrefixProvider.notifier).update();
        Debounce.run(() => updateName(ref));
      },
      child: UploadInput(
        hintText: tr(AppL10n.renamePrefixHint),
        controller: ref.watch(prefixControllerProvider),
        show: ref.watch(prefixClearProvider),
        info: ref.watch(prefixUploadMarkProvider),
        onClear: () {
          ref.read(prefixControllerProvider.notifier).clear();
          ref.read(prefixUploadMarkProvider.notifier).clear();
        },
        onUpload: (value) async {
          UploadMarkInfo? info = await readUploadFile(value);
          if (info != null) {
            ref.read(prefixUploadMarkProvider.notifier).update(info);
            updateName(ref);
          }
        },
      ),
    );
  }
}
