import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/cores/update_name.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/providers/file.dart';
import 'package:once_power/providers/input.dart';
import 'package:once_power/providers/toggle.dart';
import 'package:once_power/widgets/action_bar/upload_input.dart';
import 'package:path/path.dart' as path;

class PrefixInput extends ConsumerWidget {
  const PrefixInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UploadInput(
      label: S.of(context).prefix,
      tip: S.of(context).circularPrefixDesc,
      selected: ref.watch(isCyclePrefixProvider),
      onToggle: () {
        ref.read(isCyclePrefixProvider.notifier).update();
        updateName(ref);
      },
      hintText: S.of(context).prefixContent,
      controller: ref.watch(prefixControllerProvider),
      showClear: ref.watch(prefixClearProvider),
      // fileName: ref.watch(prefixFileNameProvider),
      info: ref.watch(prefixUploadMarkProvider),
      onUpload: (File file) async {
        String fileName = path.basename(file.path);
        String content = await file.readAsString();
        UploadMarkInfo info = UploadMarkInfo(name: fileName, content: content);
        ref.read(prefixUploadMarkProvider.notifier).update(info);
        updateName(ref);
      },
      onClear: () {
        if (ref.watch(prefixUploadMarkProvider) != null) {
          ref.read(prefixUploadMarkProvider.notifier).clear();
        }
        ref.read(prefixControllerProvider.notifier).clear();
      },
    );
  }
}
