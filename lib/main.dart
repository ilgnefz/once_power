import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/config.dart';
import 'constants/constants.dart';
import 'providers/toggle.dart';
import 'views/home.dart';

// TODO: 添加多线程
// TODO: 设置列表显示方式像PowerRename一样
// TODO: 高级模式添加功能添加扩展
// TODO: 文件很多尺寸很大时切换菜单卡顿
// TODO: 右键打开文件位置时如果文件不存在就提示
// TODO: 路径过滤可以直接打开文件夹目录
// TODO: 使用multi_split_view切换

void main(List<String> args) async {
  await AppConfig.init(args);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BorderRadiusFrames(
      child: MaterialApp(
        title: AppText.name,
        debugShowCheckedModeBanner: false,
        theme: ThemeConfig.light,
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        localizationsDelegates: LanguageConfig.localizationsDelegates,
        supportedLocales: LanguageConfig.supportedLocales,
        localeResolutionCallback: (locale, supportedLocales) {
          return LanguageConfig.localeResolutionCallback(
            context,
            locale!,
            supportedLocales,
          );
        },
        home: const HomeView(),
      ),
    );
  }
}

class BorderRadiusFrames extends ConsumerWidget {
  const BorderRadiusFrames({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isMax = ref.watch(isMaxProvider);

    BoxDecoration decoration = const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      boxShadow: [BoxShadow(color: Color(0x33000000), blurRadius: 8)],
    );

    return Container(
      margin: isMax ? EdgeInsets.zero : const EdgeInsets.all(8),
      clipBehavior: isMax ? Clip.none : Clip.antiAliasWithSaveLayer,
      decoration: isMax ? null : decoration,
      child: child,
    );
  }
}
