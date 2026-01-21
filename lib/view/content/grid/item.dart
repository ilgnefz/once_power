import 'package:flutter/material.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/util/info.dart';
import 'package:once_power/view/content/grid/image.dart';
import 'package:once_power/widget/base/text.dart';

class ContentGridItem extends StatelessWidget {
  const ContentGridItem({super.key, required this.index, required this.file});

  final int index;
  final FileInfo file;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    String newName = getFullName(file.newName, file.ext);
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(AppNum.radius),
      child: Column(
        key: key,
        spacing: AppNum.spaceSmall,
        children: [
          Expanded(child: ImageView(file)),
          Padding(
            padding: EdgeInsets.only(
              left: AppNum.spaceSmall,
              right: AppNum.spaceSmall,
              bottom: AppNum.spaceSmall,
            ),
            child: BaseText(
              newName,
              fontSize: 13,
              maxLines: 2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
