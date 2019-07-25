import 'package:flutter/material.dart';
import 'package:embark/Styles/Colors.dart';
import 'dart:ui' as ui;
import 'dart:math';

//set based on height
class ColorPainter extends CustomPainter {
  Color color;

  ColorPainter({this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    // set the color property of the paint

    double sideLength = size.width;
    Rect rectangle = Rect.fromLTWH(0, 0, sideLength, sideLength);
    paint.color = color;
    paint.style = PaintingStyle.fill;
    canvas.drawRect(rectangle, paint);
  }

  //For animation
  @override
  bool shouldRepaint(ColorPainter oldDelegate) {
    return true;
  }
}

//set based on height
class FontPainter extends CustomPainter {
  static const SHADOW_OFFSET = Offset(1.0,1.0);
  String fontStyle;
  double yOffset;

  FontPainter({this.fontStyle, this.yOffset = -2.0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.maskFilter= MaskFilter.blur(BlurStyle.normal, 3);
    // set the color property of the paint
    TextSpan shadowSpan = new TextSpan(
        style: new TextStyle(
            fontFamily: this.fontStyle,
            height: 1.0,
            textBaseline: TextBaseline.alphabetic,
            color: EmbarkColors.black.withOpacity(0.25),
            fontSize: size.width * (5 / 6)),
        text: "Aa");
    TextPainter tpShadow = new TextPainter(
        text: shadowSpan,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tpShadow.layout();
    Offset offset = Offset(0.0, this.yOffset * (size.width) / 50) + SHADOW_OFFSET;
    tpShadow.paint(canvas, offset);
    paint.maskFilter= null;
    // set the color property of the paint
    TextSpan span = new TextSpan(
        style: new TextStyle(
            fontFamily: this.fontStyle,
            height: 1.0,
            textBaseline: TextBaseline.alphabetic,
            color: EmbarkColors.white,
            fontSize: size.width * (5 / 6)),
        text: "Aa");
    TextPainter tp = new TextPainter(
        text: span,
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr);
    tp.layout();
    tp.paint(canvas, Offset(0.0, this.yOffset * (size.width) / 50));
  }

  //For animation
  @override
  bool shouldRepaint(FontPainter oldDelegate) {
    return true;
  }
}

class ImagePainter extends CustomPainter {
  Rect fractionalCropRect;
  ui.Image image;

  ImagePainter({this.fractionalCropRect, this.image});

  @override
  void paint(Canvas canvas, Size size) {
    // set the color property of the paint
    Rect imageRectSrc = Rect.fromLTWH(
        fractionalCropRect.left * image.width.toDouble(),
        fractionalCropRect.top * image.height.toDouble(),
        fractionalCropRect.width * image.width.toDouble(),
        fractionalCropRect.height * image.height.toDouble());
    Rect imageRectDst = Rect.fromLTWH(0, 0, size.width, size.height);
    canvas.drawImageRect(image, imageRectSrc, imageRectDst, Paint());
  }

//For animation
  @override
  bool shouldRepaint(ImagePainter oldDelegate) {
    if (this.fractionalCropRect != oldDelegate.fractionalCropRect) {
      return true;
    } else {
      return false;
    }
  }
}
