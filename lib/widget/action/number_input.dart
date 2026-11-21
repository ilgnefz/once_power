import 'dart:math' as math;

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:once_power/config/theme/container_surface.dart';
import 'package:once_power/constant/number.dart';
import 'package:once_power/provider/toggle.dart';
import 'package:once_power/widget/base/input.dart';

/// 拼出输入框里的完整文本：数字与单位之间留一个空格（如「12 位」）。
String _composeText(String digits, String unit) =>
    unit.isEmpty ? digits : '$digits $unit';

/// 紧凑数字输入框：中间键入数字，左右按钮按 1 增减。
///
/// 传 [unit] 时单位直接拼进 controller.text（如「12 位」），由 [_UnitFormatter]
/// 在每次编辑后重新规范成「数字 + 空格 + 单位」，光标始终停在数字末尾、单位
/// 之前：单位删不掉，整串由一个 TextField 居中渲染。
class NumberInput extends ConsumerStatefulWidget {
  const NumberInput({
    super.key,
    this.value = 0,
    this.min = 0,
    this.max,
    this.unit,
    this.onChanged,
  }) : assert(max == null || min <= max, 'min 不能大于 max');

  final int value;
  final int min;
  final int? max;

  /// 数字后的单位文字（如「位」「个」）。null / 空串表示不显示。
  final String? unit;

  /// 数值变化回调：输入合法数字、点加减、失焦规范化时都会触发。
  final ValueChanged<int>? onChanged;

  @override
  ConsumerState<NumberInput> createState() => _NumberInputState();
}

/// 把输入规范成「数字 + 单位」，光标跟随它在数字内的相对位置。
class _UnitFormatter extends TextInputFormatter {
  const _UnitFormatter(this.unit);

  final String unit;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final String digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final int offset = math.max(
      0,
      math.min(newValue.selection.baseOffset, newValue.text.length),
    );
    final int cursor = newValue.text
        .substring(0, offset)
        .replaceAll(RegExp(r'\D'), '')
        .length;
    return TextEditingValue(
      text: _composeText(digits, unit),
      selection: TextSelection.collapsed(offset: cursor),
    );
  }
}

class _NumberInputState extends ConsumerState<NumberInput> {
  late final TextEditingController controller;
  late final FocusNode focusNode;

  /// 实际显示的单位：受全局「隐藏单位」开关控制。
  /// 用 read 而非 watch，这样在 initState / didUpdateWidget 里也能安全取值；
  /// build 中另外 watch 该 provider 来触发重建。
  String get _unit => ref.read(isHiddenUnitProvider) ? '' : (widget.unit ?? '');

  /// 最近一次合法值。输入中间态（空串）失焦时回退到它。
  late int _lastValue;

  @override
  void initState() {
    super.initState();
    _lastValue = _clamp(widget.value);
    controller = TextEditingController(
      text: _composeText('$_lastValue', _unit),
    );
    focusNode = FocusNode()..addListener(_onFocusChanged);
  }

  @override
  void didUpdateWidget(NumberInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    final bool unitChanged = widget.unit != oldWidget.unit;
    if (unitChanged ||
        widget.value != oldWidget.value ||
        widget.min != oldWidget.min ||
        widget.max != oldWidget.max) {
      _lastValue = _clamp(widget.value);
      // 单位变了要强制重写文本（增删空格+单位），数值变了靠 _syncText。
      _syncText(force: unitChanged);
    }
  }

  @override
  void dispose() {
    focusNode
      ..removeListener(_onFocusChanged)
      ..dispose();
    controller.dispose();
    super.dispose();
  }

  int _clamp(int raw) {
    if (raw < widget.min) return widget.min;
    if (widget.max != null && raw > widget.max!) return widget.max!;
    return raw;
  }

  /// controller 里是「数字 + 单位」，只取数字部分解析。
  int? _parse(String text) {
    final String digits = text.replaceAll(RegExp(r'\D'), '');
    if (digits.isEmpty) return null;
    return int.tryParse(digits);
  }

  /// 传入纯数字，内部拼上单位；光标放在数字末尾、单位之前。
  void _setValueText(String digits) {
    final String text = _composeText(digits, _unit);
    if (controller.text == text) return;
    controller.value = TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: digits.length),
    );
  }

  /// 父组件改了 value / 边界 / 单位时同步文本，但正在编辑时不打扰用户。
  void _syncText({bool force = false}) {
    if (focusNode.hasFocus && !force) return;
    _setValueText('$_lastValue');
  }

  void _onFocusChanged() {
    if (!focusNode.hasFocus) _commitText();
  }

  /// 输入过程中只上报合法数值，不改写文本，否则光标会被抢、数字打不完整。
  void _onTextChanged(String text) {
    final int? parsed = _parse(text);
    if (parsed == null) return;
    _lastValue = _clamp(parsed);
    widget.onChanged?.call(_lastValue);
  }

  /// 失焦 / 提交：空串回退到上次合法值，越界值夹回边界，文本统一规范化。
  void _commitText() {
    final int next = _clamp(_parse(controller.text) ?? _lastValue);
    _lastValue = next;
    _setValueText('$next');
    widget.onChanged?.call(next);
  }

  void _step(int delta) {
    final int base = _clamp(_parse(controller.text) ?? _lastValue);
    final int next = _clamp(base + delta);
    if (next == base) return;
    _lastValue = next;
    _setValueText('$next');
    widget.onChanged?.call(next);
  }

  @override
  Widget build(BuildContext context) {
    // watch 让开关切换时本组件重建，_unit / formatter 跟着变。
    ref.watch(isHiddenUnitProvider);
    // 开关翻转的那一帧同步文本：显示中/隐藏的单位要立刻从输入框去掉/补上。
    ref.listen(isHiddenUnitProvider, (_, _) => _syncText(force: true));
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
          crossAxisAlignment: .stretch,
          children: [
            NumberButton(icon: Icons.remove, onTap: () => _step(-1)),
            Expanded(
              // 输入框用控件底色；BaseInput 自身透明，靠这层 Container 上色，
              // 与全局输入框（inputDecorationTheme.fillColor）保持同源。
              child: Container(
                color: theme.colorScheme.surfaceContainer,
                alignment: .center,
                child: BaseInput(
                  hintText: '',
                  controller: controller,
                  focusNode: focusNode,
                  textAlign: .center,
                  contentPadding: EdgeInsets.zero,
                  inputFormatters: [_UnitFormatter(_unit)],
                  onChanged: _onTextChanged,
                ),
              ),
            ),
            NumberButton(icon: Icons.add, onTap: () => _step(1)),
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
    return SizedBox(
      width: 24.0,
      child: Ink(
        decoration: BoxDecoration(
          color: Theme.of(context).extension<ContainerSurfaceTheme>()!.color,
        ),
        child: InkWell(
          mouseCursor: SystemMouseCursors.click,
          onTap: onTap,
          child: Center(child: Icon(icon, size: 14)),
        ),
      ),
    );
  }
}
