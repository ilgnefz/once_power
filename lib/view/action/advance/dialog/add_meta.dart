import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/dialog.dart';
import 'package:once_power/enum/file.dart';
import 'package:once_power/widget/base/text.dart';
import 'package:once_power/widget/common/click_icon.dart';
import 'package:once_power/widget/common/text_dropdown.dart';
import 'package:once_power/widget/common/input_field.dart';

class AddMetaGroup extends StatelessWidget {
  const AddMetaGroup({
    super.key,
    required this.prefix,
    required this.onPrefixChanged,
    required this.metaData,
    required this.onMetaDataChange,
    required this.suffix,
    required this.onSuffixChanged,
  });

  final String prefix;
  final void Function(String) onPrefixChanged;
  final MetaDataType metaData;
  final void Function(MetaDataType) onMetaDataChange;
  final String suffix;
  final void Function(String) onSuffixChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: AppNum.spaceSmall,
      children: [
        SizedBox(
          width: 88,
          child: InputField(
            text: prefix,
            hintText: tr(AppL10n.advanceAddPrefix),
            onChanged: onPrefixChanged,
          ),
        ),
        TextDropdown<MetaDataType>(
          items: MetaDataType.values
              .map(
                (item) => DropdownItem(
                  key: ValueKey(item),
                  value: item,
                  height: AppNum.dropdownMenu,
                  child: BaseText(item.label),
                ),
              )
              .toList(),
          value: metaData,
          onChanged: onMetaDataChange,
        ),
        SizedBox(
          width: 88,
          child: InputField(
            text: suffix,
            hintText: tr(AppL10n.advanceAddSuffix),
            onChanged: onSuffixChanged,
          ),
        ),
        if (metaData.isLocation)
          RepaintBoundary(
            child: Transform.rotate(
              angle: 45,
              child: ClickIcon(
                icon: Icons.key_rounded,
                onPressed: () async => await showKeyInput(context),
              ),
            ),
          ),
      ],
    );
  }
}
