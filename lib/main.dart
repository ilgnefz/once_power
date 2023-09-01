import 'package:bot_toast/bot_toast.dart';
import 'package:chinese_font_library/chinese_font_library.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:once_power/global.dart';
import 'package:once_power/views/home.dart';

void main() async {
  await Global.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OncePower',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: const TextTheme(
          // displayLarge: TextStyle(fontSize: 14, color: Colors.black),
          // displayMedium: TextStyle(fontSize: 14, color: Colors.black),
          // displaySmall: TextStyle(fontSize: 14, color: Colors.black),
          // headlineLarge: TextStyle(fontSize: 14, color: Colors.black),
          // headlineMedium: TextStyle(fontSize: 14, color: Colors.black),
          // headlineSmall: TextStyle(fontSize: 14, color: Colors.black),
          // titleLarge: TextStyle(fontSize: 14, color: Colors.black),
          titleMedium: TextStyle(fontSize: 14, color: Colors.black),
          // titleSmall: TextStyle(fontSize: 12, color: Colors.black),
          bodyLarge: TextStyle(fontSize: 14, color: Colors.black),
          bodyMedium: TextStyle(fontSize: 14, color: Colors.black),
          // bodySmall: TextStyle(fontSize: 12, color: Colors.black),
          // labelLarge: TextStyle(fontSize: 14, color: Colors.black),
          // labelMedium: TextStyle(fontSize: 14, color: Colors.black),
          // labelSmall: TextStyle(fontSize: 14, color: Colors.black),
        ).useSystemChineseFont(),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('zh', 'CN')],
      builder: BotToastInit(), //1.调用BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()],
      home: const HomePage(),
    );
  }
}
