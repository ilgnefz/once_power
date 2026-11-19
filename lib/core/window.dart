import 'dart:io';

import 'package:window_manager/window_manager.dart';

Future<void> closeWindow() async {
  await windowManager.destroy();
  exit(0);
}
