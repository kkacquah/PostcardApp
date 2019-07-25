import 'package:embark/Styles/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';


const List<Color> BLUE_STRIPES_LIST = [
  Colors.transparent,
  Colors.transparent,
  EmbarkColors.blue,
  EmbarkColors.blue,
  Colors.transparent,
  Colors.transparent,
  EmbarkColors.blue,
  EmbarkColors.blue,
  Colors.transparent,
  Colors.transparent,
  EmbarkColors.blue,
  EmbarkColors.blue,
];
const List<Color> PURPLE_STRIPES_LIST = [
  Colors.transparent,
  Colors.transparent,
  EmbarkColors.purple,
  EmbarkColors.purple,
  Colors.transparent,
  Colors.transparent,
  EmbarkColors.purple,
  EmbarkColors.purple,
  Colors.transparent,
  Colors.transparent,
  EmbarkColors.purple,
  EmbarkColors.purple,
];
const List<double> SIX_STOP_STRIPE_LIST = [
  0,
  0.166,
  0.166,
  0.333,
  0.333,
  0.5,
  0.5,
  0.666,
  0.666,
  0.833,
  0.833,
  1.0
];

Widget DEFAULT_BACKGROUND = Container(
  decoration: BoxDecoration(
      gradient: LinearGradient(
          colors: [EmbarkColors.white, EmbarkColors.extraLightGray],
          stops: [0, 3 / 4],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter)),
);
Widget STRIPE_BACKGROUND = Container(
  decoration: BoxDecoration(
      gradient: LinearGradient(
          colors: [
            EmbarkColors.white,
            EmbarkColors.white,
            EmbarkColors.red,
            EmbarkColors.red,
            EmbarkColors.white,
            EmbarkColors.white,
            EmbarkColors.red,
            EmbarkColors.red
          ],
          tileMode: TileMode.repeated,
          stops: [0, 0.25, 0.25, 0.5, 0.5, 0.75, 0.75, 1.0],
          begin: Alignment.topLeft,
          end: Alignment.center)),
);
Widget PLAID_BACKGROUND = Stack(children: [
  Container(
      color: EmbarkColors.white
  ),
  Opacity(
      opacity: 0.6,
      child:
      Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: BLUE_STRIPES_LIST,
                  tileMode: TileMode.repeated,
                  stops: SIX_STOP_STRIPE_LIST,
                  begin: Alignment.topCenter,
                  end: Alignment.center)))),
  Opacity(
      opacity: 0.6,
      child:
      Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: BLUE_STRIPES_LIST,
                  tileMode: TileMode.repeated,
                  stops: SIX_STOP_STRIPE_LIST,
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight)))),
]);
Widget ZIGZAG_BACKGROUND = Stack(children: [
  Container(
      color: EmbarkColors.white
  ),
  Flex(
    direction: Axis.vertical,
  children:[
    Flexible(
      flex: 1,
      child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: PURPLE_STRIPES_LIST,
                  tileMode: TileMode.repeated,
                  stops: SIX_STOP_STRIPE_LIST,
                  begin: Alignment.bottomRight,
                  end: Alignment.center)))),
  Flexible(
      flex: 1,
      child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: PURPLE_STRIPES_LIST,
                  tileMode: TileMode.repeated,
                  stops: SIX_STOP_STRIPE_LIST,
                  begin: Alignment.center,
                  end: Alignment.bottomLeft)))),
    Flexible(
        flex: 1,
        child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: PURPLE_STRIPES_LIST,
                    tileMode: TileMode.repeated,
                    stops: SIX_STOP_STRIPE_LIST,
                    begin: Alignment.bottomRight,
                    end: Alignment.center)))),
  ]),

]);

Widget SUNSET_BACKGROUND = Container(
  decoration: BoxDecoration(
      gradient: LinearGradient(
          colors: [Color(0xFFFC00FF),Color(0xFF00DBDE)],
          stops: [0, 1],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter)),
);


List<Widget> BACKGROUND_LIST = [
  DEFAULT_BACKGROUND,
  STRIPE_BACKGROUND,
  PLAID_BACKGROUND,
  ZIGZAG_BACKGROUND,
  SUNSET_BACKGROUND
];
