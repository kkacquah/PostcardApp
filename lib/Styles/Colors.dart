import 'package:flutter/material.dart';

class EmbarkColor extends Color {
  final name;
  const EmbarkColor(hex, {this.name}) : super(hex);
}

class EmbarkColors {
  static const EmbarkColor purple = EmbarkColor(0xFF4E40B9, name: "Royal Purple");
  static const EmbarkColor pink = EmbarkColor(0xFFF8B9C2, name: "Pretty in Pink");
  static const EmbarkColor blue = EmbarkColor(0xFF3F51B5, name: "Violet Blue");
  static const EmbarkColor red = EmbarkColor(0xFFAD0000, name: "Tuscan Red");
  static const EmbarkColor green = EmbarkColor(0xFF6FCF97, name: "Sea Green");
  static const EmbarkColor black = EmbarkColor(0xFF282828, name: "Midnight");
  static const EmbarkColor white = EmbarkColor(0xFFFFFCFC);
  static const EmbarkColor gray = EmbarkColor(0xFF727272);
  static const EmbarkColor mediumGray = EmbarkColor(0xFF8c8c8c);
  static const lightGray = EmbarkColor(0xFFD8D8D8);
  static const extraLightGray = EmbarkColor(0xFFF7F7F5);
  static const fontColors = [black, purple, pink, blue, red, green];
}
