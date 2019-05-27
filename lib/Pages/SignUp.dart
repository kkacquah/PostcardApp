import 'package:flutter/material.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:embark/Components/Button.dart';
import 'package:embark/Components/BackgroundShape.dart';
import 'package:embark/Pages/authentication.dart';
import 'package:embark/Styles/Icons.dart';

class SignUp extends StatefulWidget {
  final EmbarkTheme _theme;

  SignUp(this._theme);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordReenterController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();

  _SignUpState();

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
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
                                            EdgeInsets.only(bottom: 0),
                                            child: TextField(
                                                controller: firstNameController,
                                                keyboardType: TextInputType
                                                    .emailAddress,
                                                autofocus: true,
                                                decoration: InputDecoration(
                                                  labelText: "First Name",
                                                ))),
                                        Container(
                                            margin:
                                            EdgeInsets.only(bottom: 0),
                                            child: TextField(
                                                controller: lastNameController,
                                                obscureText: true,
                                                autofocus: true,
                                                decoration: InputDecoration(
                                                  labelText: "Last Name",
                                                ))), Container(
                                            margin:
                                            EdgeInsets.only(bottom: 0),
                                            child: TextField(
                                                controller: emailController,
                                                keyboardType: TextInputType
                                                    .emailAddress,
                                                autofocus: true,
                                                decoration: InputDecoration(
                                                  labelText: "Email",
                                                ))),
                                        Container(
                                            margin:
                                            EdgeInsets.only(bottom: 0),
                                            child: TextField(
                                                controller: passwordController,
                                                obscureText: true,
                                                autofocus: true,
                                                decoration: InputDecoration(
                                                  labelText: "Password",
                                                ))),
                                        //TODO: Check if password reenter works
                                        Container(
                                            margin:
                                            EdgeInsets.only(bottom: 0),
                                            child: TextField(
                                                controller: passwordReenterController,
                                                obscureText: true,
                                                autofocus: true,
                                                decoration: InputDecoration(
                                                  labelText: "Re-enter Password",
                                                )))
                                      ])))
                            ])),
                        EmbarkButton(widget._theme, () =>
                            //TODO: PUT ERROR ALERT CHECKS HERE
                            authServiceEmailAndPassword.signUp(
                                firstNameController.text+lastNameController.text,
                                emailController.text, passwordController.text),
                            "Sign Up",
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
                                    child: Container(
                                        color: EmbarkGray, height: 1)),
                                Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Text("OR CONNECT WITH",
                                        style: TextStyle(
                                            color: widget._theme.primary(),
                                            fontSize: 12))),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                        color: EmbarkGray, height: 1)),
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
                                        () =>
                                        authServiceFacebook.facebookSignIn(),
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
