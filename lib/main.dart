import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/config/config.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/views/home.dart';

import 'provider/select.dart';

void main() async {
  await Global.init();
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
    bool max = ref.watch(maxWindowProvider);

    return Container(
      margin: max ? EdgeInsets.zero : const EdgeInsets.all(8),
      clipBehavior: max ? Clip.none : Clip.antiAliasWithSaveLayer,
      decoration: max
          ? null
          : const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              boxShadow: [BoxShadow(color: Color(0x33000000), blurRadius: 8)],
            ),
      child: child,
    );
  }
}
