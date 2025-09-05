import 'package:flutter/material.dart';
import 'package:once_power/cores/dialog.dart';
import 'package:once_power/enums/file.dart';
import 'package:once_power/models/file.dart';
import 'package:once_power/utils/info.dart';
import 'package:once_power/views/content/grid/avif.dart';
import 'package:once_power/views/content/grid/image.dart';
import 'package:once_power/views/content/grid/psd.dart';
import 'package:once_power/views/content/grid/svg.dart';
import 'package:once_power/views/content/grid/video.dart';
import 'package:once_power/widgets/content/select_sort_item.dart';

class ContentGridItem extends StatelessWidget {
  const ContentGridItem({super.key, required this.index, required this.file});

  final int index;
  final FileInfo file;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    String newName = getFullName(file.newName, file.newExt);
    String oldName = getFullName(file.name, file.ext);
    return SelectSortItem(
      index: index,
      file: file,
      onDoubleTap: () => previewView(context, file),
      child: Padding(
        padding: const EdgeInsets.only(left: 4, right: 4, top: 0, bottom: 4),
        child: Column(
          spacing: 4,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Builder(
                  builder: (context) {
                    if (file.type.isVideo) return VideoView(file: file);
                    if (file.ext == 'avif') return AvifView(file: file);
                    if (file.ext == 'psd') return PsdView(file: file);
                    if (file.ext == 'svg') return SvgView(file: file);
                    return ImageView(file: file);
                  },
                ),
              ),
            ),
            Text(
              newName,
              style: TextStyle(
                fontSize: 13,
                color: file.checked
                    ? newName == oldName
                          ? theme.textTheme.labelMedium?.color
                          : theme.primaryColor
                    : Colors.grey,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
