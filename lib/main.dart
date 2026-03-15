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
// TODO: 普通重命名上传前后缀文件出现清除按钮
// TODO: 自动分组添加文件名以某某开头和结尾的条件
// TODO: 高级模式替换更改输入框提示词
// TODO: 高级模式添加弹窗关于组的显示问题
// TODO: 更新日志：破坏性更改-之前保存的预设内容会出错，需要重新修改
// TODO: 取消选择后直接修改当前的数值，而不是调用循环 updateName
// TODO: 有数自然排序

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
    // String name = '新建#文本#文档';
    // String r1 = insert(name, '#', '@', 1);
    // print(r1);
    // String r2 = insert(
    //   name.split('').reversed.join(''),
    //   '#',
    //   '@',
    //   1,
    // ).split('').reversed.join('');
    // print(r2);

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
