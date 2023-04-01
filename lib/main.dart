import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:once_power/language.dart';
import 'package:once_power/pages/home/home.dart';
import 'package:once_power/provider/organize_file.dart';
import 'package:once_power/provider/other.dart';
import 'package:once_power/provider/rename.dart';
import 'package:once_power/theme.dart';
import 'package:once_power/utils/package_info.dart';
import 'package:once_power/utils/storage.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

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
        ChangeNotifierProvider(create: (_) => OrganizeFileProvider()),
      ],
      builder: (context, child) {
        return MaterialApp(
          title: 'OncePower',
          debugShowCheckedModeBanner: false,
          builder: BotToastInit(),
          navigatorObservers: [BotToastNavigatorObserver()],
          home: const HomePage(),
          theme: theme,
          localizationsDelegates: LanguageManager.localizationsDelegates,
          supportedLocales: LanguageManager.supportedLocales,
          localeResolutionCallback: (locale, supportedLocales) =>
              LanguageManager.localeResolutionCallback(
                  context, locale, supportedLocales),
        );
      },
    );
  }
}
