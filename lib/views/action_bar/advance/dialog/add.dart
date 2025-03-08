import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/advance.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/advance_menu.dart';
import 'package:once_power/models/advance_menu_enum.dart';
import 'package:once_power/providers/advance.dart';

import 'add_position_radio.dart';
import 'add_serial_distinguish.dart';
import 'add_type_radio.dart';
import 'common_dialog.dart';
import 'dialog_base_input.dart';
import 'num_input_group.dart';
import 'random_checkbox.dart';

class AddView extends ConsumerStatefulWidget {
  const AddView({super.key, this.menu});

  final AdvanceMenuAdd? menu;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DeleteViewState();
}

class _DeleteViewState extends ConsumerState<AddView> {
  String value = '';
  int digits = 0, start = 1, posIndex = 1;
  List<String> randoms = [];
  DistinguishType distinguishType = DistinguishType.none;
  AddType type = AddType.text;
  int randomLen = 1;
  AddPosition position = AddPosition.after;

  @override
  void initState() {
    super.initState();
    if (widget.menu != null) {
      value = widget.menu!.value;
      digits = widget.menu!.digits;
      start = widget.menu!.start;
      posIndex = widget.menu!.posIndex;
      randoms = widget.menu!.randomValue;
      distinguishType = widget.menu!.distinguishType;
      type = widget.menu!.addType;
      randomLen = widget.menu!.randomLen;
      position = widget.menu!.addPosition;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: S.of(context).addTitle,
      child: Column(
        spacing: AppNum.mediumG,
        children: [
          DialogBaseInput(
              value: value,
              enable: type.isText,
              hintText: S.of(context).addInputHint,
              onChanged: (newValue) {
                value = newValue;
                setState(() {});
              }),
          NumInputGroup(
            digits: digits,
            start: start,
            onDigitsChanged: (value) {
              digits = value;
              setState(() {});
            },
            onStartChanged: (value) {
              start = value;
              setState(() {});
            },
          ),
          RandomCheckbox(
            randoms: randoms,
            onChange: (values) {
              randoms = values;
              setState(() {});
            },
          ),
          AddSerialDistinguish(
            type: distinguishType,
            typeChanged: (value) {
              distinguishType = value;
              setState(() {});
            },
          ),
          AddTypeRadio(
            type: type,
            len: randomLen,
            typeChanged: (value) {
              type = value;
              setState(() {});
            },
            randomLenChange: (value) {
              randomLen = value;
              setState(() {});
            },
          ),
          AddPositionRadio(
            addPosition: position,
            positionChanged: (value) {
              position = value;
              setState(() {});
            },
            posIndex: posIndex,
            posIndexChanged: (value) {
              posIndex = value;
              setState(() {});
            },
          ),
        ],
      ),
      onOk: () {
        String id = widget.menu != null ? widget.menu!.id : nanoid(10);
        AdvanceMenuAdd add = AdvanceMenuAdd(
          id: id,
          value: value,
          digits: digits,
          start: start,
          randomValue: randoms,
          addType: type,
          distinguishType: distinguishType,
          randomLen: randomLen,
          addPosition: position,
          posIndex: posIndex,
        );
        if (widget.menu != null) {
          ref.read(advanceMenuListProvider.notifier).update(id, add);
        } else {
          ref.read(advanceMenuListProvider.notifier).add(add);
        }
        advanceUpdateName(ref);
      },
    );
  }
}
