import 'package:flutter/material.dart';
import 'package:embark/Styles/Icons.dart';
import 'package:embark/Styles/Colors.dart';

class PostCardInfo {
  String _timeString;
  String _title;
  String _locationString;

  PostCardInfo(String timeString, String title, String locationString) {
    this._timeString = timeString;
    this._title = title;
    this._locationString = locationString;
  }

  String getTimeString() {
    return this._timeString;
  }

  String getTitle() {
    return this._title;
  }

  String locationString() {
    return this._locationString;
  }
}

class Postcard extends StatelessWidget{
  EmbarkTheme _theme;
  PostCardInfo _postcardInfo;
  Size _size;
  //TODO ALLOW changing of fontsize
  Postcard(this._theme, this._postcardInfo);
  Widget build(BuildContext context) {
    //container wrapps whole screen
    return Container(
          padding:EdgeInsets.only(left:60, right:60, bottom:70),
            child: Card(
                child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Stack(children: <Widget>[
                      Column(children: <Widget>[
                        Expanded(
                            flex: 1,
                            child: Container(color: _theme.primaryVariant())),
                        Container(height: 40, color: Colors.white),
                      ]),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            //placing text at the bottom
                            Expanded(flex: 1, child: Container()),
                            Container(
                                height: 60,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    // Box decoration takes a gradient
                                    gradient: LinearGradient(
                                  // Where the linear gradient begins and ends
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  // Add one stop for each color. Stops should increase from 0 to 1
                                  stops: [0.75, 1.0],
                                  colors: [
                                    // Colors are easy thanks to Flutter's Colors class.
                                    Colors.white,
                                    Color(0x00FFFFFF),
                                    //transparent white
                                  ],
                                )),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      _postcardInfo._timeString,
                                      style: TextStyle(
                                          fontFamily: 'PlayfairDisplay',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 10.0,
                                          color: _theme.secondary()),
                                    ),
                                    Text(
                                      _postcardInfo._title,
                                      style: TextStyle(
                                          fontFamily: 'PlayfairDisplay',
                                          fontWeight: FontWeight.w900,
                                          fontSize: 24.0,
                                          color: _theme.primary()),
                                    ),
                                    Row(children: <Widget>[
                                      locationOn,
                                      Text(
                                        _postcardInfo._locationString,
                                        style: TextStyle(
                                            fontSize: 10.0, color: EmbarkGray),
                                      )
                                    ])
                                  ],
                                ))
                          ])
                    ]))));
  }
}
