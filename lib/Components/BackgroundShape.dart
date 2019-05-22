import 'package:flutter/material.dart';
import '../colors.dart';

class Background extends StatelessWidget {

  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return IgnorePointer(
        child: CustomPaint(
        painter: BackgroundPainter(),
      child: Container(height: size.height / 2, width: size.width),
    ));
  }
}

class BackgroundPainter extends CustomPainter {
  EmbarkTheme _theme;
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    // set the color property of the paint
    paint.color = EmbarkBackgroundWhite;
    // create a path
    var startPoint = Offset(0, 3 * size.height / 4);
    var controlPoint1 = Offset(1 * size.width / 4, 3.5 * size.height / 4);
    var controlPoint2 = Offset(3 * size.width / 4, 3.5 * size.height / 4);
    var endPoint = Offset(size.width, 3 * size.height / 4);
    // close the path to form a bounded shape
    var path = Path();
    path.moveTo(size.width, size.height * 2);
    path.lineTo(0, size.height * 2);
    path.lineTo(startPoint.dx, startPoint.dy);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);
    canvas.drawPath(path, paint);
    //TODO: DRAW SHADOW
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
