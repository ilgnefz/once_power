import 'package:flutter/material.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/generated/l10n.dart';

class InstructionsText extends StatelessWidget {
  const InstructionsText({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> labels = [
      // S.of(context).useRule,
      S.of(context).dateClassification,
      S.of(context).topParentFolder,
      S.of(context).deleteEmptyFolder,
    ];

    List<String> desc = [
      // S.of(context).useRuleDesc,
      S.of(context).dateClassificationDesc,
      S.of(context).topParentFolderDesc,
      S.of(context).deleteEmptyFolderDesc,
    ];

    return Padding(
      padding: EdgeInsets.only(
        top: AppNum.smallG,
        left: AppNum.defaultP,
        right: AppNum.defaultP,
      ),
      child: Column(
        spacing: AppNum.smallG,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(
          labels.length,
          (index) => RichText(
            text: TextSpan(
              text: '${labels[index]}: ',
              style: TextStyle(color: Theme.of(context).primaryColor),
              children: [
                TextSpan(
                  text: desc[index],
                  style: TextStyle(color: Color(0xFF666666), height: 1.5),
                )
              ],
            ),
          ),
        ).toList(),
      ),
    );
  }
}
