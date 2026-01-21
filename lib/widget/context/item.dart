import 'package:flutter/material.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/widget/common/checkbox.dart';
import 'package:once_power/widget/common/click_icon.dart';
import 'package:once_power/widget/common/one_line_text.dart';

class ContentItem extends StatelessWidget {
  const ContentItem({
    super.key,
    required this.checked,
    required this.onChanged,
    this.margin,
    this.fontSize,
    required this.title,
    this.titleAction,
    required this.subTitle,
    this.subTitleAction,
    required this.action,
    required this.icon,
    required this.onDelete,
    this.onTap,
  });

  final bool checked;
  final void Function(bool?)? onChanged;
  final EdgeInsetsGeometry? margin;
  final double? fontSize;
  final String title;
  final Widget? titleAction;
  final String subTitle;
  final Widget? subTitleAction;
  final Widget action;
  final IconData icon;
  final void Function() onDelete;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    Widget titleText = OneLineText(title, fontSize: fontSize);
    Widget titleWidget = titleAction == null
        ? titleText
        : Flexible(flex: 1, child: Row(children: [titleText, titleAction!]));
    Widget subTitleText = OneLineText(subTitle, fontSize: fontSize);
    Widget subTitleWidget = subTitleAction == null
        ? subTitleText
        : Flexible(
            flex: 1,
            child: Row(children: [subTitleText, subTitleAction!]),
          );

    return InkWell(
      borderRadius: BorderRadius.circular(AppNum.radius),
      onTap: onTap,
      child: Container(
        height: AppNum.topHeight,
        padding: EdgeInsets.symmetric(horizontal: AppNum.spaceSmall),
        // margin: EdgeInsets.only(right: AppNum.paddingMedium),
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
            subTitleWidget,
            Container(width: 40, alignment: Alignment.center, child: action),
            ClickIcon(onPressed: onDelete, icon: icon),
          ],
        ),
      ),
    );
  }
}
