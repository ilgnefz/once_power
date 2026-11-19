import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/l10n.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/view/content/top/sort.dart';
import 'package:once_power/widget/base/text.dart';

class ViewTop extends StatelessWidget {
  const ViewTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Consumer(
          builder: (context, ref, _) {
            int total = ref.watch(fileListProvider).length;
            int count = total;
            return OneLineText('${context.tr(AppL10n.files)} ($count/$total)');
          },
        ),
        const TopSort(),
      ],
    );
  }
}
