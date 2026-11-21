import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/config/theme/container_surface.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/widget/base/input.dart';

class NumberInput extends StatefulWidget {
  const NumberInput({super.key, this.value = 0, this.min = 0, this.max});

  final int value;
  final int min;
  final int? max;

  @override
  State<NumberInput> createState() => _NumberInputState();
}

class _NumberInputState extends State<NumberInput> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: '${widget.value}');
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void increment() {
    int value = int.tryParse(controller.text) ?? 0;
    if (value < widget.min) value = widget.min;
    if (widget.max != null && value >= widget.max!) return;
    controller.text = (value + 1).toString();
  }

  void decrement() {
    int value = int.tryParse(controller.text) ?? 0;
    if (widget.max != null && value > widget.max!) value = widget.max!;
    if (value <= widget.min) return;
    controller.text = (value - 1).toString();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    // 容器底色铺在最底层：两侧按钮用它，圆角裁剪处也不会露出别的颜色。
    final Color containerSurface = theme
        .extension<ContainerSurfaceTheme>()!
        .color;
    return Container(
      height: AppNumber.widgetHeight,
      alignment: .center,
      child: Material(
        color: containerSurface,
        shape: RoundedRectangleBorder(
          borderRadius: .circular(AppNumber.radius),
          side: BorderSide(
            color: theme.inputDecorationTheme.outlineBorder!.color,
            width: theme.inputDecorationTheme.outlineBorder!.width,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Row(
          // stretch 让两侧按钮底色铺满整行高度，避免上下露出 Material 底色。
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            NumberButton(icon: Icons.remove, onTap: decrement),
            Expanded(
              // 输入框用控件底色；BaseInput 自身透明，靠这层 ColoredBox 上色，
              // 与全局输入框（inputDecorationTheme.fillColor）保持同源。
              child: Container(
                color: theme.colorScheme.surfaceContainer,
                alignment: .center,
                child: BaseInput(
                  hintText: '',
                  controller: controller,
                  textAlign: .center,
                  contentPadding: EdgeInsets.zero,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  onChanged: (value) {},
                ),
              ),
            ),
            NumberButton(icon: Icons.add, onTap: increment),
          ],
        ),
      ),
    );
  }
}

class const NumberButton({
  super.key,
  required final IconData icon,
  required final void Function() onTap,
}) extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 底色画在普通 Container 上：Ink 的 decoration 会画到祖先 Material 的墨层，
    // 绕开外层圆角裁剪，导致按钮底色从圆角处溢出。Container 则老老实实被裁。
    return Container(
      width: 24,
      color: Theme.of(context).extension<ContainerSurfaceTheme>()!.color,
      child: InkWell(
        mouseCursor: SystemMouseCursors.click,
        onTap: onTap,
        child: Center(child: Icon(icon, size: 14)),
      ),
    );
  }
}
