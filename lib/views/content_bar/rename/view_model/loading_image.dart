import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/generated/l10n.dart';

class LoadingImage extends StatelessWidget {
  const LoadingImage({super.key, required this.isPreview});

  final bool isPreview;

  @override
  Widget build(BuildContext context) {
    String loadingLabel = S.of(context).loadingImage;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: isPreview
              ? UnconstrainedBox(
                  child: Image.asset(AppImages.loading, fit: BoxFit.contain))
              : Image.asset(AppImages.loading, fit: BoxFit.contain),
        ),
        Text(
          loadingLabel,
          style: const TextStyle(fontSize: 12).useSystemChineseFont(),
        ),
      ],
    );
  }
}
