import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/utils/format.dart';
import 'package:once_power/widgets/base/easy_tooltip.dart';
import 'package:tolyui_feedback/toly_tooltip/tooltip_placement.dart';

class TooltipItem extends StatelessWidget {
  const TooltipItem({
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
    final String name = tr(AppL10n.contentOrigin); // 原始文件名标签
    final String newName = tr(AppL10n.contentNew); // 新文件名标签
    final String folder = tr(AppL10n.contentFolder); // 文件夹标签
    final String createTime = tr(AppL10n.eDateCreate); // 创建时间标签
    final String modifyDate = tr(AppL10n.eDateModify); // 修改时间标签
    final String captureDate = tr(AppL10n.eDateCapture); // 拍摄日期标签
    final String resolution = tr(AppL10n.contentResolution); // 分辨率标签
    final String size = tr(AppL10n.contentSize); // 文件大小标签
    final String group = tr(AppL10n.contentGroup); // 分组标签

    String dot = file.ext == '' ? '' : '.';
    String newDot = file.newExt == '' ? '' : '.';
    bool hasGroup = file.group != '';

    return EasyTooltip(
      placement: Placement.bottom,
      waitDuration: waitDuration,
      richMessage: TextSpan(
        children: [
          richTextTooltip(context, name, '${file.name}$dot${file.ext}'),
          richTextTooltip(
            context,
            newName,
            '${file.newName}$newDot${file.newExt}',
          ),
          richTextTooltip(context, folder, file.parent),
          richTextTooltip(context, createTime, '${file.createdDate}'),
          richTextTooltip(context, modifyDate, '${file.modifiedDate}'),
          if (file.metaInfo?.capture != null)
            richTextTooltip(context, captureDate, '${file.metaInfo?.capture}'),
          if (file.resolution != null)
            richTextTooltip(
              context,
              resolution,
              formatResolution(file.resolution!),
            ),
          richTextTooltip(context, size, formatFileSize(file.size), !hasGroup),
          if (hasGroup) richTextTooltip(context, group, file.group, hasGroup),
        ],
      ),
      child: child, // 触发提示框的子Widget
    );
  }
}
