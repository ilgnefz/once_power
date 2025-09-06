import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/advance.dart';
import 'package:once_power/enums/advance.dart';
import 'package:once_power/models/advance.dart';
import 'package:once_power/provider/advance.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/utils/verify.dart';

import 'common_dialog.dart';
import 'common_position_radio.dart';
import 'delete_extension_switch.dart';
import 'delete_match_input.dart';
import 'delete_type_group.dart';
import 'group_dropdown.dart';

class DeleteView extends ConsumerStatefulWidget {
  const DeleteView({super.key, this.menu});

  final AdvanceMenuDelete? menu;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DeleteViewState();
}

class _DeleteViewState extends ConsumerState<DeleteView> {
  String value = '';
  MatchContent location = MatchContent.first;
  int start = 1, end = 1, front = 1, back = 1;
  List<DeleteType> deleteTypes = [];
  bool deleteExt = false, useRegex = false;
  String group = 'all';

  @override
  void initState() {
    super.initState();
    if (widget.menu != null) {
      value = widget.menu!.value;
      location = widget.menu!.matchLocation;
      front = widget.menu!.front;
      back = widget.menu!.back;
      start = widget.menu!.start;
      end = widget.menu!.end;
      deleteTypes = widget.menu!.deleteTypes;
      deleteExt = widget.menu!.deleteExt;
      useRegex = widget.menu!.useRegex;
      group = widget.menu!.group;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: tr(AppL10n.advanceDeleteTitle),
      extraButton: GroupDropdown(
        value: group == 'all' ? tr(AppL10n.dialogAll) : group,
        onChanged: (value) {
          group = isAll(value!) ? 'all' : value;
          setState(() {});
        },
      ),
      child: Column(
        spacing: AppNum.spaceMedium,
        children: [
          DeleteMatchInput(
            value: value,
            enable: !location.isPosition && deleteTypes.isEmpty && !deleteExt,
            useRegex: useRegex,
            onChanged: (newValue) => setState(() => value = newValue),
            onPressed: () => setState(() => useRegex = !useRegex),
          ),
          CommonPositionRadio(
            location: location,
            onChanged: (value) => setState(() => location = value),
            front: front,
            back: back,
            onFrontChanged: (value) => setState(() => front = value),
            onBackChanged: (value) => setState(() => back = value),
            start: start,
            end: end,
            onStartChanged: (value) => setState(() => start = value),
            onEndChanged: (value) => setState(() => end = value),
          ),
          DeleteTypeGroup(
            deleteTypes: deleteTypes,
            onChanged: (value) {
              if (deleteTypes.contains(value)) {
                deleteTypes.remove(value);
              } else {
                deleteTypes.add(value);
              }
              setState(() {});
            },
          ),
          DeleteExtensionSwitch(
            value: deleteExt,
            onChanged: (value) => setState(() => deleteExt = value),
          ),
        ],
      ),
      onOk: () {
        String id = widget.menu != null ? widget.menu!.id : nanoid(10);
        AdvanceMenuDelete delete = AdvanceMenuDelete(
          id: id,
          checked: true,
          value: value,
          matchLocation: location,
          front: front,
          back: back,
          start: start,
          end: end,
          deleteTypes: deleteTypes,
          deleteExt: deleteExt,
          useRegex: useRegex,
          group: group,
        );
        if (widget.menu != null) {
          ref.read(advanceMenuListProvider.notifier).update(id, delete);
        } else {
          ref.read(advanceMenuListProvider.notifier).add(delete);
        }
        ref.read(currentPresetNameProvider.notifier).update('');
        advanceUpdateName(ref);
      },
    );
  }
}
