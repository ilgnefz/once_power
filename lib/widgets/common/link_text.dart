import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkText extends StatelessWidget {
  const LinkText({
    super.key,
    required this.text,
    required this.clickText,
    required this.link,
    this.fontSize = 13,
  });

  final String text;
  final String clickText;
  final String link;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: text,
        style: TextStyle(
          color: Theme.of(context).textTheme.labelSmall?.color,
          fontSize: fontSize,
        ),
        children: [
          TextSpan(
            text: clickText,
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontSize: fontSize,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                launchUrl(Uri.parse(link));
              },
          ),
        ],
      ),
    );
  }
}
