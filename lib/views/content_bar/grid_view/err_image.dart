import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';

class ErrorImage extends StatelessWidget {
  const ErrorImage({super.key, this.isPreview = false, required this.file});

  final bool isPreview;
  final String file;

  @override
  Widget build(BuildContext context) {
    String errorLabel = S.of(context).errorImage;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        isPreview
            ? Image.asset(AppImages.error, fit: BoxFit.none)
            : Expanded(
                child: Image.asset(AppImages.error, fit: BoxFit.contain)),
        SizedBox(height: isPreview ? 12 : 4),
        if (isPreview) ...[
          Stack(
            children: <Widget>[
              Text(
                file,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = 6
                    ..color = Colors.white,
                ).useSystemChineseFont(),
              ),
              Text(
                file,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ).useSystemChineseFont(),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
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
