import 'package:flutter/material.dart';

class ApplyButton extends StatelessWidget {
  const ApplyButton({super.key});

  @override
  Widget build(BuildContext context) {
    const String applyChange = '应用更改';

    return ElevatedButton(
      onPressed: () {},
      child: const Text(applyChange),
      // style: ButtonStyle(elevation: MaterialStateProperty.all(0)),
    );
  }
}
