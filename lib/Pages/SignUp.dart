import 'package:flutter/material.dart';
import 'package:embark/Styles/Colors.dart';

class SignUp extends StatelessWidget {
  final EmbarkTheme _theme;

  SignUp(this._theme);

  Widget build(BuildContext context) {
    return new Scaffold(
        body: Stack(children: <Widget>[
      Container(
          decoration: BoxDecoration(gradient: _theme.backgroundGradient())),
      Container(
          padding: EdgeInsets.all(25.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                    padding: EdgeInsets.all(25.0),
                    child: Text("Welcome back to Embark",
                        style: TextStyle(
                            color: this._theme.primary(),
                            fontSize: 40,
                            fontFamily: "PlayfairDisplayBlack"))),
                Container(child: TextField()),
                Container(child: TextField()),
              ]))
    ]));
  }
}
