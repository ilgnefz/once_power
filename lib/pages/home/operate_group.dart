import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
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
  LoopType.disable,
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
              ? S.of(context).lengthMatchText
              : S.of(context).matchText,
          controller: provider.matchTextController,
          hidden: provider.matchEmpty,
          onClear: () => provider.clearInput(provider.matchTextController),
          onChanged: (v) => provider.updateName(),
        ),
        const SpaceBoxHeight(),
        SimpleDropdown(
          leading: SimpleCheckbox(
            title: S.of(context).caseSensitive,
            checked: provider.caseSensitive,
            onChange: (v) => provider.toggleCheck('caseSensitive'),
          ),
          value: provider.modeType,
          onChanged: (value) => provider.switchModeType(value!),
          items: modeTypeList.map<DropdownMenuItem<ModeType>>((ModeType value) {
            return DropdownMenuItem<ModeType>(
              value: value,
              child: MyText(value.value),
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
                ? S.of(context).inputDisabled
                : S.of(context).updateText,
            controller: provider.updateTextController,
            hidden: provider.updateEmpty,
            onClear: () => provider.clearInput(provider.updateTextController),
            onChanged: (v) => provider.updateName(),
          ),
        ),
        const SpaceBoxHeight(),
        if (provider.modeType != ModeType.length)
          SimpleCheckbox(
            title: S.of(context).createDateRename,
            checked: provider.createDateRename,
            onChange: (v) => provider.toggleCheck('createDateRename'),
          ),
        const SpaceBoxHeight(),
        LabelSimpleInput(
          label: S.of(context).prefix,
          controller: provider.prefixTextController,
          uploadType: UploadType.prefix,
          provider: provider,
          // readOnly: provider.uploadPrefixText,
          hidden: provider.prefixEmpty,
          onChanged: (v) => provider.updateName(),
        ),
        const SpaceBoxHeight(),
        LabelSimpleInput(
          label: S.of(context).suffix,
          controller: provider.suffixTextController,
          uploadType: UploadType.suffix,
          provider: provider,
          // readOnly: provider.uploadSuffixText,
          hidden: provider.suffixEmpty,
          onChanged: (v) => provider.updateName(),
        ),
        const SpaceBoxHeight(),
        SimpleDropdown(
          label: S.of(context).loopFileContent,
          color: !provider.openLoopType ? Colors.grey : null,
          value: provider.loopType,
          onChanged: provider.openLoopType
              ? (value) => provider.toggleLoopType(value!)
              : null,
          items: useTypeList.map<DropdownMenuItem<LoopType>>((LoopType value) {
            return DropdownMenuItem<LoopType>(
              value: value,
              child: MyText(value.value),
            );
          }).toList(),
        ),
        const SpaceBoxHeight(),
        Row(
          children: [
            // SimpleCheckbox(
            //   title: '${S.of(context).prefixDigitIncrement}:',
            //   checked: provider.addPrefixNum,
            //   onChange: (v) => provider.toggleCheck('addPrefixNum'),
            // ),
            MyText('${S.of(context).prefixDigitIncrement}:'),
            const SpaceBoxWidth(),
            Expanded(
              child: SimpleInput(
                // readOnly: !provider.addPrefixNum,
                // hintText: provider.addPrefixNum
                //     ? S.of(context).digitIncrementHint
                //     : '输入已禁用',
                hintText: S.of(context).digitIncrementHint,
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
            // SimpleCheckbox(
            //   title: '${S.of(context).suffixDigitIncrement}:',
            //   checked: provider.addSuffixNum,
            //   onChange: (v) => provider.toggleCheck('addSuffixNum'),
            // ),
            MyText('${S.of(context).suffixDigitIncrement}:'),
            const SpaceBoxWidth(),
            Expanded(
              child: SimpleInput(
                // readOnly: !provider.addSuffixNum,
                // hintText: provider.addSuffixNum
                //     ? S.of(context).digitIncrementHint
                //     : '输入已禁用',
                hintText: S.of(context).digitIncrementHint,
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
          title: S.of(context).exchangeSeat,
          checked: provider.exchangeSeat,
          onChange: (v) => provider.toggleCheck('changePosition'),
        ),
      ],
    );
  }
}
