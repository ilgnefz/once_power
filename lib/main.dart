import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/config.dart';
import 'constants/constants.dart';
import 'providers/toggle.dart';
import 'views/home.dart';

// 将文件剪切到软件暂存区，在某个图片前或后将图片复制出来 ctrl ctrl v 粘贴到软件中

void main(List<String> args) async {
  await AppConfig.init(args);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: BorderRadiusFrames(child: const HomeView()),
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
      boxShadow: [BoxShadow(color: Color(0x33000000), blurRadius: 6)],
    );

    return Container(
      margin: isMax ? EdgeInsets.zero : const EdgeInsets.all(8),
      clipBehavior: isMax ? Clip.none : Clip.antiAliasWithSaveLayer,
      decoration: isMax ? null : decoration,
      child: child,
    );
  }
}
