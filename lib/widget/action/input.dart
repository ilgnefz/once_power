import 'package:material_ui/material_ui.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/widget/base/icon.dart';
import 'package:once_power/widget/base/input.dart';

class const EasyInput({
  super.key,
  required final String hintText,
  final String? value,
  final String? suffixIcon,
  final String? suffixTip,
  required final void Function(String) onChanged,
  final void Function()? onSuffixPressed,
}) extends StatefulWidget {
  @override
  State<EasyInput> createState() => _EasyInputState();
}

class _EasyInputState extends State<EasyInput> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.value ?? '');
  }

  @override
  void didUpdateWidget(covariant EasyInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != null && widget.value != oldWidget.value) {
      if (controller.text != widget.value) controller.text = widget.value!;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void clear() {
    controller.clear();
    widget.onChanged('');
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return Container(
      padding: .symmetric(horizontal: AppNumber.paddingMedium),
      height: AppNumber.widgetHeight,
      width: double.infinity,
      decoration: BoxDecoration(
        color: theme.inputDecorationTheme.fillColor,
        borderRadius: .circular(AppNumber.radius),
        border: Border.all(
          color: theme.inputDecorationTheme.outlineBorder!.color,
          width: theme.inputDecorationTheme.outlineBorder!.width,
        ),
      ),
      alignment: .center,
      child: Row(
        spacing: AppNumber.spaceSmall,
        children: [
          Expanded(
            child: BaseInput(
              hintText: widget.hintText,
              controller: controller,
              onChanged: (value) {
                setState(() {});
                widget.onChanged(value);
              },
            ),
          ),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: controller,
            builder: (BuildContext _, TextEditingValue value, _) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: value.text.isEmpty
                    ? const SizedBox.shrink()
                    : ClickIcon(
                        onPressed: clear,
                        icon: Icons.close_rounded,
                        iconSize: 16,
                        size: 24,
                      ),
              );
            },
          ),
          if (widget.suffixIcon != null)
            ClickIcon(
              tip: widget.suffixTip,
              onPressed: widget.onSuffixPressed,
              svg: widget.suffixIcon!,
              iconSize: 18,
              size: 24,
            ),
        ],
      ),
    );
  }
}
