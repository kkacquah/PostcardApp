import 'package:flutter/material.dart';
import 'package:embark/Styles/Themes.dart';
import 'package:embark/Styles/Colors.dart';
import 'dart:math';

//set based on height
class ThemePainter extends CustomPainter{
  EmbarkTheme theme;
  ThemePainter({this.theme});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    // set the color property of the paint

    double sideLength = size.width*(2/3) ;
    Rect upperLeftRect = Rect.fromLTWH(0, 0, sideLength,sideLength);
    Rect lowerRightRect = Rect.fromLTWH( sideLength/2,sideLength/2, sideLength,sideLength);
    paint.color = theme.primary;
    paint.style = PaintingStyle.fill;
    canvas.drawRect(lowerRightRect, paint);
    paint.color = theme.secondary;
    canvas.drawRect(upperLeftRect, paint);
    paint.color = theme.primary;
    paint.strokeWidth = sideLength/16;
    paint.style = PaintingStyle.stroke;
    canvas.drawRect(upperLeftRect, paint);
  }

  //For animation
  @override
  bool shouldRepaint(ThemePainter oldDelegate) {
    return true;
  }
}

//set based on height
class FontPainter extends CustomPainter{
  String fontStyle;
  double yOffset;
  FontPainter({this.fontStyle, this.yOffset = -2.0});
  @override
  void paint(Canvas canvas, Size size) {
    // set the color property of the paint
    TextSpan span = new TextSpan(style: new TextStyle(fontFamily: this.fontStyle,height:1.0, textBaseline:TextBaseline.alphabetic, color: EmbarkAlmostBlack,fontSize: size.width*(3/4)), text: "Aa");
    TextPainter tp = new TextPainter(text: span, textAlign: TextAlign.center, textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(0.0,this.yOffset*(size.width)/50));
  }

  //For animation
  @override
  bool shouldRepaint(FontPainter oldDelegate) {
    return true;
  }
}