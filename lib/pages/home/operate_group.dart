import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/types.dart';
import 'package:once_power/provider/rename.dart';
import 'package:once_power/widgets/my_text.dart';
import 'package:once_power/widgets/simple_checkbox.dart';
import 'package:once_power/widgets/simple_chip.dart';
import 'package:once_power/widgets/simple_dropdown.dart';
import 'package:once_power/widgets/simple_input.dart';
import 'package:once_power/widgets/space_box.dart';

final List<ModeType> modeTypeList = [
  ModeType.general,
  ModeType.reserved,
  ModeType.length
];

final List<ReservedType> reservedTypeList = [
  ReservedType.capitalLetter,
  ReservedType.lowercaseLetter,
  ReservedType.digit,
  ReservedType.nonLetter,
  ReservedType.punctuation
];

final List<DateType> dateTypeList = [
  DateType.createDate,
  DateType.modifyDate,
  DateType.exifDate,
  DateType.earliestDate,
  DateType.latestDate
];

final List<LoopType> useTypeList = [
  LoopType.disable,
  LoopType.all,
  LoopType.prefix,
  LoopType.suffix
];

class OperateGroup extends StatelessWidget {
  const OperateGroup(this.provider, {Key? key}) : super(key: key);

  final RenameProvider provider;

  @override
  Widget build(BuildContext context) {
    final color = provider.modeType == ModeType.length && !provider.deleteLength
        ? Colors.grey
        : null;

    return Column(
      children: [
        // 输入匹配的内容
        AbsorbPointer(
          absorbing: provider.modeType == ModeType.reserved &&
              provider.reservedTypeList.isNotEmpty,
          child: SimpleInput(
            hintText: provider.modeType == ModeType.reserved &&
                    provider.reservedTypeList.isNotEmpty
                ? S.of(context).inputDisabled
                : provider.modeType == ModeType.length
                    ? S.of(context).lengthMatchText
                    : S.of(context).matchText,
            controller: provider.matchTextController,
            hidden: provider.matchEmpty,
            onClear: () => provider.clearInput(provider.matchTextController),
            onChanged: (v) => provider.updateName(),
          ),
        ),
        const SpaceBoxHeight(),
        // 选择模式
        SimpleDropdown(
          leading: provider.modeType != ModeType.length
              ? SimpleCheckbox(
                  title: S.of(context).caseSensitive,
                  checked: provider.caseSensitive,
                  onChange: (v) => provider.toggleCheck('caseSensitive'),
                )
              : SimpleCheckbox(
                  title: S.of(context).deleteLength,
                  checked: provider.deleteLength,
                  onChange: (v) => provider.toggleCheck('deleteLength'),
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
        // 保存模式的自动匹配 chip
        if (provider.modeType == ModeType.reserved) ...[
          const SpaceBoxHeight(),
          AbsorbPointer(
            absorbing: provider.modeType == ModeType.reserved &&
                provider.matchTextController.text.isNotEmpty,
            child: SizedBox(
              width: 320,
              child: Wrap(
                alignment: WrapAlignment.start,
                spacing: 8,
                runSpacing: 8.0,
                children: reservedTypeList
                    .map(
                      (e) => SimpleChip(
                        label: e.value,
                        selected: provider.reservedTypeList.contains(e),
                        color: provider.modeType == ModeType.reserved &&
                                provider.matchTextController.text.isNotEmpty
                            ? Colors.grey
                            : null,
                        onTap: () => provider.toggleReservedType(e),
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
        ],
        // 输入要修改的内容
        if (provider.modeType != ModeType.reserved) ...[
          const SpaceBoxHeight(),
          AbsorbPointer(
            absorbing: provider.modeType == ModeType.general
                ? provider.dateRename
                : provider.dateRename || !provider.deleteLength,
            child: SimpleInput(
              hintText: (provider.modeType == ModeType.general
                      ? provider.dateRename
                      : provider.dateRename || !provider.deleteLength)
                  ? S.of(context).inputDisabled
                  : S.of(context).updateText,
              controller: provider.updateTextController,
              hidden: provider.updateEmpty,
              onClear: () => provider.clearInput(provider.updateTextController),
              onChanged: (v) => provider.updateName(),
            ),
          ),
        ],
        const SpaceBoxHeight(),
        // 以日期命名的选项框
        AbsorbPointer(
          absorbing:
              provider.modeType == ModeType.length && !provider.deleteLength,
          child: SimpleDropdown(
            leading: Row(
              children: [
                SimpleCheckbox(
                  title: S.of(context).dateRename,
                  checked: provider.dateRename,
                  color: color,
                  onChange: provider.modeType == ModeType.length &&
                          !provider.deleteLength
                      ? null
                      : (v) => provider.toggleCheck('dateRename'),
                ),
                const SpaceBoxWidth(),
                DateDigit(provider: provider, color: color),
              ],
            ),
            value: provider.dateType,
            onChanged: provider.dateRename
                ? (value) => provider.switchDateType(value!)
                : null,
            items:
                dateTypeList.map<DropdownMenuItem<DateType>>((DateType value) {
              return DropdownMenuItem<DateType>(
                value: value,
                child: MyText(value.value),
              );
            }).toList(),
          ),
        ),
        const SpaceBoxHeight(),
        // 前缀输入框
        LabelSimpleInput(
          label: S.of(context).prefix,
          controller: provider.prefixTextController,
          uploadType: UploadType.prefix,
          provider: provider,
          hidden: provider.prefixEmpty,
          onChanged: (v) => provider.updateName(),
        ),
        const SpaceBoxHeight(),
        // 后缀输入框
        LabelSimpleInput(
          label: S.of(context).suffix,
          controller: provider.suffixTextController,
          uploadType: UploadType.suffix,
          provider: provider,
          hidden: provider.suffixEmpty,
          onChanged: (v) => provider.updateName(),
        ),
        const SpaceBoxHeight(),
        // 循环前缀和后缀的模式
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
        // 前缀递增数字
        Row(
          children: [
            MyText('${S.of(context).prefixDigitIncrement}:'),
            const SpaceBoxWidth(),
            Expanded(
              child: SimpleInput(
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
        // 后缀递增数字
        Row(
          children: [
            MyText('${S.of(context).suffixDigitIncrement}:'),
            const SpaceBoxWidth(),
            Expanded(
              child: SimpleInput(
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
        // 自定义前缀和后缀递增开始的数字
        Row(
          children: [
            MyText('${S.of(context).incrementalStartNumber}:'),
            const SpaceBoxWidth(),
            Expanded(
              child: SimpleInput(
                hintText: S.of(context).enterNumbers,
                controller: provider.startNumController,
                hidden: provider.startNumEmpty,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onClear: () => provider.clearInput(provider.startNumController),
                onChanged: (v) => provider.updateName(),
              ),
            ),
          ],
        ),
        const SpaceBoxHeight(),
        // 交换前后缀和前后缀递增数字位置
        SimpleCheckbox(
          title: S.of(context).exchangeSeat,
          checked: provider.exchangeSeat,
          onChange: (v) => provider.toggleCheck('changePosition'),
        ),
      ],
    );
  }
}

class DateDigit extends StatelessWidget {
  const DateDigit({super.key, required this.provider, required this.color});

  final RenameProvider provider;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 56,
      height: 24,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: provider.dateDigitsController,
              style: TextStyle(fontSize: 14, color: color),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(left: 4.0),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
          MyText(S.of(context).digits, color: color),
        ],
      ),
    );
  }
}
