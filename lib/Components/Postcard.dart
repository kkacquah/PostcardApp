import 'package:flutter/material.dart';
import 'package:embark/Styles/Icons.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:embark/Styles/Themes.dart';

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

class Postcard extends StatelessWidget {
  EmbarkTheme _theme;
  PostCardInfo _postcardInfo;
  Size _size;

  //TODO ALLOW changing of fontsize
  Postcard(this._theme, this._postcardInfo);

  Widget build(BuildContext context) {
    //container wrapps whole screen
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        elevation: 6.0,
        child: Container(
            padding: EdgeInsets.all(17.0),
            child: Container(color: _theme.primaryVariant())));
  }
}
