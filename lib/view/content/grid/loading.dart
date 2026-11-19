import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/image.dart';
import 'package:once_power/constant/l10n.dart';

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
              ? UnconstrainedBox(child: Image.asset(AppImages.loading))
              : Image.asset(AppImages.loading, fit: BoxFit.contain),
        ),
        Text(
          tr(AppL10n.loading),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12),
        ),
      ],
    );
  }
}
