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
// TODO: 右键菜单添加一个选中相同后缀的功能
// TODO: 普通重命名上传前后缀文件出现清除按钮
// TODO: 修改文件样式
// TODO: 更新日志：破坏性更改-之前保存的预设内容会出错，需要重新修改
// TODO: 自动分组添加自动以文件夹名称分组
// TODO: 自动分组添加文件名以某某开头和结尾的条件
// TODO: 自动过滤添加不包含
// TODO: 删除眼镜图标功能
// TODO: 视图模式选择按钮颜色
// TODO: 过滤按钮英文

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
