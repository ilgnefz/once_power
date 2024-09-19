import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';

class ErrorImage extends StatelessWidget {
  const ErrorImage({super.key, this.isPreview = false});

  final bool isPreview;

  @override
  Widget build(BuildContext context) {
    String errorLabel = S.of(context).errorImage;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(AppImages.error, fit: BoxFit.contain),
        SizedBox(height: isPreview ? 12 : 4),
        Text(
          '$errorLabel(((;꒪ꈊ꒪;)))',
          style: isPreview
              ? const TextStyle(fontSize: 14, color: Colors.white)
                  .useSystemChineseFont()
              : const TextStyle(fontSize: 12).useSystemChineseFont(),
        ),
      ],
    );
  }
}
