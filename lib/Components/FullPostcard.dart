import 'package:flutter/material.dart';
import 'package:embark/Services/PostcardInfo.dart';
import 'package:embark/Components/Button.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:embark/Services/profile.dart';
import 'dart:ui';

class TagFilterEntry {
  const TagFilterEntry(this.tag);

  final String tag;
}

class FullPostcard extends StatefulWidget {
  final PostcardInfo _postcardInfo;
  bool _photoState;

  FullPostcard(this._postcardInfo, this._photoState);

  @override
  State createState() {
    return _FullPostcardState(this._postcardInfo);
  }
}

class _FullPostcardState extends State<FullPostcard> {
  final PostcardInfo _postcardInfo;
  AnimationController controller;
  Animation<Offset> offset;
  DateTime date;

  _FullPostcardState(this._postcardInfo) {
    date = this._postcardInfo.timestamp.toDate();
  }

  Iterable<Widget> get tagWidgets sync* {
    bool filled = true;
    for (TagFilterEntry tag in _postcardInfo.sentiments.map((value) {
      return TagFilterEntry(value);
    })) {
      filled = !filled;
      if (filled) {
        yield Chip(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(500),
              side: BorderSide(color: _postcardInfo.theme.secondary)),
          backgroundColor: Colors.white,
          label: Text(tag.tag),
          labelStyle: TextStyle(
            fontFamily: _postcardInfo.fontFamily,
            fontWeight: FontWeight.w100,
            color: _postcardInfo.theme.secondary,
            fontSize: 12,
          ),
        );
      } else {
        yield Chip(
          backgroundColor: _postcardInfo.theme.secondary,
          label: Text(tag.tag),
          labelStyle: TextStyle(
            fontFamily: _postcardInfo.fontFamily,
            fontWeight: FontWeight.w100,
            color: Colors.white,
            fontSize: 12,
          ),
        );
      }
    }
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    //container wrapps whole screen
    return Stack(
      children: [
        Positioned(
            bottom: 0,
            width: size.width,
            child: Container(
              decoration: BoxDecoration(
                color: EmbarkAlmostWhite,
                boxShadow: [
                  BoxShadow(
                      color: EmbarkAlmostBlack.withOpacity(0.25),
                      offset: new Offset(0, -2),
                      blurRadius: 4)
                ],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(14.0),
                    topRight: Radius.circular(14.0)),
//                border: Border(top: BorderSide)
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(size.width*0.075, 15, size.width*0.075, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                                height: 45,
                                margin: EdgeInsets.only(
                                    top: 5, bottom: 5,  right: 15),
                                decoration: BoxDecoration(
                                    color: EmbarkExtraLightGray,
                                    boxShadow: [
                                      new BoxShadow(
                                          color: Colors.black26,
                                          offset: new Offset(1, 1),
                                          blurRadius: 4.0,
                                          spreadRadius: 1)
                                    ],
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: EmbarkLightGray, width: 1)),
                                child: ClipOval(
                                    child:
                                        Image.network(profile.user.photoUrl))),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(_postcardInfo.title,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 24,
                                    color: _postcardInfo.theme.secondary,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: _postcardInfo.fontFamily)),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  color: Colors.grey,
                                  size: 14,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                  child: Text(
                                      " " + _postcardInfo.location + " ",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w200,
                                          fontFamily:
                                              _postcardInfo.fontFamily)),
                                ),
                                Icon(
                                  Icons.access_time,
                                  color: Colors.grey,
                                  size: 14,
                                ),
                                Padding(
                                    padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                    child: Text(
                                        " ${date.month}/${date.day}/${date.year}",
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w200,
                                            fontFamily:
                                                _postcardInfo.fontFamily))),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Container(
                      child: Wrap(
                        spacing: 5,
                        runSpacing: -10,
                        children: tagWidgets.toList(),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(bottom:30),
                        child: Text(_postcardInfo.status,
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: _postcardInfo.theme.primary,
                                height: 1,
                                fontFamily: _postcardInfo.fontFamily))),
                  ],
                ),
              ),
            ))
      ],
    );
  }
}

class CustomRect extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    Rect rect = Rect.fromLTRB(0.0, 0, size.width, size.height);
    return rect;
  }

  @override
  bool shouldReclip(CustomRect oldClipper) {
    return false;
  }
}
