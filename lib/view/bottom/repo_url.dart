import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:once_power/widget/base/icon.dart';
import 'package:url_launcher/url_launcher.dart';

class RepoUrl extends StatefulWidget {
  const RepoUrl({super.key, required this.icon, required this.url});

  final String icon;
  final String url;

  @override
  State<RepoUrl> createState() => _RepoUrlState();
}

class _RepoUrlState extends State<RepoUrl> {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onHover: (_) => setState(() => isHover = true),
      onExit: (_) => setState(() => isHover = false),
      child: InkWell(
        mouseCursor: SystemMouseCursors.click,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: () async => await launchUrl(Uri.parse(widget.url)),
        child: SvgPicture.asset(
          widget.icon,
          height: 20,
          width: 20,
          colorFilter: isHover
              ? null
              : ColorFilter.mode(
                  Theme.of(context).iconTheme.color!,
                  BlendMode.srcIn,
                ),
        ),
      ),
    );
  }
}
