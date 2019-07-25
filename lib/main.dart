import 'package:flutter/material.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:catcher/catcher_plugin.dart';
import 'package:redux/redux.dart';
import 'Pages/Scrapbook/EditScrapbook/EditScrapbookCover/EditScrapbookCover.dart';

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
        backgroundColor: EmbarkColors.black,
        textColor: EmbarkColors.extraLightGray,
        textSize: 12.0,
        customMessage: "Sorry, but an unexpected error occured.")
  ],
  handlerTimeout: 10000,
);

void main() async {
  // Set default home.
  //Widget _defaultHome = new LoginPage(EmbarkColors.fontColors, EmbarkFonts.fonts);
  Widget _defaultHome  = new EditScrapbookView();
  // Get result of the login function
  runApp(EmbarkApp(_defaultHome));
}

class EmbarkApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  final Widget _defaultHome;

  EmbarkApp(this._defaultHome);

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: AppBarTheme(
              color: Colors.transparent,
              actionsIconTheme: IconThemeData(
                  color: EmbarkColors.black, size: 36, opacity: 1.0),
              elevation: 0,
              iconTheme: IconThemeData(
                  color: EmbarkColors.black, size: 36, opacity: 1.0)),
          backgroundColor: EmbarkColors.extraLightGray,
          brightness: Brightness.light,
          hintColor: EmbarkColors.lightGray,
          dialogBackgroundColor: EmbarkColors.black,
          cursorColor: EmbarkColors.gray,
          accentColor: EmbarkColors.white,
          textSelectionHandleColor: EmbarkColors.white,
          fontFamily: "OpenSans"),
      title: 'Flutter Demo',
      home: _defaultHome,
    );
  }
}
