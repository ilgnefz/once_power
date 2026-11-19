import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/view/content/grid/image.dart';
import 'package:once_power/widget/base/advance_text/advance_text.dart';

class ContentGridItem extends ConsumerWidget {
  const ContentGridItem({super.key, required this.file});

  final FileInfo file;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ThemeData theme = Theme.of(context);
    TextStyle textStyle = theme.textTheme.labelLarge!.copyWith(fontSize: 13);
    return Hero(
      tag: file.id,
      createRectTween: (Rect? begin, Rect? end) =>
          RectTween(begin: begin, end: end),
      child: Column(
        mainAxisSize: .max,
        children: [
          Expanded(
            child: Center(
              child: Builder(
                builder: (BuildContext context) {
                  return ImageView(file);
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: AppNumber.spaceSmall,
              right: AppNumber.spaceSmall,
              bottom: AppNumber.spaceSmall,
            ),
            child: AdvanceText.rich(
              TextSpan(
                children: <InlineSpan>[
                  TextSpan(
                    text: file.newName,
                    style: textStyle.copyWith(
                      color: file.name == file.newName
                          ? Colors.grey
                          : theme.colorScheme.primary,
                    ),
                  ),
                  TextSpan(
                    text: '.${file.newExtension}',
                    style: textStyle.copyWith(
                      color: file.extension == file.newExtension
                          ? Colors.grey
                          : theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }
}
