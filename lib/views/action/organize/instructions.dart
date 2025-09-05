import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/config/theme.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';

class Instructions extends StatelessWidget {
  const Instructions({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> labels = [
      tr(AppL10n.organizeDate),
      tr(AppL10n.organizeTop),
      tr(AppL10n.organizeSelected),
      tr(AppL10n.organizeEmpty),
    ];

    List<String> desc = [
      tr(AppL10n.organizeDateDesc),
      tr(AppL10n.organizeTopDesc),
      tr(AppL10n.organizeSelectedDesc),
      tr(AppL10n.organizeEmptyDesc),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: AppNum.paddingMedium,
        horizontal: AppNum.padding,
      ),
      child: SingleChildScrollView(
        child: Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            labels.length,
            (index) => RichText(
              text: TextSpan(
                text: '${labels[index]}: ',
                style: TextStyle(
                  fontSize: 14,
                  color: Theme.of(context).primaryColor,
                  fontFamily: defaultFont,
                ),
                children: [
                  TextSpan(
                    text: desc[index],
                    style: TextStyle(
                      fontSize: 14,
                      color: Color(0xFF666666),
                      height: 1.5,
                      fontFamily: defaultFont,
                    ),
                  ),
                ],
              ),
            ),
          ).toList(),
        ),
      ),
    );
  }
}
