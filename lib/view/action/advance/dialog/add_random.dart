import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/widget/action/dialog_option.dart';
import 'package:once_power/widget/common/checkbox.dart';
import 'package:once_power/widget/common/input_field.dart';

class AddRandom extends StatefulWidget {
  const AddRandom({super.key, required this.randoms, required this.onChanged});

  final List<String> randoms;
  final void Function(List<String>) onChanged;

  @override
  State<AddRandom> createState() => _AddRandomState();
}

class _AddRandomState extends State<AddRandom> {
  List<String> all = ['a-z', 'A-Z', '0-9', r'!@#$%^&*()_-+='];
  String customValue = '';

  void add(String value) {
    widget.randoms.contains(value)
        ? widget.randoms.remove(value)
        : widget.randoms.add(value);
    widget.onChanged(widget.randoms);
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
    return DialogOption(
      title: tr(AppL10n.advanceRandom),
      padding: const .only(top: 4.0),
      alignment: .spaceBetween,
      children: [
        ...all.map(
          (e) => EasyCheckbox(
            checked: widget.randoms.contains(e),
            label: e,
            onChanged: (_) => setState(() => add(e)),
          ),
        ),
        EasyCheckbox(
          checked: customValue.isNotEmpty,
          onChanged: (_) {},
          child: SizedBox(
            width: 256,
            child: InputField(
              text: customValue,
              hintText: tr(AppL10n.advanceRandomHint),
              onChanged: (value) {
                if (value.isNotEmpty) add(value);
                customValue = value;
                setState(() {});
              },
            ),
          ),
        ),
      ],
    );
  }
}
