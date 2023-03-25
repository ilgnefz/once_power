import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/provider/other.dart';
import 'package:once_power/widgets/my_text.dart';
import 'package:provider/provider.dart';

class SettingMenu extends StatelessWidget {
  const SettingMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OtherProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: Column(
        children: [
          SettingItem(
            title: S.of(context).language,
            action: provider.languageList
                .map(
                  (e) => RadioButton(
                    title: e.value,
                    value: e.value,
                    groupValue: provider.currentLanguage.value,
                    onChange: (v) => provider.toggleLanguage(e),
                  ),
                )
                .toList(),
          ),
          SettingItem(
            title: S.of(context).about,
            action: [],
          ),
        ],
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  const SettingItem({
    super.key,
    required this.title,
    required this.action,
  });

  final String title;
  final List<Widget> action;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Row(
        children: [
          MyText('$title:', fontSize: 14),
          SizedBox(width: 12),
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
          MyText(title, fontSize: 14),
        ],
      ),
    );
  }
}
