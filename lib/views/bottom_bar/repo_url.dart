import 'package:flutter/material.dart';
import 'package:once_power/widgets/base/svg_icon.dart';
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

  void onHover(bool value) {
    flag = value;
    setState(() {});
  }

  void onTap() async => await launchUrl(Uri.parse(widget.url));

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onHover: onHover,
      onTap: onTap,
      child: SvgIcon(widget.icon, color: flag ? null : Colors.grey),
    );
  }
}
