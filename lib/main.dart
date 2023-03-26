import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:once_power/model/types.dart';
import 'package:once_power/pages/home/home.dart';
import 'package:once_power/provider/other.dart';
import 'package:once_power/provider/rename.dart';
import 'package:once_power/utils/package_info.dart';
import 'package:once_power/utils/storage.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await StorageUtil.init();
  await PackageDesc.init();

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

  static late BuildContext appContext;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RenameProvider()),
        ChangeNotifierProvider(create: (_) => OtherProvider()),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'OncePower',
          debugShowCheckedModeBanner: false,
          builder: BotToastInit(),
          navigatorObservers: [BotToastNavigatorObserver()],
          home: const HomePage(),
          theme: ThemeData(
            useMaterial3: true,
            pageTransitionsTheme: const PageTransitionsTheme(
              builders: <TargetPlatform, PageTransitionsBuilder>{
                TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
                TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
                TargetPlatform.macOS: FadeUpwardsPageTransitionsBuilder(),
              },
            ),
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
            if (StorageUtil().getString('language') != null) {
              if (StorageUtil().getString('language') == 'zh') {
                context
                    .watch<OtherProvider>()
                    .toggleLanguage(LanguageType.chinese);
                return const Locale('zh', 'CN');
              }
              return const Locale('en', 'US');
            }
            if (locale?.languageCode == 'zh') {
              context
                  .watch<OtherProvider>()
                  .toggleLanguage(LanguageType.chinese);
              return const Locale('zh', 'CN');
            }
            return const Locale('en', 'US');
          },
        );
      },
    );
  }
}
