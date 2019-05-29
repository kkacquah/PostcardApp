import 'package:flutter/material.dart';
import 'package:embark/Pages/LoginPage/LoginPage.dart';
import 'package:embark/Pages/PostcardPage/MyPostcardsPage.dart';
import 'package:embark/Styles/Themes.dart';
import 'package:embark/Services/profile.dart';

void main() async {
  // Set default home.
  Widget _defaultHome = new LoginPage(themes);
  // Get result of the login function.
  profile.signOut();
  bool _result = await profile.setCurrentUser();

  if (_result) {
    _defaultHome = new MyPostcardsPage();
  }
  runApp(MyApp(_defaultHome));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  final Widget _defaultHome;

  MyApp(this._defaultHome);

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: _defaultHome,
    );
  }
}
