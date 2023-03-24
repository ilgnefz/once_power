import 'package:flutter/material.dart';
import 'package:once_power/widgets/my_text.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(
                      children: [
                        MyText('设置', fontSize: 18, fontWeight: FontWeight.bold),
                        // 语言 主题  关于
                        Container(
                          height: 48,
                          margin: EdgeInsets.only(top: 16),
                          alignment: Alignment.centerLeft,
                          child: MyText('主题', fontSize: 14),
                        ),
                        Container(
                          height: 48,
                          margin: EdgeInsets.only(top: 16),
                          alignment: Alignment.centerLeft,
                          child: MyText('关于', fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                  ),
                ),
              ],
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
