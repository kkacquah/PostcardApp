import 'package:flutter/material.dart';
import 'colors.dart';

class LogIn extends StatelessWidget {
  final EmbarkTheme _theme;
  LogIn(this._theme);

  Widget build(BuildContext context) {
    return  Container(color: _theme.primary());
  }
}