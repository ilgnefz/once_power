import 'package:bot_toast/bot_toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/app.dart';
import 'config/language.dart';
import 'config/theme.dart';
import 'constants/string.dart';
import 'enums/app.dart';
import 'provider/select.dart';
import 'provider/toggle.dart';
import 'views/home.dart';

// TODO: 按钮颜色
// TODO: replace_switch 21
// TODO: 高级模式 title 颜色

void main(List<String> args) async {
  // if (kDebugMode) {
  //   debugProfileBuildsEnabled = true;
  //   debugPaintLayerBordersEnabled = true;
  // }
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
      title: AppString.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeConfig.light,
      darkTheme: ThemeConfig.dark,
      themeMode: ref.watch(currentThemeProvider).mode,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      home: BorderRadiusFrames(),
    );
  }
}

class BorderRadiusFrames extends StatelessWidget {
  const BorderRadiusFrames({super.key});

  @override
  Widget build(BuildContext context) {
    final BoxDecoration decoration = const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      boxShadow: [BoxShadow(color: Color(0x33000000), blurRadius: 6)],
    );

    return Consumer(
      builder: (context, ref, child) {
        final isMax = ref.watch(isMaxProvider.select((state) => state));
        return Container(
          margin: isMax ? EdgeInsets.zero : const EdgeInsets.all(8),
          clipBehavior: isMax ? Clip.none : Clip.antiAliasWithSaveLayer,
          decoration: isMax ? null : decoration,
          child: child,
        );
      },
      child: const HomeView(),
    );
  }
}
