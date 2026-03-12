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
// TODO: 删除自定义 EasyTooltip 代码
// TODO: 处理文件夹重命名后，如果子文件在列表里，重命名会失败的问题
// TODO: 视图模式和日期修改冲突
// TODO: 预览时修改了位置，应该更新当前 index
// TODO: 添加一个获取文件夹的子文件夹时是否需要添加当前文件夹的选项
// TODO: 右键菜单添加一个选中相同后缀的功能
// TODO: 上传文件出现清除按钮

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
