import 'package:flutter/material.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:embark/Components/Button.dart';
import 'package:embark/Components/BackgroundShape.dart';
import 'package:embark/Pages/HomePage.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:embark/Styles/Icons.dart';

class LogIn extends StatelessWidget {
  final EmbarkTheme _theme;

  LogIn(this._theme);

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
//        TODO Get rid of hardcoded phone values
    //TODO Implement EmbarkScaffold
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
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    //TOP 0-1/8
                    Container(height: size.height / 8),
                    //TOP 1/8-5/8
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: size.height / 16),
                        height: size.height / 2,
                        child: Column(children: <Widget>[
                          Container(
                              child: Text("Welcome back to Embark.",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 40,
                                      fontFamily: "PlayfairDisplay"))),
                          Container(
                              child: Theme(
                                  data: ThemeData(
                                    primaryColor: _theme.primary(),
                                    hintColor: Colors.white,
                                    cursorColor: _theme.primary(),
                                    inputDecorationTheme: InputDecorationTheme(
                                        border: UnderlineInputBorder(),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 2))),
                                  ),
                                  child: Column(children: <Widget>[
                                    Container(
                                        margin: EdgeInsets.symmetric(vertical: 10),
                                        child: TextField(
                                            autofocus: true,
                                            decoration: InputDecoration(
                                              labelText: "Username",
                                            ))),
                                    Container(
                                        margin: EdgeInsets.symmetric(vertical: 10),
                                        child:TextField(
                                        obscureText: true,
                                        autofocus: true,
                                        decoration: InputDecoration(
                                          labelText: "Password",
                                        ))),
                                    Container(
                                      alignment: Alignment.centerRight,
                                        child:InkWell(
                                          child: new Text("Forgot Password?"),
                                        )

                                    )
                                  ])))
                        ])),
                    EmbarkButton(
                        _theme, () => {}, "Log In", false, EdgeInsets.all(0)),
                    Container(
                      height: 50,
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width / 16),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                flex: 1,
                                child: Container(color: EmbarkGray, height: 1)),
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: 20),
                                child: Text("OR CONNECT WITH",
                                    style: TextStyle(
                                        color: _theme.primary(),
                                        fontSize: 12))),
                            Expanded(
                                flex: 1,
                                child: Container(color: EmbarkGray, height: 1)),
                          ]),
                    ),
                    Container(
                      height: 50,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            EmbarkIconButton(facebookTheme, () => {}, " Facebook",
                                true, EdgeInsets.symmetric(horizontal: 15),facebookIcon),
                            EmbarkIconButton(googleTheme, () => {}, " Google", true,
                                EdgeInsets.symmetric(horizontal: 15),googleIcon)
                          ]),
                    )
                  ]))
            ]));
  }
}

class LinePainter extends CustomPainter {
  EmbarkTheme _theme;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    // set the color property of the paint
    paint.color = EmbarkGray;
    var path = Path();
    path.moveTo(0, size.height / 2);
    path.lineTo(size.width, size.height / 2);
    canvas.drawPath(path, paint);
    //TODO: DRAW SHADOW
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
