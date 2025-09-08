import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';

class DirectiveEmpty extends StatelessWidget {
  const DirectiveEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final TextStyle? textStyle = Theme.of(
      context,
    ).textTheme.bodyMedium?.copyWith(color: Colors.grey);
    return DefaultTextStyle(
      style: TextStyle(color: Colors.grey),
      child: Column(
        spacing: 4,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(tr(AppL10n.advanceEmpty1), style: textStyle),
          Text(tr(AppL10n.advanceEmpty2), style: textStyle),
          Text(tr(AppL10n.advanceEmpty3), style: textStyle),
          Text(tr(AppL10n.advanceEmpty4), style: textStyle),
        ],
      ),
    );
  }
}
