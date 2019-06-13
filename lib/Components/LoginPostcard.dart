import 'package:flutter/material.dart';
import 'package:embark/Styles/Themes.dart';



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
        elevation: 6.0,
        child: Container(
            padding: EdgeInsets.all(17.0),
<<<<<<< HEAD
            child: Container(color: _theme.primaryVariant())));
=======
            child: Container(color: _theme.primaryVariant)));
>>>>>>> c61d9e111f67ca40237d9a670fdcbbec38c1bed1
  }
}
