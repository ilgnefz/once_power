import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/provider/theme.dart';
import 'package:once_power/view/home.dart';

import 'config/app.dart';
import 'config/language.dart';
import 'config/theme/theme.dart';
import 'const/text.dart';
import 'enum/app.dart';

// TODO: 更改 main.cpp 软件名
// TODO: 修改文件样式
// TODO: 更新日志：破坏性更改-之前保存的预设内容会出错，需要重新修改
// TODO: 视图模式选择按钮颜色
// TODO: 下拉栏鼠标样式

void main(List<String> args) async {
  await AppConfig.init(args);
  runApp(
    ProviderScope(
      child: EasyLocalization(
        path: LanguageConfig.path,
        supportedLocales: LanguageConfig.supportedLocales,
        fallbackLocale: LanguageConfig.fallbackLocale,
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: AppText.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeConfig.light,
      darkTheme: ThemeConfig.dark,
      themeMode: ref.watch(currentThemeProvider).mode,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      home: const HomeView(),
    );
  }
}
