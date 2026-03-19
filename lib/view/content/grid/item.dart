import 'package:flutter/material.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/dialog.dart';
import 'package:once_power/enum/file.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/view/content/grid/image.dart';
import 'package:once_power/widget/context/sort_select_item.dart';

import 'avif.dart';
import 'psd.dart';
import 'svg.dart';
import 'video.dart';

class ContentGridItem extends StatelessWidget {
  const ContentGridItem({super.key, required this.index, required this.file});

  final int index;
  final FileInfo file;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SortSelectItem(
      index: index,
      file: file,
      onDoubleTap: () => previewView(context, file),
      child: Column(
        key: key,
        spacing: AppNum.spaceSmall,
        children: [
          Expanded(
            child: Center(
              child: Builder(
                builder: (context) {
                  if (file.type.isVideo) return VideoView(file);
                  if (file.extension == 'avif') return AvifView(file);
                  if (file.extension == 'psd') return PsdView(file);
                  if (file.extension == 'svg') return SvgView(file);
                  return ImageView(file);
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: AppNum.spaceSmall,
              right: AppNum.spaceSmall,
              bottom: AppNum.spaceSmall,
            ),
            child: RichText(
              text: TextSpan(
                text: file.newName,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontSize: 13,
                  color: file.newName == file.name
                      ? Colors.grey
                      : theme.primaryColor,
                ),
                children: [
                  TextSpan(
                    text: file.newExtension.isEmpty
                        ? ''
                        : '.${file.newExtension}',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontSize: 13,
                      color: file.newExtension == file.extension
                          ? Colors.grey
                          : theme.primaryColor,
                    ),
                  ),
                ],
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            // child: BaseText(
            //   newName,
            //   fontSize: 13,
            //   maxLines: 2,
            //   color: newName == file.getFullOldName()
            //       ? Colors.grey
            //       : Theme.of(context).primaryColor,
            //   textAlign: TextAlign.center,
            //   overflow: TextOverflow.ellipsis,
            // ),
          ),
        ],
      ),
    );
  }
}
