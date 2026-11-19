import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/app.dart';
import 'package:once_power/provider/switch.dart';
import 'package:once_power/widget/base/tab_bar.dart';

import 'advanced/advanced.dart';
import 'normal/normal.dart';
import 'organize/organize.dart';

class ActionView extends StatelessWidget {
  const ActionView({super.key});

  @override
  Widget build(BuildContext context) {
    Localizations.localeOf(context);
    return SizedBox(
      width: AppNumber.actionWidth,
      child: DefaultTabController(
        length: FunctionMode.values.length,
        child: Column(
          children: [
            SizedBox(
              height: AppNumber.topHeight,
              child: Consumer(
                builder: (_, ref, _) => EasyTabBar(
                  labels: FunctionMode.values.map((e) => e.label).toList(),
                  onTap: (index) {
                    FunctionMode value = FunctionMode.values[index];
                    ref.read(currentModeProvider.notifier).update(value);
                  },
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ActionNormal(true),
                  ActionNormal(false),
                  AdvancedView(),
                  OrganizeView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
