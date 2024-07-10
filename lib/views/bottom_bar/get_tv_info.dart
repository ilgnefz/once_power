import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/widgets/click_icon.dart';
import 'package:once_power/widgets/custom_tooltip.dart';
import 'package:tolyui_feedback/tolyui_feedback.dart';

class GetTvInfo extends StatelessWidget {
  const GetTvInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final String tvSeriesInfo = S.of(context).tvSeriesInfo;

    void getInfo() {}

    return CustomTooltip(
      message: tvSeriesInfo,
      textStyle: const TextStyle(fontSize: 13, color: Color(0xFF666666))
          .useSystemChineseFont(),
      placement: Placement.top,
      child: ClickIcon(
        size: 24,
        svg: AppIcons.tv,
        color: Colors.grey,
        onTap: getInfo,
      ),
    );
    ;
  }
}
