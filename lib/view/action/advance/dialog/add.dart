import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/key.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/dialog.dart';
import 'package:once_power/core/update/advance.dart';
import 'package:once_power/enum/advance.dart';
import 'package:once_power/enum/file.dart';
import 'package:once_power/model/advance_add.dart';
import 'package:once_power/provider/advance.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/src/rust/api/file_info.dart';
import 'package:once_power/util/storage.dart';
import 'package:once_power/util/verify.dart';
import 'package:once_power/view/action/advance/dialog/add_date_separate.dart';
import 'package:once_power/view/action/advance/dialog/add_position.dart';
import 'package:once_power/view/action/advance/dialog/add_random.dart';
import 'package:once_power/view/action/advance/dialog/add_index.dart';
import 'package:once_power/view/action/advance/dialog/add_index_distinction.dart';
import 'package:once_power/view/action/advance/dialog/add_mode.dart';
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
  String value = '';
  AddMode mode = AddMode.text;
  AdvanceDate advanceDate = AdvanceDate();
  AdvanceMetaData metaData = AdvanceMetaData();
  AdvanceIndex advanceIndex = AdvanceIndex();
  int randomLength = 1;
  List<String> randoms = [];
  AddPosition position = AddPosition.behind;
  int positionIndex = 1;
  String group = 'all';

  @override
  void initState() {
    super.initState();
    if (widget.menu == null) return;
    value = widget.menu!.value;
    mode = widget.menu!.mode;
    advanceDate = widget.menu!.advanceDate;
    metaData = widget.menu!.metaData;
    advanceIndex = widget.menu!.advanceIndex;
    randomLength = widget.menu!.randomLength;
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
        mainAxisSize: .min,
        children: [
          InputField(
            text: value,
            hintText: tr(AppL10n.advanceAddHint),
            onChanged: (value) => setState(() {
              this.value = value;
              mode = AddMode.text;
            }),
          ),
          AddModeGroup(
            mode: mode,
            onModeChanged: (value) => setState(() => mode = value),
            randomLength: randomLength,
            onRandomLengthChanged: (value) => setState(() {
              randomLength = value;
              mode = AddMode.random;
            }),
            advanceDate: advanceDate,
            onDateTypeChange: (value) => setState(() {
              advanceDate = advanceDate.copyWith(type: value);
              mode = AddMode.date;
            }),
            onDateStyleChange: (value) => setState(() {
              advanceDate = advanceDate.copyWith(dateStyle: value);
              mode = AddMode.date;
            }),
            onWeekdayStyleChange: (value) => setState(() {
              advanceDate = advanceDate.copyWith(weekdayStyle: value);
              mode = AddMode.date;
            }),
            onTimeStyleChange: (value) {
              advanceDate = advanceDate.copyWith(timeStyle: value);
              mode = AddMode.date;
            },
            metaData: metaData,
            onMetaDataChange: (value) => setState(() {
              metaData = metaData.copyWith(type: value);
              mode = AddMode.metaData;
            }),
            onPrefixChanged: (value) => setState(() {
              metaData = metaData.copyWith(prefix: value);
              mode = AddMode.metaData;
            }),
            onSuffixChanged: (value) => setState(() {
              metaData = metaData.copyWith(suffix: value);
              mode = AddMode.metaData;
            }),
          ),
          AddDateSeparate(
            dateSeparate: advanceDate.dateSeparate,
            onDateSeparateChange: (value) => setState(() {
              advanceDate = advanceDate.copyWith(dateSeparate: value);
              mode = AddMode.date;
            }),
            custom: advanceDate.separate,
            onCustomChange: (value) => setState(() {
              advanceDate = advanceDate.copyWith(separate: value);
              mode = AddMode.date;
            }),
          ),
          AddIndex(
            width: advanceIndex.width,
            onWidthChanged: (value) => setState(() {
              advanceIndex = advanceIndex.copyWith(width: value);
              mode = AddMode.indexes;
            }),
            start: advanceIndex.start,
            onStartChanged: (value) => setState(() {
              advanceIndex = advanceIndex.copyWith(start: value);
              mode = AddMode.indexes;
            }),
          ),
          AddIndexDistinction(
            distinction: advanceIndex.distinction,
            onChanged: (value) => setState(() {
              advanceIndex = advanceIndex.copyWith(distinction: value);
              mode = AddMode.indexes;
            }),
            dateType: advanceIndex.dateType,
            onDateTypeChange: (value) => setState(() {
              advanceIndex = advanceIndex.copyWith(
                distinction: IndexDistinction.date,
                dateType: value,
              );
              mode = AddMode.indexes;
            }),
          ),
          AddRandom(
            randoms: randoms,
            onChanged: (value) => setState(() {
              randoms = value;
              mode = AddMode.random;
            }),
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
          mode: mode,
          advanceDate: advanceDate,
          metaData: metaData,
          advanceIndex: advanceIndex,
          randomLength: randomLength,
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
        if (mode.isMetaData && metaData.type.isLocation) {
          String? key = StorageUtil.getString(AppKeys.mapKey);
          if (key == null || key.isEmpty) showKeyInput(context);
        }
      },
    );
  }
}
