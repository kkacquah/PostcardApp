import 'package:flutter/material.dart';
import 'package:embark/Styles/Themes.dart';

import 'package:embark/Styles/Colors.dart';

class LoginPostcard extends StatelessWidget {
  EmbarkTheme _theme;
  Size _size;

  //TODO ALLOW changing of fontsize
  LoginPostcard(this._theme);

  Widget build(BuildContext context) {
    //container wrapps whole screen
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        color: EmbarkAlmostWhite,
        elevation: 6.0,
        child: Container(
            padding: EdgeInsets.all(17.0),
            child: Container(color: _theme.primaryVariant)));
  }
}
