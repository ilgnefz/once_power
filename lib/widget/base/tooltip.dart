// import 'dart:async';
// TODO: 删除我
//
// import 'package:flutter/material.dart';
//
// enum Placement { bottom, right, top, left }
//
// class EasyTooltip extends StatefulWidget {
//   const EasyTooltip({
//     super.key,
//     required this.placement,
//     this.message,
//     this.richMessage,
//     this.waitDuration = const Duration(seconds: 2),
//     required this.child,
//   }) : assert(
//          message != null || richMessage != null,
//          'Either message or richMessage must be provided',
//        );
//
//   final Placement placement;
//   final String? message;
//   final Widget? richMessage;
//   final Duration waitDuration;
//   final Widget child;
//
//   @override
//   State<EasyTooltip> createState() => _EasyTooltipState();
// }
//
// class _EasyTooltipState extends State<EasyTooltip> {
//   final double distance = 8.0;
//   final LayerLink link = LayerLink();
//   OverlayEntry? overlayEntry;
//   Timer? timer;
//
//   void startShowTimer() {
//     timer?.cancel();
//     timer = Timer(widget.waitDuration, () {
//       showTooltip();
//     });
//   }
//
//   void showTooltip() {
//     overlayEntry = OverlayEntry(
//       builder: (context) {
//         Widget child = Material(
//           child: PhysicalShape(
//             clipper: TooltipClipper(placement: widget.placement),
//             elevation: 2,
//             color: Colors.white,
//             shadowColor: Colors.black.withValues(alpha: .5),
//             child: Container(
//               padding: .symmetric(vertical: 4, horizontal: 8),
//               constraints: BoxConstraints(
//                 maxWidth: MediaQuery.of(context).size.width * 0.4,
//               ),
//               decoration: BoxDecoration(
//                 borderRadius: .circular(4),
//                 color: Colors.white,
//               ),
//               child:
//                   widget.richMessage ??
//                   Text(
//                     widget.message ?? '',
//                     style: TextStyle(color: Colors.black, fontSize: 12),
//                   ),
//             ),
//           ),
//         );
//
//         Alignment followerAnchor, targetAnchor;
//         Offset offset;
//         switch (widget.placement) {
//           case Placement.top:
//             followerAnchor = Alignment.bottomCenter;
//             targetAnchor = Alignment.topCenter;
//             offset = Offset(0, -distance);
//             break;
//           case Placement.bottom:
//             followerAnchor = Alignment.topCenter;
//             targetAnchor = Alignment.bottomCenter;
//             offset = Offset(0, distance);
//             break;
//           case Placement.left:
//             followerAnchor = Alignment.centerRight;
//             targetAnchor = Alignment.centerLeft;
//             offset = Offset(-distance, 0);
//             break;
//           case Placement.right:
//             followerAnchor = Alignment.centerLeft;
//             targetAnchor = Alignment.centerRight;
//             offset = Offset(distance, 0);
//             break;
//         }
//
//         return TweenAnimationBuilder(
//           tween: Tween(begin: 0.0, end: 1.0),
//           duration: Duration(milliseconds: 200),
//           curve: Curves.easeOut,
//           builder: (context, value, child) => Opacity(
//             opacity: value,
//             // child: Transform.scale(scale: 0.8 + (0.2 * value), child: child),
//             child: child,
//           ),
//           child: UnconstrainedBox(
//             child: CompositedTransformFollower(
//               link: link,
//               offset: offset,
//               followerAnchor: followerAnchor,
//               targetAnchor: targetAnchor,
//               child: child,
//             ),
//           ),
//         );
//       },
//     );
//
//     Overlay.of(context).insert(overlayEntry!);
//   }
//
//   void hideTooltip() {
//     timer?.cancel();
//     if (overlayEntry != null) {
//       overlayEntry!.remove();
//       overlayEntry = null;
//     }
//   }
//
//   @override
//   void dispose() {
//     hideTooltip();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MouseRegion(
//       onEnter: (_) => startShowTimer(),
//       onExit: (_) => hideTooltip(),
//       child: CompositedTransformTarget(link: link, child: widget.child),
//     );
//   }
// }
//
// class TooltipClipper extends CustomClipper<Path> {
//   final Placement placement;
//   final double arrowWidth;
//   final double arrowHeight;
//   final double borderRadius;
//
//   TooltipClipper({
//     required this.placement,
//     this.arrowWidth = 10.0,
//     this.arrowHeight = 6.0,
//     this.borderRadius = 4.0,
//   });
//
//   @override
//   Path getClip(Size size) {
//     final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);
//     final Path path = Path();
//
//     // 1. 添加带圆角的矩形主体
//     path.addRRect(RRect.fromRectAndRadius(rect, Radius.circular(borderRadius)));
//
//     // 2. 添加箭头路径
//     switch (placement) {
//       case Placement.top:
//         path.moveTo(size.width / 2 - arrowWidth / 2, size.height);
//         path.lineTo(size.width / 2, size.height + arrowHeight);
//         path.lineTo(size.width / 2 + arrowWidth / 2, size.height);
//         break;
//       case Placement.bottom:
//         path.moveTo(size.width / 2 - arrowWidth / 2, 0);
//         path.lineTo(size.width / 2, -arrowHeight);
//         path.lineTo(size.width / 2 + arrowWidth / 2, 0);
//         break;
//       case Placement.left:
//         path.moveTo(size.width, size.height / 2 - arrowWidth / 2);
//         path.lineTo(size.width + arrowHeight, size.height / 2);
//         path.lineTo(size.width, size.height / 2 + arrowWidth / 2);
//         break;
//       case Placement.right:
//         path.moveTo(0, size.height / 2 - arrowWidth / 2);
//         path.lineTo(-arrowHeight, size.height / 2);
//         path.lineTo(0, size.height / 2 + arrowWidth / 2);
//         break;
//     }
//     path.close();
//     return path;
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
// }
