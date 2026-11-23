import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/widget/action/dialog_item.dart';
import 'package:once_power/widget/action/input.dart';
import 'package:once_power/widget/base/checkbox.dart';

class AddRandomGroup extends StatefulWidget {
  const AddRandomGroup({
    super.key,
    required this.selected,
    required this.randoms,
    required this.onRandomChanged,
  });

  final bool selected;
  final List<String> randoms;
  final void Function(List<String>) onRandomChanged;

  @override
  State<AddRandomGroup> createState() => _AddRandomGroupState();
}

class _AddRandomGroupState extends State<AddRandomGroup> {
  List<String> all = ['a-z', 'A-Z', '0-9', r'!@#$%^&*()_-+='];
  String customValue = '';

  void add(String value) {
    widget.randoms.contains(value)
        ? widget.randoms.remove(value)
        : widget.randoms.add(value);
    widget.onRandomChanged(widget.randoms);
  }

  @override
  void initState() {
    super.initState();
    for (String e in widget.randoms) {
      if (!all.contains(e)) {
        customValue = e;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SelectedBox(
      selected: widget.selected,
      child: DialogItem(
        title: context.tr(AppL10n.addRandom),
        padding: const .only(top: 4.0),
        // alignment: .spaceBetween,
        spacing: AppNumber.space,
        children: [
          ...all.map((e) {
            return EasyCheckbox(
              checked: widget.randoms.contains(e),
              label: e,
              onChanged: (_) => setState(() => add(e)),
            );
          }),
          EasyCheckbox(
            checked: customValue.isNotEmpty,
            onChanged: (_) {},
            child: SizedBox(
              width: 256,
              child: EasyInput(
                value: customValue,
                hintText: tr(AppL10n.addRandomHint),
                onChanged: (value) {
                  if (value.isNotEmpty) add(value);
                  customValue = value;
                  setState(() {});
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
