import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/widgets/base/base_input.dart';
import 'package:once_power/widgets/common/easy_checkbox.dart';

class RandomCheckbox extends StatefulWidget {
  const RandomCheckbox(
      {super.key, required this.randoms, required this.onChange});

  final List<String> randoms;
  final void Function(List<String>) onChange;

  @override
  State<RandomCheckbox> createState() => _RandomCheckboxState();
}

class _RandomCheckboxState extends State<RandomCheckbox> {
  TextEditingController controller = TextEditingController();

  final List<String> all = [
    '1234567890',
    r'!@#\$%^&*()_+',
    'abcdefghijklmnopqrstuvwxyz',
    'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  ];

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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text('${S.of(context).random}:'),
        ),
        Expanded(
          child: Wrap(
            spacing: AppNum.largeG,
            children: [
              ...all.map((e) => EasyCheckbox(
                    sideWidth: 1.5,
                    mainAxisSize: MainAxisSize.min,
                    checked: widget.randoms.contains(e),
                    onChanged: (value) => add(e),
                    child: SelectableText(e),
                  )),
              EasyCheckbox(
                sideWidth: 1.5,
                mainAxisSize: MainAxisSize.min,
                checked: show,
                onChanged: show ? (value) {} : null,
                child: Expanded(
                  child: BaseInput(
                    controller: controller,
                    hintText: S.of(context).randomInputHint,
                    showClear: show,
                    onClear: controller.clear,
                    onChanged: (value) {
                      if (show) add(controller.text);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
