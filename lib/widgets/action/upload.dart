import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/cores/update.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/utils/debounce.dart';
import 'package:once_power/widgets/action/file_card.dart';
import 'package:once_power/widgets/base/base_input.dart';
import 'package:once_power/widgets/base/easy_tooltip.dart';
import 'package:once_power/widgets/common/click_icon.dart';

class UploadInput extends ConsumerWidget {
  const UploadInput({
    super.key,
    required this.hintText,
    required this.controller,
    required this.show,
    required this.info,
    required this.onClear,
    required this.onUpload,
  });

  final String hintText;
  final TextEditingController controller;
  final bool show;
  final UploadMarkInfo? info;
  final void Function() onClear;
  final void Function(String) onUpload;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseInput(
      hintText: hintText,
      controller: controller,
      show: show || info != null,
      leading: info != null ? UploadFileCard(info: info!) : null,
      onClear: () {
        onClear.call();
        Debounce.run(() => updateName(ref));
      },
      onChanged: (value) => Debounce.run(() => updateName(ref)),
      trailing: EasyTooltip(
        tip: tr(AppL10n.renameUpload),
        child: ClickIcon(
          icon: Icons.upload_file_rounded,
          iconSize: 18,
          color: Theme.of(context).inputDecorationTheme.iconColor,
          onPressed: () async {
            final xType = XTypeGroup(
              label: tr(AppL10n.renameText),
              extensions: const ['txt'],
            );
            final XFile? result = await openFile(acceptedTypeGroups: [xType]);
            if (result != null) onUpload(result.path);
          },
        ),
      ),
    );
  }
}
