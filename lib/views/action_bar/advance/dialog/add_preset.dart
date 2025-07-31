import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/models/notification.dart';
import 'package:once_power/providers/advance.dart';

import 'common_dialog.dart';
import 'dialog_base_input.dart';

class AddPreset extends ConsumerStatefulWidget {
  const AddPreset({super.key, this.preset});

  final AdvancePreset? preset;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPresetState();
}

class _AddPresetState extends ConsumerState<AddPreset> {
  String name = '';

  @override
  void initState() {
    super.initState();
    final preset = widget.preset;
    if (preset != null) {
      name = preset.name;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: S.of(context).presetName,
      autoPop: false,
      onOk: () {
        if (name == '') {
          return NotificationInfo(
            type: NotificationType.error,
            title: S.of(context).presetNameErrorTitle,
            message: S.of(context).presetNameError,
            time: 3,
          ).show();
        }
        if (widget.preset == null) {
          List<AdvanceMenuModel> menus = ref.watch(advanceMenuListProvider);
          AdvancePreset preset =
              AdvancePreset(id: nanoid(10), name: name, menus: menus);
          ref.read(advancePresetListProvider.notifier).add(preset);
        } else {
          ref.read(advancePresetListProvider.notifier).update(
                widget.preset!.copyWith(name: name),
              );
        }
        Navigator.of(context).pop();
      },
      child: DialogBaseInput(
        value: name,
        autofocus: true,
        hintText: S.of(context).presetNameHint,
        onChanged: (value) {
          name = value;
          setState(() {});
        },
      ),
    );
  }
}
