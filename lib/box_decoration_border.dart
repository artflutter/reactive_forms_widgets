// import 'dart:math' as math;
// import 'package:flutter/material.dart';
//
// class BoxDecorationBorder extends InputBorder {
//   /// Creates an underline border for an [InputDecorator].
//   ///
//   /// The [borderSide] parameter defaults to [BorderSide.none] (it must not be
//   /// null). Applications typically do not specify a [borderSide] parameter
//   /// because the input decorator substitutes its own, using [copyWith], based
//   /// on the current theme and [InputDecorator.isFocused].
//   ///
//   /// The [borderRadius] parameter defaults to a value where the top left
//   /// and right corners have a circular radius of 4.0. The [borderRadius]
//   /// parameter must not be null.
//   const BoxDecorationBorder({
//     BorderSide borderSide = const BorderSide(),
//     this.decoration,
//     this.borderRadius = const BorderRadius.only(
//       topLeft: Radius.circular(4.0),
//       topRight: Radius.circular(4.0),
//     ),
//   })  : assert(borderRadius != null),
//         super(borderSide: borderSide);
//
//   /// The radii of the border's rounded rectangle corners.
//   ///
//   /// When this border is used with a filled input decorator, see
//   /// [InputDecoration.filled], the border radius defines the shape
//   /// of the background fill as well as the bottom left and right
//   /// edges of the underline itself.
//   ///
//   /// By default the top right and top left corners have a circular radius
//   /// of 4.0.
//   final BorderRadius borderRadius;
//
//   final BoxDecoration decoration;
//
//   @override
//   bool get isOutline => false;
//
//   @override
//   BoxDecorationBorder copyWith({
//     BoxDecoration decoration,
//     BorderSide borderSide,
//     BorderRadius borderRadius,
//   }) {
//     return BoxDecorationBorder(
//       decoration: decoration ?? this.decoration,
//       borderSide: borderSide ?? this.borderSide,
//       borderRadius: borderRadius ?? this.borderRadius,
//     );
//   }
//
//   @override
//   EdgeInsetsGeometry get dimensions {
//     return EdgeInsets.only(bottom: borderSide.width);
//   }
//
//   @override
//   BoxDecorationBorder scale(double t) {
//     return BoxDecorationBorder(borderSide: borderSide.scale(t));
//   }
//
//   @override
//   Path getInnerPath(Rect rect, {TextDirection textDirection}) {
//     return Path()
//       ..addRect(Rect.fromLTWH(rect.left, rect.top, rect.width,
//           math.max(0.0, rect.height - borderSide.width)));
//   }
//
//   @override
//   Path getOuterPath(Rect rect, {TextDirection textDirection}) {
//     return Path()..addRRect(borderRadius.resolve(textDirection).toRRect(rect));
//   }
//
//   @override
//   ShapeBorder lerpFrom(ShapeBorder a, double t) {
//     if (a is BoxDecorationBorder) {
//       return BoxDecorationBorder(
//         decoration: BoxDecoration.lerp(a.decoration, decoration, t),
//         borderSide: BorderSide.lerp(a.borderSide, borderSide, t),
//         borderRadius: BorderRadius.lerp(a.borderRadius, borderRadius, t),
//       );
//     }
//     return super.lerpFrom(a, t);
//   }
//
//   @override
//   ShapeBorder lerpTo(ShapeBorder b, double t) {
//     if (b is BoxDecorationBorder) {
//       return BoxDecorationBorder(
//         decoration: BoxDecoration.lerp(decoration, b.decoration, t),
//         borderSide: BorderSide.lerp(borderSide, b.borderSide, t),
//         borderRadius: BorderRadius.lerp(borderRadius, b.borderRadius, t),
//       );
//     }
//     return super.lerpTo(b, t);
//   }
//
//   /// Draw a horizontal line at the bottom of [rect].
//   ///
//   /// The [borderSide] defines the line's color and weight. The `textDirection`
//   /// `gap` and `textDirection` parameters are ignored.
//   @override
//   void paint(
//     Canvas canvas,
//     Rect rect, {
//     double gapStart,
//     double gapExtent = 0.0,
//     double gapPercentage = 0.0,
//     TextDirection textDirection,
//   }) {
//     if (borderRadius.bottomLeft != Radius.zero ||
//         borderRadius.bottomRight != Radius.zero)
//       canvas.clipPath(getOuterPath(rect, textDirection: textDirection));
//     canvas.drawLine(rect.bottomLeft, rect.bottomRight, borderSide.toPaint());
//
//     decoration.createBoxPainter().paint(
//           canvas,
//           Offset.zero,
//           ImageConfiguration(
//             size: rect.size,
//             textDirection: textDirection,
//           ),
//         );
//   }
//
//   @override
//   bool operator ==(Object other) {
//     if (identical(this, other)) return true;
//     if (other.runtimeType != runtimeType) return false;
//     return other is BoxDecorationBorder &&
//         other.borderSide == borderSide &&
//         other.decoration == decoration;
//   }
//
//   @override
//   int get hashCode => borderSide.hashCode;
// }
