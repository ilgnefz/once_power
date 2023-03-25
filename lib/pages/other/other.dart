import 'package:flutter/material.dart';
import 'package:once_power/generated/l10n.dart';
import 'package:once_power/pages/other/menu.dart';
import 'package:once_power/pages/other/organize_file.dart';
import 'package:once_power/pages/other/setting.dart';
import 'package:once_power/provider/other.dart';
import 'package:once_power/widgets/my_text.dart';
import 'package:provider/provider.dart';

final List<String> titles = [S.current.organizeFile, S.current.setting];
const List<Widget> menus = [OrganizeFileMenu(), SettingMenu()];

class OtherPage extends StatelessWidget {
  const OtherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<OtherProvider>(context);
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * .8,
        height: MediaQuery.of(context).size.height * .8,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: Stack(
          children: [
            Material(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              child: Row(
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: ListView(
                      children: [
                        Container(
                          height: 40,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          alignment: Alignment.centerLeft,
                          child: MyText(
                            S.of(context).other,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: IndexedStack(
                        index: provider.currentIndex,
                        children: menus,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                margin: const EdgeInsets.all(12),
                child: const CloseButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
