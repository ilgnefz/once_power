import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/src/rust/api/models.dart';
import 'package:once_power/util/format.dart';
import 'package:once_power/widget/common/tooltip.dart';
import 'package:tolyui_feedback/toly_tooltip/tooltip_placement.dart';

class TooltipItem extends StatelessWidget {
  const TooltipItem({
    super.key,
    required this.waitDuration,
    required this.file,
    required this.child,
  });

  final Duration? waitDuration;
  final FileInfo file;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final String name = tr(AppL10n.contentOrigin); // 原始文件名标签
    final String newName = tr(AppL10n.contentNew); // 新文件名标签
    final String folder = tr(AppL10n.contentFolder); // 文件夹标签
    final String createTime = tr(AppL10n.eDateCreate); // 创建时间标签
    final String modifyDate = tr(AppL10n.eDateModify); // 修改时间标签
    final String accessDate = tr(AppL10n.eDateAccess); // 访问时间标签
    final String captureDate = tr(AppL10n.eDateCapture); // 拍摄日期标签
    final String resolution = tr(AppL10n.contentResolution); // 分辨率标签
    final String size = tr(AppL10n.contentSize); // 文件大小标签
    final String group = tr(AppL10n.contentGroup); // 分组标签

    bool hasGroup = file.group != '';

    return EasyTooltip(
      placement: Placement.bottom,
      waitDuration: waitDuration,
      // constraints: BoxConstraints(
      //   maxWidth: MediaQuery.of(context).size.width * .4,
      // ),
      // decoration: BoxDecoration(
      //   color: Colors.white,
      //   borderRadius: const BorderRadius.all(Radius.circular(4)),
      //   boxShadow: [
      //     BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(.2)),
      //   ],
      // ),
      richMessage: TextSpan(
        children: [
          richTextTooltip(context, name, file.fullOldName()),
          richTextTooltip(context, newName, file.fullNewName()),
          richTextTooltip(context, folder, file.parent),
          if (file.created != null)
            richTextTooltip(context, createTime, file.created!.date.toString()),
          if (file.modified != null)
            richTextTooltip(
              context,
              modifyDate,
              file.modified!.date.toString(),
            ),
          if (file.accessed != null)
            richTextTooltip(
              context,
              accessDate,
              file.accessed!.date.toString(),
            ),
          if (file.metaInfo?.capture != null)
            richTextTooltip(
              context,
              captureDate,
              '${file.metaInfo?.capture?.date}',
            ),
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
      child: child,
    );
  }
}
