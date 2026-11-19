import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/config/theme/theme.dart';
import 'package:once_power/constant/image.dart';
import 'package:once_power/constant/l10n.dart';

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
            : Expanded(child: Image.asset(AppImages.error)),
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
          '${tr(AppL10n.error)} (((;꒪ꈊ꒪;)))',
          style: isPreview
              ? TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                  fontFamily: ThemeConfig.font,
                )
              : TextStyle(fontSize: 12, fontFamily: ThemeConfig.font),
        ),
      ],
    );
  }
}
