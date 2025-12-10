import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/config/theme.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/notification.dart';
import 'package:once_power/models/advance.dart';
import 'package:once_power/provider/advance.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/widgets/content/easy_click_text.dart';

import '../dialog/common_dialog.dart';
import '../dialog/dialog_base_input.dart';

class AddPresetView extends ConsumerStatefulWidget {
  const AddPresetView({super.key, this.preset});

  final AdvancePreset? preset;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddPresetState();
}

class _AddPresetState extends ConsumerState<AddPresetView> {
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
      title: tr(AppL10n.advancePresetName),
      autoPop: false,
      onOk: () {
        String presetName = controller.text;
        if (presetName == '') showPresetAddErrorNotification();
        if (widget.preset == null) {
          List<AdvanceMenuModel> menus = ref.watch(advanceMenuListProvider);
          AdvancePreset preset = AdvancePreset(
            id: nanoid(10),
            name: presetName,
            menus: menus,
          );
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
        spacing: AppNum.spaceMedium,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 200),
            child: Wrap(
              spacing: AppNum.spaceSmall,
              runSpacing: AppNum.spaceSmall,
              alignment: WrapAlignment.start,
              children: presetNames
                  .map(
                    (e) => EasyClickText(
                      label: e,
                      color: Colors.grey,
                      fontSize: 13,
                      onTap: () => setState(() => controller.text = e),
                    ),
                  )
                  .toList(),
            ),
          ),
          DialogBaseInput(
            controller: controller,
            hintText: tr(AppL10n.advancePresetNameHint),
            onChanged: (v) {},
          ),
          Text(
            tr(AppL10n.advanceAddPresetDesc),
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey,
              fontFamily: defaultFont,
            ),
          ),
        ],
      ),
    );
  }
}
