import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/model/advance.dart';
import 'package:once_power/provider/advance.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/src/rust/api/file_info.dart';
import 'package:once_power/util/notification.dart';
import 'package:once_power/widget/base/dialog.dart';
import 'package:once_power/widget/base/text.dart';
import 'package:once_power/widget/common/click_text.dart';
import 'package:once_power/widget/common/input_field.dart';

class AddPresetView extends ConsumerStatefulWidget {
  const AddPresetView({super.key, this.preset});

  final AdvancePreset? preset;

  @override
  ConsumerState<AddPresetView> createState() => _AddPresetViewState();
}

class _AddPresetViewState extends ConsumerState<AddPresetView> {
  List<String> nameList = [];
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    nameList = ref.read(advancePresetListProvider).map((e) => e.name).toList();
    controller = TextEditingController(text: widget.preset?.name);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EasyDialog(
      title: tr(AppL10n.advancePresetName),
      content: Column(
        spacing: AppNum.spaceMedium,
        crossAxisAlignment: .start,
        mainAxisSize: .min,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 200),
            child: Wrap(
              spacing: AppNum.spaceSmall,
              runSpacing: AppNum.spaceSmall,
              alignment: WrapAlignment.start,
              children: nameList
                  .map(
                    (e) => EasyClickText(
                      label: e,
                      radius: 8,
                      color: Colors.grey,
                      onPressed: () => setState(() => controller.text = e),
                    ),
                  )
                  .toList(),
            ),
          ),
          InputField(
            controller: controller,
            autofocus: true,
            hintText: tr(AppL10n.advancePresetNameHint),
          ),
          BaseText(
            tr(AppL10n.advanceAddPresetDesc),
            fontSize: 12,
            color: Colors.grey,
          ),
        ],
      ),
      autoPop: false,
      onOk: () {
        String name = controller.text.trim();
        if (name == '') return showPresetAddErrorNotification();
        if (widget.preset == null) {
          List<AdvanceMenuModel> menus = ref.read(advanceMenuListProvider);
          AdvancePreset preset = AdvancePreset(
            id: generateId(),
            name: name,
            menus: menus,
          );
          ref.read(advancePresetListProvider.notifier).add(preset);
        } else {
          ref
              .read(advancePresetListProvider.notifier)
              .update(widget.preset!.copyWith(name: name));
          String currentPresetName = ref.read(currentPresetNameProvider);
          if (currentPresetName.isNotEmpty &&
              currentPresetName == widget.preset?.name) {
            ref.read(currentPresetNameProvider.notifier).update(name);
          }
        }
        Navigator.pop(context);
      },
    );
  }
}
