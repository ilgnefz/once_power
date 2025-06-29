import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'config/config.dart';
import 'constants/constants.dart';
import 'providers/select.dart';
import 'providers/toggle.dart';
import 'utils/hot_key.dart';
import 'views/home.dart';

void main(List<String> args) async {
  await AppConfig.init(args);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      await AppHotKey.init(ref);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppText.name,
      debugShowCheckedModeBanner: false,
      theme: ThemeConfig.light,
      darkTheme: ThemeConfig.dark,
      themeMode: ref.watch(currentThemeModeProvider),
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
