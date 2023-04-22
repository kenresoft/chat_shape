library chat_shape;

import 'dart:math';

import 'package:flutter/material.dart';

class ChatShapePainter extends CustomPainter {
  /// A [CustomPainter] which creates a `chat-bubble-like` shape with border radius applied.
  ///
  /// The [height], [handleWidth], [handleHeight], and [radius]
  /// have `lower bounds` and `upper bounds` which helps to prevent overflows in the shape.
  ///
  /// The shape handle can take 2 different forms, which are specified in [Enum] values:
  ///
  /// * [HandleType.straight] or
  /// * [HandleType.curved]
  ///
  /// This is a sample on how to implement this shape in your flutter project:
  ///
  /// {@tool snippet}
  ///
  /// ```dart
  /// ChatShapePainter(
  ///   context: context,
  ///   width: MediaQuery.of(context).size.width - 30,
  ///   height: 200,
  ///   color: Colors.indigo,
  ///   applyTopRadius: true,
  ///   enableHandle: true,
  ///   handleHeight: 80,
  ///   handleWidth: 165,
  ///   radius: 30,
  ///   enableHandleCap: false,
  ///   handle: HandleType.curved,
  /// );
  /// ```
  ///
  /// {@end-tool}
  const ChatShapePainter({
    required this.context,
    required this.width,
    required this.height,
    required this.color,
    this.radius = 8,
    this.applyTopRadius = true,
    this.enableHandle = true,
    this.enableHandleCap = false,
    this.handleHeight = 56,
    this.handleWidth = 0,
    required this.handle,
  }) : assert(radius > 0);

  final BuildContext context;

  /// The width of this chat shape
  final double width;

  /// The height of this chat shape
  final double height;

  /// The [Color] used to paint this shape.
  final Color color;

  /// The border radius of this shape. [radius] applies only to the `topLeft`, `topRight`, and `BottomLeft`.
  /// This must be non-negative. That is, [radius] must be `>= 0`
  /// The maximum value of radius that can be render is 100.
  final double radius;

  /// For desired result, the *[radiusTop]* should be either [zero] or
  /// equal to [radius]. It can be greater than [radius], but
  /// doing so will have the same effect as when equal to [radius].
  /// When [applyTopRadius] is **[true]** the the top takes the radius value and when **[false]**
  /// no radius value is applied.
  /// * By default, [applyTopRadius] is [true].
  final bool applyTopRadius;

  /// You can either enable or disable the handle if you desire.
  /// If false, the shape will be a rectangle.
  ///
  /// By default, the property is true.
  final bool enableHandle;

  /// This defines whether or not the handle edge will be `curved/capped` or not.
  /// Applies to all handle types.
  ///
  /// By default, this property is disabled, ie., [false]
  final bool enableHandleCap;

  /// The `height` of the handle of this shape.
  /// This is constrained inorder to disallow overflow in dimensions.
  ///
  /// * [max] = 300
  /// * [min] = 30
  final double handleHeight;

  /// The `width` of the handle of this shape.
  /// This is constrained inorder to disallow overflow in dimensions.
  ///
  /// * [max] = 200
  /// * [min] = 0
  final double handleWidth;

  /// Specify the type of handle to apply the this shape.
  /// The shape handle can take 2 different forms, which are specified in [Enum] values:
  ///
  /// * [HandleType.straight] or
  /// * [HandleType.curved]
  final HandleType handle;

  @override
  void paint(Canvas canvas, Size size) {
    //double width = MediaQuery.of(context).size.width;
    /// defining the properties (dimension boundaries) of the `height` of the shape `body`
    double maxHeight = 300;
    double minHeight = 40;
    double height = this.height > maxHeight
        ? maxHeight
        : this.height < minHeight
            ? minHeight
            : this.height;

    /// defining the properties (dimension boundaries) of the handle `height`
    double maxHandleHeight = 300;
    double minHandleHeight = 30;
    double handleHeight = this.handleHeight > maxHandleHeight
        ? maxHandleHeight
        : this.handleHeight < minHandleHeight
            ? minHandleHeight
            : this.handleHeight;

    /// defining the properties (dimension boundaries) of the handle `width`
    /// ....... width moves from shape center to the shape width, towards the right.
    double maxHandleWidth = 200;
    double minHandleWidth = 0;
    double handleWidth = this.handleWidth > maxHandleWidth
        ? maxHandleWidth
        : this.handleWidth < minHandleWidth
            ? minHandleWidth
            : this.handleWidth;

    /// defining the property (dimension boundaries) for the shape `border radius`
    double maxRadius = 50;
    double radius = this.radius > maxRadius ? maxRadius : this.radius;

    double x = width;

    /// This is the minimum width expected for proper rendering of this shape.
    if (x < 100) {
      x = 100;
    }
    double y1 = height;
    double y2 = height + handleHeight;

    /// Handle width should not be greater than half the width of the shape.
    if (handleWidth > x / 2) {
      handleWidth = 0;
    }

    /// The paint `color` and `style`........................................................................................................
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    /// This is the primary Rectangle which makes up the shape body.
    /// Using [RRect.fromRectAndRadius], the [radius] of the shape can be easily specified.
    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, x, y1),
      Radius.circular(radius),
    );

    /// Instantiating `Path` so we can define our paths.
    final path = Path();

    /// Center of Arc is also origin of Cap (Same horizontal plane)
    /// This helps us to get a center through which we can define other relative `x` and `y` dimensions to it.
    final center = Rect.fromPoints(Offset(handleWidth, height), Offset(x, y2)).center;

    /// Width of cap
    const factor = 30;

    /// x-origin of the cap
    final xOrigin = x - factor;

    /// y-origin of the cap
    final yOrigin = center.dy;

    /// the center of the cap. THis is where the two `quadraticBeziers` meet and connects with each other.
    final capCenter = /*((size.width - x) / 2) +*/ x;

    /// Drawing logic for a curved handle
    if (handle == HandleType.curved) {
      /// move to handle width first before drawing the curve to the cap origin.

      path.moveTo(handleWidth + radius, height);
      if (enableHandleCap) {
        /*handle.getHandle(path, handleWidth, y2, xOrigin, height); // Arc from center of rectangle to cap origin, the width (x-15).
        path.moveTo(xOrigin, yOrigin); // Move to the origin of the cap.
        path.lineTo(x, center.dy); // Horizontal line passing through the cap.*/

        /// The curve line
        path.quadraticBezierTo(x - 80, 40, xOrigin, yOrigin + yOrigin / 7);

        /// The left-side of the cap curve
        path.quadraticBezierTo(x, yOrigin + yOrigin / 7, capCenter, yOrigin);

        /// The right-side of the cap curve.
        /// These two `quadraticBeziers` now forms the cap shape.
        path.quadraticBezierTo(x, yOrigin, x, yOrigin);
        /*canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(x - 25.9, center.dy - 24, 26, 29), const Radius.elliptical(305, 180)), paint); // The cap.*/
      } else {
        handle.getHandle(path, handleWidth, y2, x, height); // Arc from center of rectangle to the end, the `shape` width (x)
      }
    }

    /// Drawing logic for a straight handle
    if (handle == HandleType.straight) {
      /*final center = Rect.fromPoints(Offset(handleWidth, height), Offset(x, y2)).center; // Center of Arc is also origin of Cap (Same horizontal plane)
      center.toast;*/

      path.moveTo(handleWidth, height);
      if (enableHandleCap) {
        /*/// Arc from center of rectangle to cap origin, the width (x-15).
        handle.getHandle(path, handleWidth, center.dy, x - 15, height);
        /// Move to the origin of the cap.
        path.moveTo(x - 15, center.dy);
        /// Horizontal line passing through the cap.
        path.lineTo(x, center.dy);*/

        /// The straight line
        path.lineTo(xOrigin, yOrigin + yOrigin / 7);

        /// The left-side of the cap curve
        path.quadraticBezierTo(x, yOrigin + yOrigin / 7, capCenter, yOrigin);

        /// The right-side of the cap curve.
        /// These two `quadraticBeziers` now forms the cap shape.
        path.quadraticBezierTo(x, yOrigin, x, yOrigin);
        /* /// The cap.
        canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(x - 15, center.dy - 15.5, 15, 18), const Radius.circular(10)), paint);*/
      } else {
        /// Arc from center of rectangle to the end, the `shape` width (x)
        handle.getHandle(path, handleWidth, center.dy, x, height);
      }
    }

    /// Logic to show or hide the topRadius of the shape
    !applyTopRadius ? path.lineTo(x, 0) : path.lineTo(x, height / 2); // A line from the handle height,
    /// upwards to the top of the shape [case: `false`] or to mid-height of the shape [case: `true`]
    !applyTopRadius ? path.lineTo(0, 0) : null; // if [case: `false`], then move back to origin or else do nothing.
    path.lineTo(0, height / 2); // finally move to the mid-height, so as to close the path.
    path.lineTo(handleWidth, height);

    /// Draw the main Rectangular shape
    canvas.drawRRect(rect, paint);

    /// Whether to enable the handle
    if (enableHandle) {
      canvas.drawPath(path, paint);
    }
  }

  /// Not going to change
  /*To add animation feature in future time.*/
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

/// Specify the type of handle to apply the this shape.
/// The shape handle can take 2 different forms, which are specified in [Enum] values:
///
/// * [HandleType.straight] or
/// * [HandleType.curved]
enum HandleType {
  /// A straight-handle chat bubble
  straight,

  /// A curved-handle chat bubble
  curved,
}

extension HandleExtension on HandleType {
  /// This function draws the left-side of the handle.
  /// This is the `straight` or `curved` line that makes up the handle of the shape.
  void getHandle(Path path, double x, double y, double width, double height) {
    switch (this) {
      case HandleType.straight:
        path.lineTo(width, y);
        break;

      /// This is used for a curved line only when the cap is not enabled.
      case HandleType.curved:
        path.arcTo(
          Rect.fromPoints(
            Offset(x, height),
            Offset(width, y),
          ),
          (3 * pi / 2),
          (pi / 2),
          false,
        );
        break;
      default:
    }
  }
}
