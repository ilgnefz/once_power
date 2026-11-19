import 'package:material_ui/material_ui.dart';
import 'package:once_power/core/window.dart';
import 'package:window_manager/window_manager.dart';

class WindowView extends StatefulWidget {
  const WindowView({super.key, required this.child});

  final Widget child;

  @override
  State<WindowView> createState() => _WindowViewState();
}

class _WindowViewState extends State<WindowView> with WindowListener {
  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    _init();
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  Future<void> _init() async {
    await windowManager.setPreventClose(true);
  }

  @override
  void onWindowResized() {}

  @override
  void onWindowMoved() {}

  @override
  Future<void> onWindowClose() async {
    await closeWindow();
  }

  @override
  Widget build(BuildContext context) {
    return DragToResizeArea(child: widget.child);
  }
}
