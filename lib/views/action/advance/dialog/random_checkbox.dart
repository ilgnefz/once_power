import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/widgets/action/dialog_option.dart';
import 'package:once_power/widgets/base/base_input.dart';
import 'package:once_power/widgets/base/easy_checkbox.dart';

class RandomCheckbox extends StatefulWidget {
  const RandomCheckbox({
    super.key,
    required this.randoms,
    required this.onChange,
  });

  final List<String> randoms;
  final void Function(List<String>) onChange;

  @override
  State<RandomCheckbox> createState() => _RandomCheckboxState();
}

class _RandomCheckboxState extends State<RandomCheckbox> {
  TextEditingController controller = TextEditingController();

  final List<String> all = ['a-z', 'A-Z', r'!@#$%^&*()_-+=', '0-9'];

  bool show = false;

  void add(String value) {
    if (widget.randoms.contains(value)) {
      widget.randoms.remove(value);
    } else {
      widget.randoms.add(value);
    }
    widget.onChange(widget.randoms);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      show = controller.text.isNotEmpty;
      setState(() {});
    });
    for (var value in widget.randoms) {
      if (!all.contains(value)) {
        controller.text = value;
        break;
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DialogOption(
      title: '${tr(AppL10n.advanceRandom)}:',
      padding: const EdgeInsets.only(top: 4.0),
      spacing: AppNum.spaceLarge,
      children: [
        ...all.map(
          (e) => EasyCheckbox(
            // sideWidth: 1.5,
            // mainAxisSize: MainAxisSize.min,
            checked: widget.randoms.contains(e),
            onChanged: (value) => add(e),
            child: SelectableText(e),
          ),
        ),
        EasyCheckbox(
          // sideWidth: 1.5,
          // mainAxisSize: MainAxisSize.min,
          checked: show,
          onChanged: show ? (value) {} : null,
          child: SizedBox(
            width: 268,
            child: BaseInput(
              controller: controller,
              hintText: tr(AppL10n.advanceRandomHint),
              show: show,
              onClear: controller.clear,
              onChanged: (value) {
                if (show) add(controller.text);
              },
            ),
          ),
        ),
      ],
    );
  }
}
