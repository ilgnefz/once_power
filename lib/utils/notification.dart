import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:once_power/constants/constants.dart';
import 'package:once_power/model/enum.dart';
import 'package:once_power/model/rename_info.dart';
import 'package:once_power/widgets/click_icon.dart';
import 'package:once_power/widgets/svg_icon.dart';

class NotificationMessage {
  static Color showColor(MessageType type) {
    const Color failure = Colors.red;
    const Color success = Colors.green;
    const Color warning = Colors.orange;
    return type == MessageType.failure
        ? failure
        : type == MessageType.success
            ? success
            : warning;
  }

  static String showIcon(MessageType type) {
    return type == MessageType.failure
        ? AppIcons.error
        : type == MessageType.success
            ? AppIcons.success
            : AppIcons.warning;
  }

  static show(
      String title, String message, List<RenameInfo> info, MessageType type) {
    BotToast.showCustomNotification(
      toastBuilder: (context) {
        return Container(
          width: 320,
          padding: const EdgeInsets.symmetric(vertical: 8),
          margin: const EdgeInsets.only(
              top: 12, bottom: AppNum.bottomBarH + 12, right: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(.1), blurRadius: 8),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    SvgIcon(showIcon(type), color: showColor(type), size: 18),
                    const SizedBox(width: 4),
                    Text(title, style: TextStyle(color: showColor(type))),
                    const Spacer(),
                    ClickIcon(
                      icon: Icons.close,
                      onTap: context.call,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(message),
              ),
              if (info.isNotEmpty)
                ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 360),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          ...info.map((e) {
                            TextStyle fileStyle =
                                const TextStyle(color: Colors.blue);
                            TextStyle infoStyle =
                                const TextStyle(color: Color(0xFF666666));
                            return RichText(
                              text: TextSpan(
                                  text: e.file,
                                  style: fileStyle,
                                  children: [
                                    TextSpan(text: e.message, style: infoStyle)
                                  ]),
                            );
                          }).toList()
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
      wrapToastAnimation: notificationAnimation,
      duration: type == MessageType.success ? const Duration(seconds: 3) : null,
      align: Alignment.bottomRight,
    );
  }

  static Widget notificationAnimation(AnimationController controller,
          CancelFunc cancelFunc, Widget child) =>
      NormalAnimation(reverse: true, controller: controller, child: child);
}

class NormalAnimation extends StatefulWidget {
  final Widget child;
  final bool reverse;
  final AnimationController controller;

  const NormalAnimation(
      {Key? key,
      required this.child,
      this.reverse = false,
      required this.controller})
      : super(key: key);

  @override
  NormalAnimationState createState() => NormalAnimationState();
}

class NormalAnimationState extends State<NormalAnimation>
    with SingleTickerProviderStateMixin {
  static final Tween<Offset> reverseTweenOffset = Tween<Offset>(
    begin: const Offset(0, 40),
    end: const Offset(0, 0),
  );
  static final Tween<Offset> tweenOffset = Tween<Offset>(
    begin: const Offset(0, -40),
    end: const Offset(0, 0),
  );
  static final Tween<double> tweenOpacity = Tween<double>(begin: 0, end: 1);
  late final Animation<double> animation;

  late final Animation<Offset> animationOffset;
  late final Animation<double> animationOpacity;

  @override
  void initState() {
    animation =
        CurvedAnimation(parent: widget.controller, curve: Curves.decelerate);

    animationOffset =
        (widget.reverse ? reverseTweenOffset : tweenOffset).animate(animation);
    animationOpacity = tweenOpacity.animate(animation);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.controller,
      builder: (_, child) {
        return Transform.translate(
          offset: animationOffset.value,
          child: Opacity(
            opacity: animationOpacity.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
