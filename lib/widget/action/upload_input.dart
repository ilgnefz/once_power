import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/core/update/normal.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/util/debounce.dart';
import 'package:once_power/widget/common/click_icon.dart';
import 'package:once_power/widget/common/text_input.dart';

import 'file_card.dart';

class UploadInput extends ConsumerWidget {
  const UploadInput({
    super.key,
    required this.hintText,
    required this.controller,
    required this.infoProvider,
    required this.onUpload,
  });

  final String hintText;
  final dynamic controller;
  final dynamic infoProvider;
  final void Function(String) onUpload;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UploadMarkInfo? info = ref.watch(infoProvider);
    return TextInput(
      controller: ref.watch(controller),
      hintText: hintText,
      leading: info == null ? null : UploadFileCard(info: info),
      onChange: (_) => Debounce.run(() => normalUpdateName(ref)),
      onClear: ref.read(infoProvider.notifier).clear,
      action: ClickIcon(
        tip: tr(AppL10n.renameUpload),
        icon: Icons.upload_file_rounded,
        onPressed: () async {
          final xType = XTypeGroup(
            label: tr(AppL10n.renameText),
            extensions: const ['txt'],
          );
          final XFile? result = await openFile(acceptedTypeGroups: [xType]);
          if (result != null) onUpload(result.path);
        },
      ),
    );
  }
}
