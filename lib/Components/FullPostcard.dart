import 'package:flutter/material.dart';
import 'package:embark/Services/PostcardInfo.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:embark/Services/profile.dart';
import 'dart:ui';

class TagFilterEntry {
  const TagFilterEntry(this.tag);

  final String tag;
}

class FullPostcard extends StatelessWidget {
  final PostcardInfo _postcardInfo;
  DateTime date;

  FullPostcard(this._postcardInfo){
    date = this._postcardInfo.timestamp.toDate();
  }


  Iterable<Widget> get tagWidgets sync* {
    bool filled = true;
    for (TagFilterEntry tag in  _postcardInfo.sentiments.map((value){return TagFilterEntry(value);})) {
      filled = !filled;
      if (filled) {
        yield Chip(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(500),
              side: BorderSide(color: _postcardInfo.theme.secondary())),
          backgroundColor: Colors.white,
          label: Text(tag.tag),
          labelStyle: TextStyle(
            fontFamily: _postcardInfo.theme.fontFamily(),
            fontWeight: FontWeight.w100,
            color: _postcardInfo.theme.secondary(),
            fontSize: 10,
          ),
        );
      } else {
        yield Chip(
          backgroundColor: _postcardInfo.theme.secondary(),
          label: Text(tag.tag),
          labelStyle: TextStyle(
            fontFamily: _postcardInfo.theme.fontFamily(),
            fontWeight: FontWeight.w100,
            color: Colors.white,
            fontSize: 10,
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
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: new NetworkImage(_postcardInfo.photoUrl),
            ),
          ),
          child: new BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child: new Container(
              decoration:
                  new BoxDecoration(color: Colors.white.withOpacity(0.0)),
            ),
          ),
        ),
        Container(
          width: size.width,
          margin: EdgeInsets.only(bottom:size.height*(3/8)),
        child:ClipRect(
            clipper:CustomRect(),
            child: Image.network(_postcardInfo.photoUrl, fit: BoxFit.fitWidth))),
        Positioned(
            bottom: 68,
            width: size.width,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
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
                                    top: 5, bottom: 5, left: 20, right: 15),
                                decoration: BoxDecoration(
                                    color: EmbarkGray,
                                    boxShadow: [
                                      new BoxShadow(
                                          color: Colors.black26,
                                          offset: new Offset(1, 1),
                                          blurRadius: 4.0,
                                          spreadRadius: 1)
                                    ],
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: EmbarkGray, width: 1)),
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
                                    color: _postcardInfo.theme.secondary(),
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        _postcardInfo.theme.fontFamily())),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  color: Colors.grey,
                                  size: 14,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                  child: Text(_postcardInfo.location,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w200,
                                          fontFamily: _postcardInfo.theme
                                              .fontFamily())),
                                ),
                                Icon(
                                  Icons.access_time,
                                  color: Colors.grey,
                                  size: 14,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                  child: Text("${date.month}/${date.day}/${date.year}",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w200,
                                          fontFamily: _postcardInfo.theme
                                              .fontFamily())),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: Wrap(
                        spacing: 5,
                        runSpacing: -10,
                        children: tagWidgets.toList(),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(25, 0, 25, 0),
                        child: Text(
                            _postcardInfo.status,
                            style: TextStyle(
                                fontSize: 12,
                                color: _postcardInfo.theme.primary(),
                                height: 1,
                                fontFamily: _postcardInfo.theme.fontFamily()))),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Spacer(flex: 2),
                          FlatButton.icon(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            textColor: Colors.white,
                            color: _postcardInfo.theme.secondary(),
                            icon: Icon(
                              Icons.bookmark,
                              color: Colors.white,
                              size: 16,
                            ),
                            label: Text('Save'),
                          ),
                          Spacer(),
                          OutlineButton.icon(
                            onPressed: () {},
                            borderSide: BorderSide(color: _postcardInfo.theme.secondary()),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            textColor: _postcardInfo.theme.secondary(),
                            icon: Icon(
                              Icons.share,
                              color:  _postcardInfo.theme.secondary(),
                              size: 16,
                            ),
                            label: Text('Share'),
                          ),
                          Spacer(flex: 2),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ))
      ],
    );
  }
}

class CustomRect extends CustomClipper<Rect>{
  @override
  Rect getClip(Size size) {
     Rect rect = Rect.fromLTRB(0.0,0, size.width, size.height);
      return rect;
  }
  @override
  bool shouldReclip(CustomRect oldClipper) {
    return false;
  }
}

