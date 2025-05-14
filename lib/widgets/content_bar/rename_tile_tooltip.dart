import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/file_info.dart';
import 'package:once_power/utils/utils.dart';
import 'package:once_power/widgets/base/easy_tooltip.dart';
import 'package:tolyui_feedback/toly_tooltip/tooltip_placement.dart';

class RenameTileTooltip extends StatelessWidget {
  const RenameTileTooltip({
    super.key,
    required this.file,
    this.waitDuration,
    required this.child,
  });

  final FileInfo file;
  final Duration? waitDuration;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final String name = S.of(context).originalName;
    final String newName = S.of(context).newName;
    final String folder = S.of(context).folder;
    final String createTime = S.of(context).createdTime;
    final String modifyDate = S.of(context).modifiedTime;
    final String exifDate = S.of(context).exifDate;
    final String resolution = S.of(context).resolution;
    final String size = S.of(context).size;
    final String group = S.of(context).group;

    String dot = file.extension == '' ? '' : '.';
    String newDot = file.newExtension == '' ? '' : '.';

    return EasyTooltip(
      placement: Placement.bottom,
      waitDuration: waitDuration,
      richMessage: TextSpan(
        children: [
          richTextTooltip(context, name, '${file.name}$dot${file.extension}'),
          richTextTooltip(
            context,
            newName,
            '${file.newName}$newDot${file.newExtension}',
          ),
          richTextTooltip(context, folder, file.parent),
          richTextTooltip(context, createTime, '${file.createdDate}'),
          richTextTooltip(context, modifyDate, '${file.modifiedDate}'),
          if (file.exifDate != null)
            richTextTooltip(context, exifDate, '${file.exifDate}'),
          if (file.resolution != null)
            richTextTooltip(
                context, resolution, formatResolution(file.resolution!)),
          if (file.group != '') richTextTooltip(context, group, file.group),
          richTextTooltip(context, size, formatFileSize(file.size), true),
        ],
      ),
      child: child,
    );
  }
}
