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

class SuffixInput extends ConsumerWidget {
  const SuffixInput({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UploadInput(
      label: S.of(context).suffix,
      tip: S.of(context).circularSuffixDesc,
      selected: ref.watch(isCycleSuffixProvider),
      onToggle: () {
        ref.read(isCycleSuffixProvider.notifier).update();
        updateName(ref);
      },
      hintText: S.of(context).suffixContent,
      controller: ref.watch(suffixControllerProvider),
      showClear: ref.watch(suffixClearProvider),
      info: ref.watch(suffixUploadMarkProvider),
      onUpload: (File file) async {
        String fileName = path.basename(file.path);
        String content = await file.readAsString();
        UploadMarkInfo info =
            UploadMarkInfo(name: fileName, content: content, isPrefix: false);
        ref.read(suffixUploadMarkProvider.notifier).update(info);
        updateName(ref);
      },
      onClear: () {
        if (ref.watch(suffixUploadMarkProvider) != null) {
          ref.read(suffixUploadMarkProvider.notifier).clear();
        }
        ref.read(suffixControllerProvider.notifier).clear();
      },
    );
  }
}
