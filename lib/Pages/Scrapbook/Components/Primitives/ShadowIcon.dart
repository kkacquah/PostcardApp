import 'package:embark/Styles/Colors.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class ShadowIcon extends StatelessWidget {
  final IconData icon;
  final EmbarkColor color;
  final double size;

  ShadowIcon({this.icon, this.color = EmbarkColors.white, this.size = 26.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
        child: Stack(children: [
          Positioned(
              top: 1.0,
              left: 1.0,
              child: Icon(icon,
                  color: EmbarkColors.black.withOpacity(0.25),
                  size: this.size)),
          BackdropFilter(
              filter: new ui.ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
              child: Icon(
                icon,
                color: EmbarkColors.white,
                size: this.size,
              ))
        ]));
  }
}
