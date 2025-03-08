import 'package:flutter/material.dart';

class RightMenuItem extends StatelessWidget {
  const RightMenuItem({
    super.key,
    required this.label,
    this.color = Colors.black,
    required this.callback,
  });

  final String label;
  final Color color;
  final VoidCallback callback;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pop();
        callback();
      },
      child: Container(
        height: 32,
        alignment: Alignment.center,
        child: Text(label, style: TextStyle(color: color)),
      ),
    );
  }
}
