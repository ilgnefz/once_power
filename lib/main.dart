import 'package:bot_toast/bot_toast.dart';
import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/global.dart';
import 'package:once_power/provider/provider.dart';
import 'package:once_power/views/home.dart';

void main() async {
  await Global.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        bool max = ref.watch(maxWindowProvider);
        return Container(
          margin: max ? EdgeInsets.zero : const EdgeInsets.all(8),
          clipBehavior: max ? Clip.none : Clip.antiAliasWithSaveLayer,
          decoration: max
              ? null
              : const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(color: Color(0x33000000), blurRadius: 8),
                  ],
                ),
          child: child,
        );
      },
      child: MaterialApp(
        title: 'OncePower',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          textTheme: const TextTheme(
            titleMedium: TextStyle(fontSize: 14, color: Colors.black),
            bodyLarge: TextStyle(fontSize: 14, color: Colors.black),
            bodyMedium: TextStyle(fontSize: 14, color: Colors.black),
          ).useSystemChineseFont(Brightness.light),
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [Locale('zh', 'CN')],
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        home: const HomePage(),
      ),
    );
  }
}
