import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:window_manager/window_manager.dart';

class MyContextMenu extends StatelessWidget {
  const MyContextMenu({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    const double width = 80;
    const double height = 32;

    return GestureDetector(
      onSecondaryTapDown: (detail) async {
        Size size = await windowManager.getSize();
        print('窗口尺寸：$size');
        print('detail: ${detail.globalPosition}');
        if (!context.mounted) return;
        showModal(
          context: context,
          configuration: const FadeScaleTransitionConfiguration(
            barrierColor: Colors.transparent,
          ),
          builder: (BuildContext context) {
            double x = detail.globalPosition.dx;
            double y = detail.globalPosition.dy;
            // 如果x坐标+80大于屏幕宽度，则x坐标减去80
            // 如果y坐标+32大于屏幕高度，则y坐标减去32
            if (x + width > size.width) x -= width;
            if (y + height > size.height) y -= height;
            return UnconstrainedBox(
              alignment: Alignment.topLeft,
              child: Container(
                width: width,
                height: height,
                margin: EdgeInsets.only(left: x, top: y),
                decoration: BoxDecoration(
                  // color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 2,
                      color: Colors.black.withOpacity(.2),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('删除失败')),
                      );
                    },
                    child: const Center(
                      child: Text(
                        '删除',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
      child: child,
    );
  }
}
