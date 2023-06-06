import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/model/types.dart';
import 'package:once_power/provider/other.dart';
import 'package:once_power/utils/package_info.dart';
import 'package:once_power/widgets/click_text.dart';
import 'package:once_power/widgets/my_text.dart';
import 'package:once_power/widgets/space_box.dart';
import 'package:provider/provider.dart';

Widget settingText(String data, [color]) =>
    MyText(data, fontWeight: FontWeight.w600, color: color);

class SettingMenu extends StatelessWidget {
  const SettingMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OtherProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SpaceBoxHeight(),
            Image.asset('assets/flag.png', height: 80),
            const SpaceBoxHeight(),
            SettingItem(
              title: S.of(context).language,
              action: [
                ...provider.languageList
                    .map(
                      (e) => RadioButton(
                        title: e.value,
                        value: e.value,
                        groupValue: provider.currentLanguage.value,
                        onChange: (v) => provider.toggleLanguage(e),
                      ),
                    )
                    .toList(),
                // SizedBox(width: 12),
                MyText(S.of(context).languageTip, color: Colors.grey),
              ],
            ),
            SettingItem(
              title: S.of(context).about,
              action: [MyText(S.of(context).desc)],
            ),
            SettingItem(
              title: S.of(context).save,
              action: [
                Transform.scale(
                  scale: .8,
                  child: Switch(
                      value: provider.save,
                      onChanged: (v) => provider.toggleSave()),
                )
              ],
            ),
            SettingItem(
              title: S.of(context).projectUrl,
              crossAxisAlignment: CrossAxisAlignment.start,
              action: const [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClickText(
                      title: 'Github',
                      content: 'https://github.com/ilgnefz/once_power',
                      url: 'https://github.com/ilgnefz/once_power',
                    ),
                    ClickText(
                      title: 'Gitee',
                      content: 'https://gitee.com/ilgnefz/once_power',
                      url: 'https://gitee.com/ilgnefz/once_power',
                    ),
                  ],
                ),
              ],
            ),
            SettingItem(
              title: S.of(context).LICENSE,
              action: [settingText('GPL 2.0 LICENSE', Colors.teal)],
            ),
            SettingItem(
              title: S.of(context).currentVersion,
              action: [
                settingText('OnePower v${PackageDesc.getVersion()}'),
                const SpaceBoxWidth(),
                if (provider.detect != null) ...[
                  MyText(provider.detect! == true
                      ? S.current.detecting
                      : PackageDesc.getVersion() == provider.latestVersion
                          ? S.current.currentLatest
                          : S.current.newVersion),
                  const SpaceBoxWidth(),
                ],
                TextButton(
                  onPressed: provider.getVersion,
                  child: MyText(S.current.detectVersions),
                ),
              ],
            ),
            if (provider.latestVersion != '' &&
                PackageDesc.getVersion() != provider.latestVersion) ...[
              SettingItem(
                title: S.of(context).latestVersion,
                action: [
                  settingText('OnePower v${provider.latestVersion}'),
                ],
              ),
              if (provider.versionDescZH != '')
                SettingItem(
                  title: S.of(context).versionDesc,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  action: provider.currentLanguage == LanguageType.chinese
                      ? provider.versionDescZH
                          .split(',')
                          .map((e) => settingText(e))
                          .toList()
                      : provider.versionDescEN
                          .split(',')
                          .map((e) => settingText(e))
                          .toList(),
                ),
              SettingItem(
                title: S.of(context).downloadLink,
                action: [
                  ClickText(
                    title: 'Github',
                    content: '${S.of(context).link} 1',
                    url: 'https://github.com/ilgnefz/once_power/releases',
                  ),
                  const SizedBox(width: 12),
                  ClickText(
                    title: 'Gitee',
                    content: '${S.of(context).link} 2',
                    url: 'https://gitee.com/ilgnefz/once_power/releases',
                  ),
                ],
              ),
            ]
          ],
        ),
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key,
    required this.title,
    required this.action,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  final String title;
  final List<Widget> action;
  final CrossAxisAlignment crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      child: Row(
        crossAxisAlignment: crossAxisAlignment,
        children: [
          MyText('$title:'),
          const SizedBox(width: 12),
          ...action,
        ],
      ),
    );
  }
}

class RadioButton extends StatelessWidget {
  const RadioButton({
    super.key,
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChange,
  });

  final String title;
  final String value;
  final String groupValue;
  final void Function(String?) onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 12),
      child: Row(
        children: [
          Radio(value: value, groupValue: groupValue, onChanged: onChange),
          MyText(title),
        ],
      ),
    );
  }
}
