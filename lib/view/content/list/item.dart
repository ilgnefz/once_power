import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widget/base/text.dart';
import 'package:once_power/widget/common/checkbox.dart';
import 'package:once_power/widget/common/click_icon.dart';

class ContentItem extends StatelessWidget {
  const ContentItem({
    super.key,
    required this.checked,
    required this.onChanged,
    this.margin,
    required this.title,
    this.titleFontSize,
    this.titleAction,
    required this.subTitle,
    this.subFontSize,
    this.subTitleAction,
    this.showSubTitle = true,
    this.subColor,
    required this.action,
    required this.icon,
    required this.onDelete,
  });

  final bool checked;
  final void Function(bool?)? onChanged;
  final EdgeInsetsGeometry? margin;
  final String title;
  final double? titleFontSize;
  final List<Widget>? titleAction;
  final String subTitle;
  final double? subFontSize;
  final List<Widget>? subTitleAction;
  final bool showSubTitle;
  final Color? subColor;
  final Widget action;
  final IconData icon;
  final void Function() onDelete;

  @override
  Widget build(BuildContext context) {
    Widget titleText = BaseText(title, fontSize: titleFontSize ?? 13);
    Widget titleWidget = Flexible(
      flex: 1,
      fit: .tight,
      child: titleAction == null
          ? titleText
          : Row(
              children: [
                Expanded(child: titleText),
                ...titleAction!,
              ],
            ),
    );
    Widget subTitleText = BaseText(
      subTitle,
      color: subColor,
      fontSize: subFontSize ?? 13,
    );
    Widget subTitleWidget = Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return Flexible(
          flex: ref.watch(expandNewNameProvider) ? 2 : 1,
          fit: .tight,
          child: child!,
        );
      },
      child: subTitleAction == null
          ? subTitleText
          : Row(
              children: [
                Expanded(child: subTitleText),
                ...subTitleAction!,
              ],
            ),
    );

    return Container(
      height: AppNum.topHeight,
      padding: EdgeInsets.symmetric(horizontal: AppNum.spaceSmall),
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppNum.radius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          EasyCheckbox(checked: checked, onChanged: onChanged),
          titleWidget,
          SizedBox(width: AppNum.spaceSmall),
          if (showSubTitle) subTitleWidget,
          Container(width: 40, alignment: Alignment.center, child: action),
          ClickIcon(onPressed: onDelete, icon: icon),
        ],
      ),
    );
  }
}
