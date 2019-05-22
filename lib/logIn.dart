import 'package:flutter/material.dart';
import 'colors.dart';
import 'package:embark/Components/Button.dart';
import 'package:embark/Components/BackgroundShape.dart';
import 'homePage.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LogIn extends StatelessWidget {
  final EmbarkTheme _theme;

  LogIn(this._theme);

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
//        TODO Get rid of hardcoded phone values
    return new Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
            alignment: Alignment.center,

            overflow: Overflow.visible,
            fit: StackFit.loose,
            children: <Widget>[
              Container(
                  decoration:
                      BoxDecoration(gradient: _theme.backgroundGradient())),
              Background(),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        //Where this
                        Container(
                            padding: EdgeInsets.only(top: 130),
                            child: Text("Welcome back to Embark.",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 40,
                                    fontFamily: "PlayfairDisplay"))),

                        Container(
                            child: Theme(
                          data: ThemeData(
                            primaryColor: _theme.secondary(),
                            hintColor: _theme.primary(),
                            inputDecorationTheme: InputDecorationTheme(
                                border: UnderlineInputBorder(),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: _theme.primary()))),
                          ),
                          child: TextField(
                              autofocus: true,
                              decoration: InputDecoration(
                                labelText: "Username",
                              )),
                        )),
                        Container(
                            child: Theme(
                          data: ThemeData(
                            primaryColor: _theme.secondary(),
                            hintColor: _theme.primary(),
                            cursorColor: _theme.primary(),
                            inputDecorationTheme: InputDecorationTheme(
                                border: UnderlineInputBorder(),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: _theme.primary()))),
                          ),
                          child: TextField(
                              obscureText: true,
                              autofocus: true,
                              decoration: InputDecoration(
                                labelText: "Password",
                              )),
                        )),
                        //TODO: Position this to be

                        Padding(
                            padding: EdgeInsets.only(top: 120),
                            child: EmbarkButton(
                                _theme, () => {}, "Log In", false, 10)),
//                        Container(
//                          height: 12,
//                          child: Row(
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              crossAxisAlignment: CrossAxisAlignment.center,
//                              children: <Widget>[
//                                Container(color: Colors.white),
//                                Text("OR CONNECT WITH",
//                                    style: TextStyle(
//                                        color: _theme.primary(), fontSize: 12)),
//                                Container(color: Colors.white)
//                              ]),
//                        ),
//                        Container(
//                          height: 70,
//                          child: Row(
//                              mainAxisAlignment: MainAxisAlignment.center,
//                              crossAxisAlignment: CrossAxisAlignment.center,
//                              children: <Widget>[
//                                EmbarkButton(
//                                    _theme, () => {}, "Log In", false, 10),
//                                EmbarkButton(
//                                    _theme, () => {}, "Log In", false, 10)
//                              ]),
//                        )
                      ]))
            ]));
  }
}
