import 'package:flutter/material.dart';
import 'package:once_power/model/types.dart';
import 'package:once_power/provider/rename.dart';
import 'package:once_power/widgets/my_text.dart';
import 'package:once_power/widgets/simple_checkbox.dart';
import 'package:once_power/widgets/simple_dropdown.dart';
import 'package:once_power/widgets/simple_input.dart';
import 'package:once_power/widgets/space_box.dart';

final List<ModeType> modeTypeList = [
  ModeType.general,
  ModeType.reserved,
  ModeType.length,
];

final List<LoopType> useTypeList = [
  LoopType.no,
  LoopType.all,
  LoopType.prefix,
  LoopType.suffix,
];

class OperateGroup extends StatelessWidget {
  const OperateGroup(this.provider, {Key? key}) : super(key: key);

  final RenameProvider provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SimpleInput(
          hintText: provider.modeType == ModeType.length
              ? '输入指定长度字符串或 *N（N为数字）'
              : '匹配内容',
          controller: provider.matchTextController,
          hidden: provider.matchEmpty,
          onClear: () => provider.clearInput(provider.matchTextController),
          onChanged: (v) => provider.updateName(),
        ),
        const SpaceBoxHeight(),
        SimpleDropdown(
          leading: SimpleCheckbox(
            title: '区分大小写',
            checked: provider.caseSensitive,
            onChange: (v) => provider.toggleCheck('caseSensitive'),
          ),
          value: provider.modeType,
          onChanged: (value) => provider.switchModeType(value!),
          items: modeTypeList.map<DropdownMenuItem<ModeType>>((ModeType value) {
            return DropdownMenuItem<ModeType>(
              value: value,
              child: MyText(value.name),
            );
          }).toList(),
        ),
        const SpaceBoxHeight(),
        AbsorbPointer(
          absorbing: provider.modeType != ModeType.general ||
              provider.createDateRename,
          child: SimpleInput(
            hintText: provider.modeType != ModeType.general ||
                    provider.createDateRename
                ? '输入已禁用'
                : '修改为',
            controller: provider.updateTextController,
            hidden: provider.updateEmpty,
            onClear: () => provider.clearInput(provider.updateTextController),
            onChanged: (v) => provider.updateName(),
          ),
        ),
        const SpaceBoxHeight(),
        if (provider.modeType != ModeType.length)
          SimpleCheckbox(
            title: '以创建日期命名',
            checked: provider.createDateRename,
            onChange: (v) => provider.toggleCheck('createDateRename'),
          ),
        const SpaceBoxHeight(),
        LabelSimpleInput(
          label: '前缀',
          controller: provider.prefixTextController,
          uploadType: UploadType.prefix,
          provider: provider,
          // readOnly: provider.uploadPrefixText,
          hidden: provider.prefixEmpty,
          onChanged: (v) => provider.updateName(),
        ),
        const SpaceBoxHeight(),
        LabelSimpleInput(
          label: '后缀',
          controller: provider.suffixTextController,
          uploadType: UploadType.suffix,
          provider: provider,
          // readOnly: provider.uploadSuffixText,
          hidden: provider.suffixEmpty,
          onChanged: (v) => provider.updateName(),
        ),
        const SpaceBoxHeight(),
        SimpleDropdown(
          label: '循环文件内容',
          color: !provider.openLoopType ? Colors.grey : null,
          value: provider.loopType,
          onChanged: provider.openLoopType
              ? (value) => provider.toggleLoopType(value!)
              : null,
          items: useTypeList.map<DropdownMenuItem<LoopType>>((LoopType value) {
            return DropdownMenuItem<LoopType>(
              value: value,
              child: MyText(value.name),
            );
          }).toList(),
        ),
        const SpaceBoxHeight(),
        Row(
          children: [
            SimpleCheckbox(
              title: '前缀数字递增:',
              checked: provider.addPrefixNum,
              onChange: (v) => provider.toggleCheck('addPrefixNum'),
            ),
            const SpaceBoxWidth(),
            Expanded(
              child: SimpleInput(
                readOnly: !provider.addPrefixNum,
                hintText: provider.addPrefixNum ? '输入n位数个字符' : '输入已禁用',
                controller: provider.prefixNumController,
                hidden: provider.prefixNumEmpty,
                onClear: () =>
                    provider.clearInput(provider.prefixNumController),
                onChanged: (v) => provider.updateName(),
              ),
            ),
          ],
        ),
        const SpaceBoxHeight(),
        Row(
          children: [
            SimpleCheckbox(
              title: '后缀数字递增:',
              checked: provider.addSuffixNum,
              onChange: (v) => provider.toggleCheck('addSuffixNum'),
            ),
            const SpaceBoxWidth(),
            Expanded(
              child: SimpleInput(
                readOnly: !provider.addSuffixNum,
                hintText: provider.addSuffixNum ? '输入n位数个字符' : '输入已禁用',
                controller: provider.suffixNumController,
                hidden: provider.suffixNumEmpty,
                onClear: () =>
                    provider.clearInput(provider.suffixNumController),
                onChanged: (v) => provider.updateName(),
              ),
            ),
          ],
        ),
        const SpaceBoxHeight(),
        SimpleCheckbox(
          title: '交换递增数字位置',
          checked: provider.exchangeSeat,
          onChange: (v) => provider.toggleCheck('changePosition'),
        ),
      ],
    );
  }
}
