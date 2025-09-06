import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/images.dart';
import 'package:once_power/constants/l10n.dart';

class LoadingImage extends StatelessWidget {
  const LoadingImage({super.key, required this.isPreview});

  final bool isPreview;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: isPreview
              ? UnconstrainedBox(
                  child: Image.asset(AppImages.loading, fit: BoxFit.contain),
                )
              : Image.asset(AppImages.loading, fit: BoxFit.contain),
        ),
        Text(tr(AppL10n.contentLoading), style: const TextStyle(fontSize: 12)),
      ],
    );
  }
}
