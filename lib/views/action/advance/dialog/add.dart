import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nanoid/nanoid.dart';
import 'package:once_power/constants/keys.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/cores/advance.dart';
import 'package:once_power/cores/dialog.dart';
import 'package:once_power/enums/advance.dart';
import 'package:once_power/enums/file.dart';
import 'package:once_power/enums/week.dart';
import 'package:once_power/models/advance.dart';
import 'package:once_power/provider/advance.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/utils/storage.dart';
import 'package:once_power/utils/verify.dart';
import 'package:once_power/views/action/advance/dialog/date_separate.dart';

import 'add_position_radio.dart';
import 'add_serial_distinguish.dart';
import 'add_type_radio.dart';
import 'common_dialog.dart';
import 'dialog_base_input.dart';
import 'group_dropdown.dart';
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
  int digits = 1, start = 1, posIndex = 1;
  List<String> randoms = [];
  DistinguishType distinguishType = DistinguishType.none;
  AddType type = AddType.text;
  int randomLen = 1;
  DateType dateType = DateType.createdDate;
  DateShowType dateSplit = DateShowType.none;
  TimeShowType timeSplit = TimeShowType.hidden;
  WeekdayStyle weekdayStyle = WeekdayStyle.none;
  DateSeparateType separateType = DateSeparateType.none;
  String customSeparate = '';
  AddPosition position = AddPosition.after;
  FileMetaData metaData = FileMetaData.title;
  String metaAddPrefix = '', metaAddSuffix = '';
  DateType distinguishDateType = DateType.createdDate;
  String group = 'all';

  @override
  void initState() {
    super.initState();
    if (widget.menu != null) {
      value = widget.menu!.value;
      digits = widget.menu!.digits;
      start = widget.menu!.start;
      posIndex = widget.menu!.posIndex;
      timeSplit = widget.menu!.timeSplit;
      randoms = widget.menu!.randomValue;
      distinguishType = widget.menu!.distinguishType;
      type = widget.menu!.addType;
      randomLen = widget.menu!.randomLen;
      dateType = widget.menu!.dateType;
      dateSplit = widget.menu!.dateSplit;
      weekdayStyle = widget.menu!.weekdayStyle;
      separateType = widget.menu!.separateType;
      customSeparate = widget.menu!.customSeparate;
      metaData = widget.menu!.metaData;
      metaAddPrefix = widget.menu!.metaAddPrefix;
      metaAddSuffix = widget.menu!.metaAddSuffix;
      position = widget.menu!.addPosition;
      distinguishDateType = widget.menu!.distinguishDateType;
      group = widget.menu!.group;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      width: 544,
      title: tr(AppL10n.advanceAddTitle),
      extraButton: GroupDropdown(
        value: group == 'all' ? tr(AppL10n.advanceAll) : group,
        onChanged: (value) {
          group = isAll(value!) ? 'all' : value;
          setState(() {});
        },
      ),
      child: Column(
        spacing: AppNum.spaceMedium,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DialogBaseInput(
            value: value,
            enable: type.isText,
            hintText: tr(AppL10n.advanceAddHint),
            onChanged: (newValue) => setState(() => value = newValue),
          ),
          AddTypeRadio(
            type: type,
            len: randomLen,
            date: dateType,
            dateSplit: dateSplit,
            timeSplit: timeSplit,
            weekdayStyle: weekdayStyle,
            metaData: metaData,
            metaAddPrefix: metaAddPrefix,
            metaAddSuffix: metaAddSuffix,
            typeChanged: (value) => setState(() => type = value),
            randomLenChange: (value) => setState(() => randomLen = value),
            dateChange: (value) => setState(() => dateType = value!),
            dateSplitChange: (value) => setState(() => dateSplit = value!),
            timeSplitChange: (value) => setState(() => timeSplit = value!),
            weekdayStyleChange: (value) =>
                setState(() => weekdayStyle = value!),
            metaDataChange: (value) => setState(() => metaData = value!),
            addPrefixChange: (value) => setState(() => metaAddPrefix = value!),
            addSuffixChange: (value) => setState(() => metaAddSuffix = value!),
          ),
          // SizedBox(height: 4.0),
          DateSeparateView(
            separateType: separateType,
            custom: customSeparate,
            separateChange: (value) => setState(() => separateType = value!),
            customChange: (value) => setState(() => customSeparate = value),
          ),
          // SizedBox(height: 4.0),
          NumInputGroup(
            digits: digits,
            start: start,
            onDigitsChanged: (value) => setState(() => digits = value),
            onStartChanged: (value) => setState(() => start = value),
          ),
          AddSerialDistinguish(
            type: distinguishType,
            dateType: distinguishDateType,
            typeChanged: (value) => setState(() => distinguishType = value),
            dateTypeChanged: (value) =>
                setState(() => distinguishDateType = value!),
          ),
          RandomCheckbox(
            randoms: randoms,
            onChange: (values) => setState(() => randoms = values),
          ),
          AddPositionRadio(
            addPosition: position,
            positionChanged: (value) => setState(() => position = value),
            posIndex: posIndex,
            posIndexChanged: (value) => setState(() => posIndex = value),
          ),
        ],
      ),
      onOk: () {
        String id = widget.menu != null ? widget.menu!.id : nanoid(10);
        AdvanceMenuAdd add = AdvanceMenuAdd(
          id: id,
          checked: true,
          value: value,
          digits: digits,
          start: start,
          randomValue: randoms,
          addType: type,
          distinguishType: distinguishType,
          randomLen: randomLen,
          addPosition: position,
          dateType: dateType,
          dateSplit: dateSplit,
          timeSplit: timeSplit,
          weekdayStyle: weekdayStyle,
          separateType: separateType,
          customSeparate: customSeparate,
          metaData: metaData,
          metaAddPrefix: metaAddPrefix,
          metaAddSuffix: metaAddSuffix,
          posIndex: posIndex,
          distinguishDateType: distinguishDateType,
          group: group,
        );
        if (widget.menu != null) {
          ref.read(advanceMenuListProvider.notifier).update(id, add);
        } else {
          ref.read(advanceMenuListProvider.notifier).add(add);
        }
        ref.read(currentPresetNameProvider.notifier).update('');
        if (metaData.isLocation) {
          String? key = StorageUtil.getString(AppKeys.mapKey);
          if (key == null || key.isEmpty) showKeyInput(context);
        }
        advanceUpdateName(ref);
      },
    );
  }
}
