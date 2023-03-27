import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/pages/other/menu.dart';
import 'package:once_power/pages/other/organize_file.dart';
import 'package:once_power/pages/other/setting.dart';
import 'package:once_power/provider/other.dart';
import 'package:once_power/widgets/my_text.dart';
import 'package:provider/provider.dart';

const List<Widget> menus = [OrganizeFileMenu(), SettingMenu()];

class OtherPage extends StatelessWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OtherProvider>(context);
    final List<String> titles = [
      S.of(context).organizeFile,
      S.of(context).setting
    ];
    return Scaffold(
      body: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            constraints: const BoxConstraints(maxWidth: 240),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        alignment: Alignment.centerLeft,
                        child: MyText(
                          S.of(context).other,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // 语言 主题  关于
                      ...List.generate(
                        titles.length,
                        (index) => OtherMenu(
                          title: titles[index],
                          provider: provider,
                          selected: provider.currentIndex == index,
                          onTap: () => provider.toggleIndex(index),
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () => provider.back(context),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: IndexedStack(
                index: provider.currentIndex,
                children: menus,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
