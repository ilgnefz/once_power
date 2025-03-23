import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/models/progress.dart';
import 'package:once_power/providers/progress.dart';
import 'package:once_power/utils/format.dart';
import 'package:once_power/utils/info.dart';

class ProgressView extends ConsumerWidget {
  const ProgressView({super.key, required this.info});

  final ProgressFileInfo info;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int total = ref.watch(totalProvider);
    int count = ref.watch(countProvider);
    TextStyle style = TextStyle(fontSize: 13).useSystemChineseFont();
    TextStyle lStyle = style.copyWith(color: Theme.of(context).primaryColor);
    int totalSize = getAllSize(ref);
    int currentSize = ref.watch(currentSizeProvider);
    return Center(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SizedBox(
            width: constraints.maxWidth * .7,
            child: Column(
              spacing: AppNum.largeG,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.loading),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: currentSize / totalSize,
                    // value: info.transferred / info.size,
                    valueColor:
                        AlwaysStoppedAnimation(Theme.of(context).primaryColor),
                    backgroundColor: Colors.grey[200],
                    minHeight: 8,
                  ),
                ),
                Row(
                  children: [
                    Text('${S.of(context).currentTask}: ', style: style),
                    Expanded(
                      child: Row(
                        children: [
                          Flexible(
                            child: Text(
                              info.name,
                              style: lStyle,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            ' [${formatFileSize(info.transferred)}/${formatFileSize(info.size)}]',
                            style: lStyle,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: AppNum.mediumG),
                    Text('$count/$total', style: style),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
