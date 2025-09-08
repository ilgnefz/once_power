import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/constants/l10n.dart';
import 'package:once_power/cores/upload.dart';
import 'package:once_power/provider/theme.dart';
import 'package:once_power/widgets/base/easy_btn.dart';
import 'package:once_power/widgets/base/easy_checkbox.dart';
import 'package:once_power/widgets/common/dialog.dart';

class ThemeView extends ConsumerWidget {
  const ThemeView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final TextStyle? textStyle = Theme.of(context).textTheme.bodyMedium;
    final double opacity = ref.watch(backgroundOpacityProvider);
    return CommonDialog(
      title: tr(AppL10n.bottomTheme),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              EasyCheckbox(
                label: tr(AppL10n.bottomInput),
                checked: ref.watch(translucentInputProvider),
                onChanged: (value) {
                  ref.read(translucentInputProvider.notifier).update(value!);
                },
              ),
              EasyCheckbox(
                label: tr(AppL10n.bottomBtn),
                checked: ref.watch(translucentBtnProvider),
                onChanged: (value) {
                  ref.read(translucentBtnProvider.notifier).update(value!);
                },
              ),
              EasyCheckbox(
                label: tr(AppL10n.bottomDivider),
                checked: ref.watch(transparentDividerProvider),
                onChanged: (value) {
                  ref.read(transparentDividerProvider.notifier).update(value!);
                },
              ),
            ],
          ),
          Row(
            children: [
              Text(tr(AppL10n.bottomMask), style: textStyle),
              Expanded(
                child: Slider(
                  value: opacity * 100,
                  divisions: 10,
                  max: 100,
                  onChanged: (value) => ref
                      .read(backgroundOpacityProvider.notifier)
                      .update(value / 100),
                ),
              ),
              Text('$opacity%', style: textStyle),
            ],
          ),
          EasyBtn(
            label: tr(AppL10n.bottomBackground),
            onPressed: () => uploadImage(ref),
          ),
        ],
      ),
      onCancel: () {
        ref.read(translucentInputProvider.notifier).update(false);
        ref.read(translucentBtnProvider.notifier).update(false);
        ref.read(transparentDividerProvider.notifier).update(false);
        ref.read(backgroundOpacityProvider.notifier).update(.8);
        ref.read(backgroundImageProvider.notifier).reset();
      },
    );
  }
}
