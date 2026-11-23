import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dropdown/flutter_dropdown.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/delete.dart';
import 'package:once_power/enmu/file.dart';
import 'package:once_power/widget/action/dialog_item.dart';
import 'package:once_power/widget/action/input.dart';
import 'package:once_power/widget/base/dropdown.dart';
import 'package:once_power/widget/base/radio.dart';

class DeleteExtensionGroup extends StatelessWidget {
  const DeleteExtensionGroup({
    super.key,
    required this.selected,
    required this.extensionType,
    required this.onExtensionTypeChanged,
    required this.fileType,
    required this.onFileTypeChanged,
    required this.enter,
    required this.onEnterChanged,
  });

  final bool selected;
  final DeleteExtensionType extensionType;
  final void Function(DeleteExtensionType) onExtensionTypeChanged;
  final FileType fileType;
  final void Function(FileType) onFileTypeChanged;
  final String enter;
  final void Function(String) onEnterChanged;

  @override
  Widget build(BuildContext context) {
    return SelectedBox(
      selected: selected,
      child: RadioGroup<DeleteExtensionType>(
        groupValue: extensionType,
        onChanged: (value) => onExtensionTypeChanged(value!),
        child: DialogItem(
          title: context.tr(AppL10n.removeExtension),
          spacing: AppNumber.space,
          children: DeleteExtensionType.values.map((e) {
            return EasyRadio(
              label: e.label,
              value: e,
              space: 0.0,
              trailing: e.isType
                  ? EasyTextDropdown(
                      value: fileType,
                      items: FileType.values
                          .map((e) => TextDropdownItem(e, label: e.label))
                          .toList(),
                      onChanged: onFileTypeChanged,
                    )
                  : e.isInput
                  ? SizedBox(
                      width: 144,
                      child: EasyInput(
                        value: enter,
                        hintText: context.tr(AppL10n.deleteExtensionHint),
                        onChanged: onEnterChanged,
                      ),
                    )
                  : null,
            );
          }).toList(),
        ),
      ),
    );
  }
}
