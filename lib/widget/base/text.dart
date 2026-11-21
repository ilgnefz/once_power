import 'package:material_ui/material_ui.dart';

class const BaseText(
  final String data, {
  super.key,
  final double? fontSize,
  final Color? color,
  final TextStyle? style,
  final FontWeight? fontWeight,
  final int maxLines = 1,
  final TextOverflow overflow = TextOverflow.ellipsis,
  final TextAlign? textAlign,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style:
          style ??
          Theme.of(context).textTheme.bodyMedium?.copyWith(
            fontSize: fontSize,
            color: color,
            fontWeight: fontWeight,
          ),
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
    );
  }
}

class OneLineText extends StatelessWidget {
  const OneLineText(this.data, {super.key, this.color, this.fontSize});

  final String data;
  final Color? color;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: BaseText(
        data,
        color: color,
        fontSize: fontSize,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
