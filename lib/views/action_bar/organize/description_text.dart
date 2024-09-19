import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';

class DescriptionText extends StatelessWidget {
  const DescriptionText({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle =
        const TextStyle(color: Color(0xFF333333), fontSize: 15);

    const double gap = AppNum.smallG;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).useDesc, style: titleStyle),
        const SizedBox(height: gap),
        BaseRichText(
          title: S.of(context).targetFolder,
          content: S.of(context).targetFolderDesc,
        ),
        const SizedBox(height: gap),
        BaseRichText(
          title: S.of(context).classifiedFile,
          content: S.of(context).classifiedFileDesc,
        ),
        const SizedBox(height: gap),
        BaseRichText(
          title: S.of(context).deleteEmptyFolder,
          content: S.of(context).deleteEmptyFolderDesc,
        ),
        const SizedBox(height: gap),
        BaseRichText(
          title: S.of(context).organizeMenu,
          content: S.of(context).organizeFolderDesc,
        ),
        const SizedBox(height: gap),
        BaseRichText(
          title: S.of(context).openFolder,
          content: S.of(context).openFolderDesc,
        ),
        const SizedBox(height: gap),
        BaseRichText(
          title: S.of(context).log,
          content: S.of(context).logDesc,
        ),
      ],
    );
  }
}

class BaseRichText extends StatelessWidget {
  const BaseRichText({super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    TextStyle mainStyle = TextStyle(color: Theme.of(context).primaryColor);
    const baseStyle = TextStyle(color: Color(0xFF666666), height: 1.5);

    return RichText(
      text: TextSpan(
        text: '$title：',
        style: mainStyle,
        children: [TextSpan(text: content, style: baseStyle)],
      ),
    );
  }
}
