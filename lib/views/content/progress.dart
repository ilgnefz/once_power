import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/images.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/constants/num.dart';
import 'package:once_power/models/progress.dart';
import 'package:once_power/provider/progress.dart';
import 'package:once_power/utils/format.dart';
import 'package:once_power/utils/info.dart';

class ProgressView extends ConsumerWidget {
  const ProgressView({super.key, required this.info});

  final ProgressFileInfo info;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int total = ref.watch(totalProvider);
    int count = ref.watch(countProvider);
    TextStyle style = TextStyle(fontSize: 13);
    TextStyle lStyle = style.copyWith(color: Theme.of(context).primaryColor);
    int totalSize = getAllSize(ref);
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
                    // value: info.transferred / info.size,
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
