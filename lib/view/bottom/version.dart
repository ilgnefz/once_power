import 'package:material_ui/material_ui.dart';
import 'package:once_power/service/package.dart';
import 'package:once_power/widget/base/text.dart';

class VersionButton extends StatelessWidget {
  const VersionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseText(
      'v${PackageService.getVersion()}',
      fontSize: 13,
      color: Theme.of(context).iconTheme.color,
    );
  }
}
