import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/config/theme/theme.dart';
import 'package:once_power/const/images.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/model/progress.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/util/format.dart';
import 'package:once_power/util/info.dart';

class ProgressView extends ConsumerWidget {
  const ProgressView({super.key, required this.info});

  final ProgressFileInfo info;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int total = ref.watch(totalProvider);
    int count = ref.watch(countProvider);
    TextStyle style = TextStyle(fontSize: 13, fontFamily: defaultFont);
    TextStyle lStyle = style.copyWith(color: Theme.of(context).primaryColor);
    double totalSize = getTotalSize(ref);
    int currentSize = ref.watch(currentSizeProvider);
    return Center(
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return SizedBox(
            width: constraints.maxWidth * .7,
            child: Column(
              spacing: AppNum.spaceLarge,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.loading),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: currentSize / totalSize,
                    valueColor: AlwaysStoppedAnimation(
                      Theme.of(context).primaryColor,
                    ),
                    backgroundColor: Colors.grey[200],
                    minHeight: 8,
                  ),
                ),
                Row(
                  children: [
                    Text('${tr(AppL10n.bottomTask)}: ', style: style),
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
                    SizedBox(width: AppNum.spaceMedium),
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
