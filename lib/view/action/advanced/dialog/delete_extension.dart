import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/widget/action/dialog_item.dart';
import 'package:once_power/widget/base/switch.dart';

class DeleteExtensionGroup extends StatelessWidget {
  const DeleteExtensionGroup({
    super.key,
    required this.selected,
    required this.extension,
    required this.onExtensionChanged,
  });

  final bool selected;
  final bool extension;
  final void Function(bool) onExtensionChanged;

  @override
  Widget build(BuildContext context) {
    return SelectedBox(
      selected: selected,
      child: DialogItem(
        title: context.tr(AppL10n.removeExtension),
        children: [
          Container(
            height: AppNumber.widgetHeight,
            alignment: .centerLeft,
            child: EasySwitch(value: extension, onChanged: onExtensionChanged),
          ),
        ],
      ),
    );
  }
}
