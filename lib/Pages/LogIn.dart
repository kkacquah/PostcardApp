import 'package:flutter/material.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:embark/Components/Button.dart';
import 'package:embark/Components/BackgroundShape.dart';
import 'package:embark/Pages/authentication.dart';
import 'package:embark/Styles/Icons.dart';
class LogIn extends StatefulWidget {
  final EmbarkTheme _theme;
  LogIn(this._theme) ;

  @override
  _LogInState createState() => _LogInState();
}
class _LogInState extends State<LogIn> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  _LogInState();
  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
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
                      BoxDecoration(gradient: widget._theme.backgroundGradient())),
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
                                    primaryColor: widget._theme.primary(),
                                    hintColor: Colors.white,
                                    cursorColor: widget._theme.primary(),
                                    inputDecorationTheme: InputDecorationTheme(
                                        border: UnderlineInputBorder(),
                                        enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.white,
                                                width: 2))),
                                  ),
                                  child: Column(children: <Widget>[
                                    Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: TextField(
                                            controller: emailController,
                                            keyboardType: TextInputType.emailAddress,
                                            autofocus: true,
                                            decoration: InputDecoration(
                                              labelText: "Email",
                                            ))),
                                    Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 10),
                                        child: TextField(
                                            controller: passwordController,
                                            obscureText: true,
                                            autofocus: true,
                                            decoration: InputDecoration(
                                              labelText: "Password",
                                            ))),
                                    Container(
                                        alignment: Alignment.centerRight,
                                        child: InkWell(
                                          child: new Text("Forgot Password?"),
                                        ))
                                  ])))
                        ])),
                    EmbarkButton(widget._theme, () => authServiceEmailAndPassword.signIn(emailController.text, passwordController.text), "Log In",
                                false, EdgeInsets.all(0)),
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
                                        color: widget._theme.primary(),
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
                            EmbarkIconButton(
                                facebookTheme,
                                () => authServiceFacebook.facebookSignIn(),
                                " Facebook",
                                true,
                                EdgeInsets.symmetric(horizontal: 15),
                                facebookIcon),
                            EmbarkIconButton(
                                googleTheme,
                                () => authServiceGoogle.googleSignIn(),
                                " Google",
                                true,
                                EdgeInsets.symmetric(horizontal: 15),
                                googleIcon)
                          ]),
                    )
                  ]))
            ]));
  }
}
