import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/advance.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu.dart';
import 'package:once_power/models/advance_menu_enum.dart';
import 'package:once_power/providers/advance.dart';
import 'package:once_power/providers/value.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/views/action_bar/advance/dialog/delete_extension_switch.dart';
import 'package:once_power/views/action_bar/advance/dialog/delete_match_input.dart';

import 'common_dialog.dart';
import 'common_position_radio.dart';
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
      title: S.of(context).deleteTitle,
      extraButton: GroupDropdown(
        value: group == 'all' ? S.current.all : group,
        onChanged: (value) {
          group = isAll(value!) ? 'all' : value;
          setState(() {});
        },
      ),
      child: Column(
        spacing: AppNum.mediumG,
        children: [
          DeleteMatchInput(
            value: value,
            enable: !location.isPosition && deleteTypes.isEmpty && !deleteExt,
            useRegex: useRegex,
            onChanged: (newValue) {
              value = newValue;
              setState(() {});
            },
            onTap: () {
              useRegex = !useRegex;
              setState(() {});
            },
          ),
          CommonPositionRadio(
            location: location,
            onChanged: (value) {
              location = value;
              setState(() {});
            },
            front: front,
            back: back,
            onFrontChanged: (value) {
              front = value;
              setState(() {});
            },
            onBackChanged: (value) {
              back = value;
              setState(() {});
            },
            start: start,
            end: end,
            onStartChanged: (value) {
              start = value;
              setState(() {});
            },
            onEndChanged: (value) {
              end = value;
              setState(() {});
            },
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
            onChanged: (value) {
              deleteExt = value;
              setState(() {});
            },
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
