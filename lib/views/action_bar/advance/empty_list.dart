import 'dart:io';

import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';

class EmptyList extends StatefulWidget {
  const EmptyList({super.key});

  @override
  State<EmptyList> createState() => _EmptyListState();
}

class _EmptyListState extends State<EmptyList> {
  final textStyle = TextStyle(
    fontFamily: Platform.isWindows ? 'Microsoft YaHei' : null,
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(color: Colors.grey),
      child: Column(
        spacing: 4,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(S.of(context).advanceEmpty1, style: textStyle),
          Text(S.of(context).advanceEmpty2, style: textStyle),
          Text(S.of(context).advanceEmpty3, style: textStyle),
          Text(S.of(context).advanceEmpty4, style: textStyle),
        ],
      ),
    );
  }
}
