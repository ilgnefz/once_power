import 'package:flutter/material.dart';
import 'package:once_power/widgets/svg_icon.dart';
import 'package:url_launcher/url_launcher.dart';

class RepoUrl extends StatefulWidget {
  const RepoUrl({super.key, required this.icon, required this.url});

  final String icon;
  final String url;

  @override
  State<RepoUrl> createState() => _RepoUrlState();
}

class _RepoUrlState extends State<RepoUrl> {
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: (value) {
        flag = value;
        setState(() {});
      },
      onTap: () async {
        await launchUrl(Uri.parse(widget.url));
      },
      child: SvgIcon(
        widget.icon,
        color: flag ? null : Colors.grey,
      ),
    );
  }
}
