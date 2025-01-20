import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';

class EmptyList extends StatefulWidget {
  const EmptyList({super.key});

  @override
  State<EmptyList> createState() => _EmptyListState();
}

class _EmptyListState extends State<EmptyList> {
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(color: Colors.grey),
      child: Column(
        spacing: 4,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(S.of(context).advanceEmpty1),
          Text(S.of(context).advanceEmpty2),
          Text(S.of(context).advanceEmpty3),
          Text(S.of(context).advanceEmpty4),
        ],
      ),
    );
  }
}
