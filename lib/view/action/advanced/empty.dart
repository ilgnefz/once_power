import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/widget/base/text.dart';

class DirectiveEmpty extends StatelessWidget {
  const DirectiveEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BaseText(
        context.tr(AppL10n.presetEmpty),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(height: 1.5),
        maxLines: null,
        textAlign: .center,
      ),
    );
  }
}
