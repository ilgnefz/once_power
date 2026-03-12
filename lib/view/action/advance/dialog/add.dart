import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/icons.dart';
import 'package:once_power/const/key.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/dialog.dart';
import 'package:once_power/core/update/advance.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/enum/date.dart';
import 'package:once_power/enum/file.dart';
import 'package:once_power/model/advance.dart';
import 'package:once_power/provider/advance.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/src/rust/api/file_info.dart';
import 'package:once_power/util/storage.dart';
import 'package:once_power/util/verify.dart';
import 'package:once_power/view/action/advance/dialog/add_date_separate.dart';
import 'package:once_power/view/action/advance/dialog/add_position.dart';
import 'package:once_power/view/action/advance/dialog/add_random.dart';
import 'package:once_power/view/action/advance/dialog/add_serial.dart';
import 'package:once_power/view/action/advance/dialog/add_serial_distinguish.dart';
import 'package:once_power/view/action/advance/dialog/add_type.dart';
import 'package:once_power/widget/base/dialog.dart';
import 'package:once_power/widget/common/input_field.dart';

import 'group_dropdown.dart';

class AddView extends ConsumerStatefulWidget {
  const AddView({super.key, this.menu});

  final AdvanceMenuAdd? menu;

  @override
  ConsumerState<AddView> createState() => _AddViewState();
}

class _AddViewState extends ConsumerState<AddView> {
  String value = '', prefix = '', suffix = '', custom = '', group = 'all';
  AddType type = AddType.text;
  int length = 1, digits = 1, start = 0, positionIndex = 1;
  DateType date = DateType.createdDate, distinguishDate = DateType.createdDate;
  DateStyle dateStyle = DateStyle.none;
  WeekdayStyle weekdayStyle = WeekdayStyle.none;
  TimeStyle timeStyle = TimeStyle.none;
  MetaDataType metaData = MetaDataType.title;
  DateSeparateType dateSeparate = DateSeparateType.none;
  DistinguishType distinguish = DistinguishType.none;
  List<String> randoms = [];
  String customRandom = '';
  AddPosition position = AddPosition.front;

  @override
  void initState() {
    super.initState();
    if (widget.menu == null) return;
    value = widget.menu!.value;
    type = widget.menu!.addType;
    length = widget.menu!.randomLen;
    date = widget.menu!.dateType;
    dateStyle = widget.menu!.dateStyle;
    weekdayStyle = widget.menu!.weekdayStyle;
    timeStyle = widget.menu!.timeStyle;
    prefix = widget.menu!.metaPrefix;
    metaData = widget.menu!.metaData;
    suffix = widget.menu!.metaSuffix;
    dateSeparate = widget.menu!.dateSeparate;
    custom = widget.menu!.customSeparate;
    digits = widget.menu!.digits;
    start = widget.menu!.start;
    distinguish = widget.menu!.distinguishType;
    distinguishDate = widget.menu!.distinguishDateType;
    randoms = widget.menu!.randomValue;
    position = widget.menu!.addPosition;
    positionIndex = widget.menu!.positionIndex;
    group = widget.menu!.group;
  }

  @override
  Widget build(BuildContext context) {
    return EasyDialog(
      width: 544,
      title: tr(AppL10n.advanceAddTitle),
      content: Column(
        spacing: AppNum.spaceMedium,
        children: [
          InputField(
            text: value,
            hintText: tr(AppL10n.advanceAddHint),
            onComplete: (value) => setState(() => value = value),
          ),
          AddTypeGroup(
            type: type,
            onChanged: (value) => setState(() => type = value),
            length: length,
            onLengthChanged: (value) => setState(() => length = value),
            date: date,
            onDateChange: (value) => setState(() => date = value),
            dateStyle: dateStyle,
            onDateStyleChange: (value) => setState(() => dateStyle = value),
            weekdayStyle: weekdayStyle,
            onWeekdayStyleChange: (value) =>
                setState(() => weekdayStyle = value),
            timeStyle: timeStyle,
            onTimeStyleChange: (value) => setState(() => timeStyle = value),
            prefix: prefix,
            onPrefixChanged: (value) => setState(() => prefix = value),
            metaData: metaData,
            onMetaDataChange: (value) => setState(() => metaData = value),
            suffix: suffix,
            onSuffixChanged: (value) => setState(() => suffix = value),
          ),
          AddDateSeparate(
            dateSeparate: dateSeparate,
            onDateSeparateChange: (value) =>
                setState(() => dateSeparate = value),
            custom: custom,
            onCustomChange: (value) => setState(() => custom = value),
          ),
          AddSerial(
            digits: digits,
            onDigitChanged: (value) => setState(() => digits = value),
            start: start,
            onStartChanged: (value) => setState(() => start = value),
          ),
          AddSerialDistinguish(
            type: distinguish,
            onChanged: (value) => setState(() => distinguish = value),
            dateType: distinguishDate,
            onDateTypeChange: (value) =>
                setState(() => distinguishDate = value),
          ),
          AddRandom(
            randoms: randoms,
            onChanged: (value) => setState(() => randoms = value),
          ),
          AddPositionGroup(
            position: position,
            onChanged: (value) => setState(() => position = value),
            positionIndex: positionIndex,
            onIndexChanged: (value) => setState(() => positionIndex = value),
          ),
        ],
      ),
      extraButton: GroupDropdown(
        value: group == 'all' ? tr(AppL10n.dialogAll) : group,
        onChanged: (value) {
          group = isAll(value) ? 'all' : value;
          setState(() {});
        },
      ),
      autoPop: false,
      onOk: () {
        String id = widget.menu?.id ?? generateId();
        AdvanceMenuAdd add = AdvanceMenuAdd(
          id: id,
          value: value,
          digits: digits,
          start: start,
          distinguishType: distinguish,
          addType: type,
          randomLen: length,
          dateType: date,
          dateStyle: dateStyle,
          weekdayStyle: weekdayStyle,
          timeStyle: timeStyle,
          dateSeparate: dateSeparate,
          customSeparate: custom,
          metaData: metaData,
          metaPrefix: prefix,
          metaSuffix: suffix,
          distinguishDateType: distinguishDate,
          randomValue: randoms,
          addPosition: position,
          positionIndex: positionIndex,
          group: group,
          checked: true,
        );
        widget.menu == null
            ? ref.read(advanceMenuListProvider.notifier).add(add)
            : ref.read(advanceMenuListProvider.notifier).update(id, add);
        ref.read(currentPresetNameProvider.notifier).update('');
        advanceUpdateName(ref);
        Navigator.pop(context);
        if (type.isMetaData && metaData.isLocation) {
          String? key = StorageUtil.getString(AppKeys.mapKey);
          if (key == null || key.isEmpty) showKeyInput(context);
        }
      },
    );
  }
}
