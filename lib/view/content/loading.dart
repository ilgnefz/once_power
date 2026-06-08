import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/const/images.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/widget/base/text.dart';

class ReadVideoProgressWidget extends StatefulWidget {
  final ValueNotifier<int> progressNotifier;
  final int total;

  const ReadVideoProgressWidget({
    super.key,
    required this.progressNotifier,
    required this.total,
  });

  @override
  State<ReadVideoProgressWidget> createState() =>
      _ReadVideoProgressWidgetState();
}

class _ReadVideoProgressWidgetState extends State<ReadVideoProgressWidget> {
  @override
  void initState() {
    super.initState();
    // 监听进度变化
    widget.progressNotifier.addListener(_updateProgress);
  }

  @override
  void dispose() {
    widget.progressNotifier.removeListener(_updateProgress);
    super.dispose();
  }

  void _updateProgress() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: Column(
          spacing: AppNum.spaceMedium,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.loading),
            BaseText(tr(AppL10n.contentLoadingInfo)),
            BaseText('${widget.progressNotifier.value}/${widget.total}'),
          ],
        ),
      ),
    );
  }
}
