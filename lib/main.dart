import 'package:flutter/material.dart';
import 'package:embark/Pages/LoginPage/LoginPage.dart';
import 'package:embark/Pages/ScrapbookPhotoViewPage/ScrapbookPhotoViewPage.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:embark/Styles/Themes.dart';
import 'package:embark/Services/Profile.dart';
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
  [
    ConsoleHandler(),
    ToastHandler(
        gravity: ToastHandlerGravity.bottom,
        length: ToastHandlerLength.long,
        backgroundColor: EmbarkAlmostBlack,
        textColor: EmbarkExtraLightGray,
        textSize: 12.0,
        customMessage: "Sorry, but an unexpected error occured.")
  ],
  handlerTimeout: 10000,
);

void main() async {
  // Set default home.
  Widget _defaultHome = new LoginPage(EmbarkThemes.themes, EmbarkFonts.fonts);
  // Get result of the login function.
  bool _result = await profile.setCurrentUser();
  if (_result) {
    print("returned true");
    _defaultHome = new ScrapbookPhotoViewPage();
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
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              color: Colors.transparent,
              actionsIconTheme: IconThemeData(
                  color: EmbarkAlmostBlack, size: 36, opacity: 1.0),
              elevation: 0,
              iconTheme: IconThemeData(
                  color: EmbarkAlmostBlack, size: 36, opacity: 1.0)),
          backgroundColor: EmbarkExtraLightGray,
          brightness: Brightness.light,
          hintColor: EmbarkLightGray,
          dialogBackgroundColor: EmbarkAlmostBlack,
          accentColor: EmbarkAlmostWhite,
          textSelectionHandleColor: EmbarkAlmostWhite,
          fontFamily: "OpenSans"),
      title: 'Flutter Demo',
      home: _defaultHome,
    );
  }
}
