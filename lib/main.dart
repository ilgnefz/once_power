import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:once_power/pages/home/home.dart';
import 'package:once_power/provider/other.dart';
import 'package:once_power/provider/rename.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();

  WindowOptions options = const WindowOptions(
    size: Size(1000, 600),
    minimumSize: Size(1000, 600),
    center: true,
    title: 'OncePower',
  );

  windowManager.waitUntilReadyToShow(options, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RenameProvider()),
        ChangeNotifierProvider(create: (_) => OtherProvider()),
      ],
      child: MaterialApp(
        title: 'OncePower',
        debugShowCheckedModeBanner: false,
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        home: const HomePage(),
        theme: ThemeData(
          useMaterial3: true,
        ),
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('zh', 'CN'),
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          return locale?.languageCode == 'zh'
              ? const Locale('zh', 'CN')
              : const Locale('en', 'US');
        },
      ),
    );
  }
}
