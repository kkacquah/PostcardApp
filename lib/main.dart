import 'package:flutter/material.dart';
import 'package:embark/Pages/LoginPage/LoginPage.dart';
import 'package:embark/Pages/PostcardPage/MyPostcardsPage.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:embark/Styles/Themes.dart';
import 'package:embark/Services/profile.dart';
import 'package:catcher/catcher_plugin.dart';

//debug configuration
CatcherOptions debugOptions =
CatcherOptions(DialogReportMode(), [ConsoleHandler()]);

//release configuration
CatcherOptions releaseOptions = CatcherOptions(DialogReportMode(), [
  EmailManualHandler(["kkacquah@mit.edu"])
]);

//profile configuration
CatcherOptions profileOptions = CatcherOptions(
  NotificationReportMode(),
  [ConsoleHandler(),  ToastHandler(
      gravity: ToastHandlerGravity.bottom,
      length: ToastHandlerLength.long,
      backgroundColor: EmbarkAlmostBlack,
      textColor: EmbarkGray,
      textSize: 12.0,
      customMessage: "Sorry, but an unexpected error occured.")
  ],
  handlerTimeout: 10000,
);
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
