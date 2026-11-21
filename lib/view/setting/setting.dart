import 'package:flutter_side_anchor_nav/flutter_side_anchor_nav.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/enmu/app.dart';
import 'package:once_power/widget/base/dialog.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final SideTabController _controller = SideTabController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return EasyDialog(
      width: MediaQuery.of(context).size.width * .6,
      child: SideAnchorNav(
        controller: _controller,
        views: SettingType.values
            .map((e) => SideTabView(label: e.label, child: e.view))
            .toList(),
        style: SideTabStyle(
          labelStyle: theme.textTheme.bodyMedium,
          tabMouseCursor: SystemMouseCursors.click,
          tabBarWidth: AppNumber.settingTab,
          tabHeight: AppNumber.topHeight,
          tabRadius: AppNumber.radius,
          tabBarBackground: theme.scaffoldBackgroundColor,
          tabBarDivider: BorderSide.none,
          tabGap: 0.0,
          tabBarPadding: .all(AppNumber.padding),
          contentPadding: .only(
            left: AppNumber.padding,
            right: AppNumber.padding + AppNumber.paddingMedium,
          ),
        ),
      ),
    );
  }
}
