import 'package:flutter/material.dart';
import 'package:once_power/model/my_type.dart';
import 'package:once_power/provider/action.dart';
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

final List<UseType> useTypeList = [
  UseType.no,
  UseType.all,
  UseType.prefix,
  UseType.suffix,
];

class OperateGroup extends StatelessWidget {
  const OperateGroup(this.provider, {Key? key}) : super(key: key);

  final ActionProvider provider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SimpleInput(
          hintText: provider.modeType == ModeType.length
              ? '输入指定长度字符串或 *N（N为数字）'
              : '匹配内容',
          controller: provider.matchText,
          hidden: provider.originNull,
          onClear: () => provider.clearInput(provider.matchText),
          onChanged: (v) => provider.inputChange(v),
        ),
        const SpaceBox(),
        SimpleDropdown(
          leading: SimpleCheckbox(
            title: '区分大小写',
            checked: provider.caseSensitive,
            onChange: (v) => provider.switchUse('caseSensitive'),
          ),
          value: provider.modeType,
          onChanged: (value) => provider.toggleModeType(value!),
          items: modeTypeList.map<DropdownMenuItem<ModeType>>((ModeType value) {
            return DropdownMenuItem<ModeType>(
              value: value,
              child: MyText(value.name),
            );
          }).toList(),
        ),
        const SpaceBox(),
        AbsorbPointer(
          absorbing: provider.createDateRename,
          child: SimpleInput(
            hintText: provider.createDateRename ? '输入已禁用' : '修改为',
            controller: provider.targetText,
            hidden: provider.targetNull,
            onClear: () => provider.clearInput(provider.targetText),
            onChanged: (v) => provider.inputChange(v),
          ),
        ),
        const SpaceBox(),
        Row(
          children: [
            SimpleCheckbox(
              title: '以创建日期命名',
              checked: provider.createDateRename,
              onChange: (v) => provider.switchUse('createDateRename'),
            ),
          ],
        ),
        const SpaceBox(),
        LabelSimpleInput(
          label: '前缀',
          controller: provider.prefixText,
          uploadType: UploadType.prefix,
          provider: provider,
          // readOnly: provider.uploadPrefixText,
          hidden: provider.prefixNull,
          onChanged: (v) => provider.inputChange(v),
        ),
        const SpaceBox(),
        LabelSimpleInput(
          label: '后缀',
          controller: provider.suffixText,
          uploadType: UploadType.suffix,
          provider: provider,
          // readOnly: provider.uploadSuffixText,
          hidden: provider.suffixNull,
          onChanged: (v) => provider.inputChange(v),
        ),
        const SpaceBox(),
        SimpleDropdown(
          label: '循环文件内容',
          color: !provider.openUseType ? Colors.grey : null,
          value: provider.useType,
          onChanged: provider.openUseType
              ? (value) => provider.toggleUseType(value!)
              : null,
          items: useTypeList.map<DropdownMenuItem<UseType>>((UseType value) {
            return DropdownMenuItem<UseType>(
              value: value,
              child: MyText(value.name),
            );
          }).toList(),
        ),
        const SpaceBox(),
        Row(
          children: [
            SimpleCheckbox(
              title: '前缀数字递增',
              checked: provider.addPrefixNum,
              onChange: (v) => provider.switchUse('addPrefixNum'),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: SimpleInput(
                readOnly: !provider.addPrefixNum,
                hintText: provider.addPrefixNum ? '输入n位数个字符' : '输入已禁用',
                controller: provider.prefixNumText,
                hidden: provider.prefixNumNull,
                onClear: () => provider.clearInput(provider.prefixNumText),
                onChanged: (v) => provider.inputChange(v),
              ),
            ),
          ],
        ),
        const SpaceBox(),
        Row(
          children: [
            SimpleCheckbox(
              title: '后缀数字递增',
              checked: provider.addSuffixNum,
              onChange: (v) => provider.switchUse('addSuffixNum'),
            ),
            const SizedBox(width: 8.0),
            Expanded(
              child: SimpleInput(
                readOnly: !provider.addSuffixNum,
                hintText: provider.addSuffixNum ? '输入n位数个字符' : '输入已禁用',
                controller: provider.suffixNumText,
                hidden: provider.suffixNumNull,
                onClear: () => provider.clearInput(provider.suffixNumText),
                onChanged: (v) => provider.inputChange(v),
              ),
            ),
          ],
        ),
        const SpaceBox(),
        SimpleCheckbox(
          title: '交换递增数字位置',
          checked: provider.changePosition,
          onChange: (v) => provider.switchUse('changePosition'),
        ),
      ],
    );
  }
}
