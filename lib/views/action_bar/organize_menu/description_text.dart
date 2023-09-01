import 'package:flutter/material.dart';

class DescriptionText extends StatelessWidget {
  const DescriptionText({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle =
        const TextStyle(color: Color(0xFF333333), fontSize: 15);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('功能使用说明', style: titleStyle),
        SizedBox(height: 8),
        BaseRichText(
          title: '目标文件夹',
          content: '默认为第一个添加的文件的父文件夹或文件夹本身',
        ),
        SizedBox(height: 4),
        BaseRichText(
          title: '日志',
          content: '保存的日志会在目标文件夹内',
        ),
        SizedBox(height: 4),
        BaseRichText(
          title: '删除空文件夹',
          content: '删除添加的文件夹下的所有空文件夹',
        ),
        SizedBox(height: 4),
        BaseRichText(
          title: '整理文件夹',
          content: '将添加的所有文件或文件夹下的所有子文件移动到目标文件夹内',
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
    TextStyle mainStyle = TextStyle(
      color: Theme.of(context).primaryColor,
      letterSpacing: 1.2,
    );
    TextStyle baseStyle = const TextStyle(
      color: Color(0xFF666666),
      height: 1.5,
      letterSpacing: 1.2,
    );

    return RichText(
      text: TextSpan(
        text: '$title：',
        style: mainStyle,
        children: [TextSpan(text: content, style: baseStyle)],
      ),
    );
  }
}
