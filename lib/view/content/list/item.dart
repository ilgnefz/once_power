import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/app.dart';
import 'package:once_power/model/file.dart';
import 'package:once_power/provider/file.dart';
import 'package:once_power/provider/switch.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/provider/value.dart';
import 'package:once_power/widget/base/advance_text/advance_text.dart';
import 'package:once_power/widget/base/checkbox.dart';
import 'package:once_power/widget/base/icon.dart';

class ContentListItem extends ConsumerWidget {
  const ContentListItem({super.key, required this.file});

  final FileInfo file;

  Color color(ThemeData theme, bool value) =>
      value ? Colors.grey : theme.colorScheme.primary;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isOrganize = ref.watch(
      currentModeProvider.select((m) => m.isOrganize),
    );
    ThemeData theme = Theme.of(context);
    TextStyle textStyle = theme.textTheme.labelLarge!.copyWith(fontSize: 13);
    (int, int) flexValues = ref.watch(splitValuesProvider);

    Widget originalLabel = AdvanceText(file.name, style: textStyle);
    Widget newLabel = isOrganize
        ? AdvanceText(file.folder, style: textStyle)
        : AdvanceText(
            file.newName,
            style: textStyle.copyWith(
              color: color(theme, file.name == file.newName),
            ),
          );

    if (ref.watch(isSwapLabelProvider) && !isOrganize) {
      (originalLabel, newLabel) = (newLabel, originalLabel);
    }

    return SizedBox(
      width: double.infinity,
      height: AppNumber.topHeight,
      child: Row(
        mainAxisSize: .max,
        children: [
          EasyCheckbox(
            checked: file.checked,
            onChanged: (value) => ref
                .read(fileListProvider.notifier)
                .updateChecked(file.id, value!),
          ),
          Expanded(flex: flexValues.$1, child: originalLabel),
          SizedBox(width: AppNumber.spaceMedium),
          Expanded(
            flex: flexValues.$2,
            child: Padding(
              padding: .only(right: AppNumber.spaceMedium),
              child: newLabel,
            ),
          ),
          Container(
            width: AppNumber.topIconWidth,
            padding: .symmetric(horizontal: AppNumber.spaceSmall),
            child: AdvanceText(
              file.newExtension,
              style: TextStyle(
                fontSize: 13,
                height: 1,
                color: color(theme, file.extension == file.newExtension),
              ),
              maxLines: 2,
              textAlign: .center,
            ),
          ),
          ClickIcon(
            onPressed: () => ref.read(fileListProvider.notifier).remove(file),
            icon: Icons.delete_outline_rounded,
          ),
        ],
      ),
    );
  }
}
