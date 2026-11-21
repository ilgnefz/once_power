import 'package:cupertino_ui/cupertino_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/config/language.dart';
import 'package:once_power/constant/text.dart';
import 'package:once_power/enmu/app.dart';
import 'package:once_power/view/home.dart';

import 'config/app.dart';
import 'config/theme/theme.dart';
import 'model/appearance.dart';
import 'provider/value.dart';

// TODO: 使用系统字体
// TODO: 更改省略式中间还是末尾
// TODO: 视频可以截取某个帧作为封面（自动检测是否是同一个封面）
// TODO: 视频自定义截取封面时间
// TODO: 任务完成检测是否在前台来决定是否发送系统通知
// TODO: 设置界面显示所有记录和清理记录功能
// TODO: 高级模式三个功能放进一个弹窗，添加确定、确定并关闭按钮，根据选择的组自动显示第一条选中数据的名称变化
// TODO: 实时监测和修改上传的txt和csv文件
// TODO:设置新增文件在前面还是后面
// TODO:关于获取子文件夹及其子子文件夹的问题

Future<void> main(List<String> args) async {
  await AppConfig.init(args);
  // SchedulerBinding.instance.addTimingsCallback((List<FrameTiming> timings) {
  //   for (final FrameTiming t in timings) {
  //     final int build = t.buildDuration.inMicroseconds;
  //     final int raster = t.rasterDuration.inMicroseconds;
  //     if (build > 16700 || raster > 16700) {
  //       // 60Hz 预算；120Hz 用 8300
  //       debugPrint('[jank] build=${build / 1000}ms raster=${raster / 1000}ms');
  //     }
  //   }
  // });
  runApp(
    ProviderScope(
      child: EasyLocalization(
        fallbackLocale: LanguageConfig.fallbackLocale,
        startLocale: LanguageConfig.startLocale,
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppearanceSettings appearance = ref.watch(appearanceProvider);
    return MaterialApp(
      title: AppText.appName,
      debugShowCheckedModeBanner: false,
      themeMode: appearance.theme.mode,
      theme: ThemeConfig.light(appearance),
      darkTheme: ThemeConfig.dark(appearance),
      localizationsDelegates: [
        ...context.localizationDelegates,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate, // 文本方向
      ],
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: HomeView(),
    );
  }
}
