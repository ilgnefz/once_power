import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:once_power/widgets/base_input.dart';

import 'my_text.dart';

class DigitInput extends StatelessWidget {
  const DigitInput({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseInput(
      padding: EdgeInsets.zero,
      controller: TextEditingController(text: '222开始'),
      show: false,
      textAlign: TextAlign.center,
      inputFormatters: [
        LengthLimitingTextInputFormatter(2),
        FilteringTextInputFormatter.digitsOnly
      ],
      // contentPadding: const EdgeInsets.only(left: 4.0),
      leading: OperatorButton('-', onTap: () {}),
      action: OperatorButton('+', start: false, onTap: () {}),
    );
  }
}

class OperatorButton extends StatelessWidget {
  const OperatorButton(
    this.operator, {
    super.key,
    this.start = true,
    required this.onTap,
  });

  final String operator;
  final bool start;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final radius = start
        ? const BorderRadius.only(
            topLeft: Radius.circular(8.0),
            bottomLeft: Radius.circular(8.0),
          )
        : const BorderRadius.only(
            topRight: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
          );

    return Material(
      child: Ink(
        decoration: BoxDecoration(borderRadius: radius),
        child: InkWell(
          borderRadius: radius,
          onTap: onTap,
          child: Container(
            width: 20,
            // height: 32,
            alignment: Alignment.center,
            child: MyText(operator, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
