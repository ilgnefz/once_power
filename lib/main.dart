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

// TODO: 自动为存在的文件添加后缀_01
// TODO: 修改日期，linux不支持1601-01-01T00:00:00Z
// TODO: 测试以.开头的文件，和ww.com.cn为明的文件夹
// TODO: 其他排序也按名称排的开关
// TODO: 有 GPS 信息的图片获取地址
// TODO: 移动文件使用rust
// 最简单且最常用 — 在 FFI 边界传递时间戳（i64）或 NaiveDateTime
// 在 Rust 端将 DateTime<Local> 转为 Unix 时间戳（seconds / millis），把 i64 传给 Flutter；在需要时再从时间戳恢复到 DateTime<Local>。这不依赖 chrono 的时区实现，兼容性最好。
// 示例（Rust）：
// 转为秒：let ts = dt.timestamp();
// 从秒恢复：let dt = DateTime::<Utc>::from_utc(NaiveDateTime::from_timestamp(ts, 0), Utc).with_timezone(&Local);
// 使用 DateTime<Utc> 替代 DateTime<Local>（让 codegen 更容易支持
// 改用 DateTime<Utc> 在序列化/跨语言边界时更稳妥；在需要本地时区显示时再转换为 Local。通常只要在接口层统一使用 UTC，就能避免 codegen 对 Local 时区的依赖问题。

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
