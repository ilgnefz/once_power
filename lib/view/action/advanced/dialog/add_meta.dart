import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/add.dart';
import 'package:once_power/widget/action/dialog_item.dart';
import 'package:once_power/widget/action/input.dart';
import 'package:once_power/widget/base/dropdown.dart';
import 'package:once_power/widget/base/icon.dart';

class AddMetaGroup extends StatelessWidget {
  const AddMetaGroup({
    super.key,
    required this.selected,
    required this.prefix,
    required this.onPrefixChanged,
    required this.metaData,
    required this.onMetaDataChange,
    required this.suffix,
    required this.onSuffixChanged,
  });

  final bool selected;
  final String prefix;
  final void Function(String) onPrefixChanged;
  final MetaDataType metaData;
  final void Function(MetaDataType) onMetaDataChange;
  final String suffix;
  final void Function(String) onSuffixChanged;

  @override
  Widget build(BuildContext context) {
    return SelectedBox(
      selected: selected,
      child: DialogItem(
        title: context.tr(AppL10n.addMeta),
        spacing: AppNumber.spaceSmall,
        children: [
          const SizedBox(width: AppNumber.spaceSmall),
          SizedBox(
            width: 120,
            child: EasyInput(
              value: prefix,
              hintText: context.tr(AppL10n.prefix),
              onChanged: onPrefixChanged,
            ),
          ),
          EasyTextDropdown<MetaDataType>(
            items: MetaDataType.values.map((item) {
              return TextDropdownItem(item, label: item.label);
            }).toList(),
            value: metaData,
            onChanged: onMetaDataChange,
          ),
          SizedBox(
            width: 120,
            child: EasyInput(
              value: suffix,
              hintText: tr(AppL10n.suffix),
              onChanged: onSuffixChanged,
            ),
          ),
          if (metaData.isLocation)
            RepaintBoundary(
              child: Transform.rotate(
                angle: 45,
                child: ClickIcon(
                  icon: Icons.key_rounded,
                  // TODO: 打开
                  // onPressed: () async => await showMapKeyInput(context),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
