import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/const/l10n.dart';
import 'package:once_power/const/num.dart';
import 'package:once_power/core/upload.dart';
import 'package:once_power/provider/setting.dart';
import 'package:once_power/widget/base/text.dart';
import 'package:once_power/widget/common/click_icon.dart';
import 'package:once_power/widget/common/click_text.dart';
import 'package:once_power/widget/common/one_line_text.dart';

import 'setting_checkbox.dart';
import 'setting_view.dart';

class ThemeSetting extends ConsumerWidget {
  const ThemeSetting({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.read(themeSettingProvider.notifier);
    double alpha = ref.watch(themeSettingProvider.select((e) => e.alpha));
    double sigma = ref.watch(themeSettingProvider.select((e) => e.sigma));
    String background = ref.watch(
      themeSettingProvider.select((e) => e.background),
    );
    return Column(
      crossAxisAlignment: .start,
      children: [
        SettingTitle(tr(AppL10n.settingTheme)),
        SettingCheckbox(
          label: tr(AppL10n.settingDivider),
          checked: ref.watch(themeSettingProvider.select((e) => e.divider)),
          onChanged: (value) => provider.updateDivider(value),
        ),
        SettingCheckbox(
          label: tr(AppL10n.settingShadow),
          checked: ref.watch(themeSettingProvider.select((e) => e.shadow)),
          onChanged: (value) => provider.updateShadow(value),
        ),
        SizedBox(height: AppNum.spaceSmall),
        Row(
          children: [
            BaseText(tr(AppL10n.settingMask)),
            Expanded(
              child: Slider(
                value: alpha,
                divisions: 10,
                max: 1,
                onChanged: (value) => provider.updateAlpha(value),
              ),
            ),
            BaseText('${alpha * 100}%'),
          ],
        ),
        SizedBox(height: AppNum.spaceMedium),
        Row(
          children: [
            BaseText(tr(AppL10n.settingSigma)),
            Expanded(
              child: Slider(
                value: sigma,
                divisions: 20,
                max: 60,
                onChanged: (value) => provider.updateSigma(value),
              ),
            ),
            BaseText('$sigma'),
          ],
        ),
        SizedBox(height: AppNum.spaceSmall),
        Row(
          children: [
            if (background == '') BaseText(tr(AppL10n.settingBackground)),
            OneLineText(background, color: Theme.of(context).primaryColor),
            if (background != '')
              ClickIcon(
                icon: Icons.delete_rounded,
                size: 24,
                iconSize: 18,
                onPressed: () {
                  final provider = ref.read(themeSettingProvider.notifier);
                  provider.updateBackground('');
                  provider.updateBackgroundBytes(null);
                },
              ),
            EasyClickText(
              label: tr(AppL10n.settingUpload),
              radius: AppNum.radiusSmall,
              onPressed: () => uploadImage(ref),
            ),
          ],
        ),
      ],
    );
  }
}
