import 'package:easy_localization/easy_localization.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/widget/base/text.dart';

class ProgressButton extends StatelessWidget {
  const ProgressButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseText(
      '${context.tr(AppL10n.task)}: 0/0  ${context.tr(AppL10n.time)}: 0.00s',
      fontSize: 13,
      color: Theme.of(context).iconTheme.color,
    );
  }
}
