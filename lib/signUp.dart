import 'package:flutter/material.dart';
import 'colors.dart';

class SignUp extends StatelessWidget {
  final EmbarkTheme _theme;

  SignUp(this._theme);

  Widget build(BuildContext context) {
    return  Container(color: _theme.secondary());
  }
}