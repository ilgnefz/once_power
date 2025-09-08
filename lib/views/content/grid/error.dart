import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/config/theme.dart';
import 'package:once_power/constants/images.dart';
import 'package:once_power/constants/l10n.dart';

class ErrorImage extends StatelessWidget {
  const ErrorImage({super.key, this.isPreview = false, required this.file});

  final bool isPreview;
  final String file;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        isPreview
            ? Image.asset(AppImages.error, fit: BoxFit.none)
            : Expanded(
                child: Image.asset(AppImages.error, fit: BoxFit.contain),
              ),
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
                ),
              ),
              Text(
                file,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
        ],
        Text(
          '${tr(AppL10n.contentError)} (((;꒪ꈊ꒪;)))',
          style: isPreview
              ? TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontFamily: defaultFont,
                )
              : TextStyle(fontSize: 12, fontFamily: defaultFont),
        ),
      ],
    );
  }
}
