import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu.dart';
import 'package:once_power/models/app_enum.dart';
import 'package:once_power/models/notification.dart';
import 'package:once_power/providers/advance.dart';
import 'package:once_power/providers/value.dart';
import 'package:once_power/widgets/content_bar/easy_click_text.dart';

import 'common_dialog.dart';
import 'dialog_base_input.dart';

class AddPreset extends ConsumerStatefulWidget {
  const AddPreset({super.key, this.preset});

  final AdvancePreset? preset;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPresetState();
}

class _AddPresetState extends ConsumerState<AddPreset> {
  List<String> presetNames = [];
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    String name = '';
    final preset = widget.preset;
    if (preset != null) name = preset.name;
    controller = TextEditingController(text: name)
      ..addListener(() => setState(() {}));
    presetNames =
        ref.read(advancePresetListProvider).map((e) => e.name).toList();
    setState(() {});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: S.of(context).presetName,
      autoPop: false,
      onOk: () {
        String presetName = controller.text;
        if (presetName == '') {
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
              AdvancePreset(id: nanoid(10), name: presetName, menus: menus);
          ref.read(advancePresetListProvider.notifier).add(preset);
        } else {
          ref
              .read(advancePresetListProvider.notifier)
              .update(widget.preset!.copyWith(name: presetName));
          String currentPresetName = ref.watch(currentPresetNameProvider);
          if (currentPresetName != '' &&
              currentPresetName == widget.preset?.name) {
            ref.read(currentPresetNameProvider.notifier).update(presetName);
          }
        }
        Navigator.of(context).pop();
      },
      child: Column(
        spacing: AppNum.smallG,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 200),
            child: Wrap(
              spacing: AppNum.smallG,
              runSpacing: AppNum.smallG,
              alignment: WrapAlignment.start,
              children: presetNames
                  .map((e) => EasyClickText(
                        label: e,
                        color: Colors.grey,
                        fontSize: 13,
                        onTap: () => setState(() => controller.text = e),
                      ))
                  .toList(),
            ),
          ),
          DialogBaseInput(
            // value: name,
            controller: controller,
            autofocus: true,
            hintText: S.of(context).presetNameHint, onChanged: (v) {},
          ),
          Text(
            S.current.addPresetDesc,
            style: TextStyle(fontSize: 12, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
