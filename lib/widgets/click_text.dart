import 'package:flutter/material.dart';
import 'package:once_power/widgets/my_text.dart';
import 'package:url_launcher/url_launcher.dart';

class ClickText extends StatefulWidget {
  const ClickText(
      {Key? key, required this.title, required this.content, required this.url})
      : super(key: key);
  final String title;
  final String content;
  final String url;

  @override
  State<ClickText> createState() => _ClickTextState();
}

class _ClickTextState extends State<ClickText> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await launchUrl(Uri.parse(widget.url));
      },
      onHover: (value) {
        setState(() {
          _hovering = value;
        });
      },
      child: Row(
        children: [
          MyText('${widget.title}:', fontWeight: FontWeight.w600),
          const SizedBox(width: 4),
          MyText(
            widget.content,
            style: TextStyle(
              color: _hovering ? Colors.blue : Theme.of(context).primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
