import 'package:flutter/material.dart';
import 'package:embark/Services/PostcardInfo.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:embark/Styles/Themes.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:embark/Services/profile.dart';
import 'dart:ui';

class TagFilterEntry {
  const TagFilterEntry(this.tag);
  final String tag;
}

class FullPostcard extends StatelessWidget {
  final PostcardInfo _postcardInfo;
  FullPostcard(this._postcardInfo);

  final List<TagFilterEntry> _tags = <TagFilterEntry>[
    const TagFilterEntry('Colorful'),
    const TagFilterEntry('Classic Cars'),
    const TagFilterEntry('Beautiful Sunsets'),
    const TagFilterEntry('Birthright Adventures'),
    const TagFilterEntry('Urban Artistry'),
  ];

  Iterable<Widget> get tagWidgets sync* {
    bool filled = true;
    for (TagFilterEntry tag in _tags) {
      filled = !filled;
      if (filled) {
        yield Chip(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(500),
              side: BorderSide(color: EmbarkRed100)),
          backgroundColor: Colors.white,
          label: Text(tag.tag),
          labelStyle: TextStyle(
            fontFamily: _postcardInfo.theme.fontFamily(),
            fontWeight: FontWeight.w100,
            color: EmbarkRed100,
            fontSize: 10,
          ),
        );
      } else {
        yield Chip(
          backgroundColor: EmbarkRed100,
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
        Image.network(_postcardInfo.photoUrl),
        Positioned(
            bottom: size.height * 0.085,
            width: size.width,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Container(
                                height: 45,
                                margin: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 15),
                                decoration: BoxDecoration(
                                    color: EmbarkGray,
                                    boxShadow: [
                                      new BoxShadow(
                                          color: Colors.black26,
                                          offset: new Offset(2.0, 2.0),
                                          blurRadius: 5.0,
                                          spreadRadius: 3)
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
                                    color: EmbarkRed100,
                                    fontWeight: FontWeight.bold,
                                    fontFamily:
                                        _postcardInfo.theme.fontFamily())),
                            Row(
                              children: <Widget>[
                                Icon(
                                  Icons.location_on,
                                  color: Colors.grey,
                                  size: 12,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                  child: Text(_postcardInfo.location,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w200,
                                          fontFamily: _postcardInfo.theme
                                              .fontFamily())),
                                ),
                                Icon(
                                  Icons.access_time,
                                  color: Colors.grey,
                                  size: 12,
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                                  child: Text("2 hours ago",
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12,
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
                            "Walking off the delicious meal from Ceranno Negro with Belle. Taking pictures at ancient spanish churches with Ben Stein and Max Zavidow.",
                            style: TextStyle(
                                fontSize: 11,
                                color: EmbarkAlmostBlack,
                                height: 1.5,
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
                            color: EmbarkRed100,
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
                            borderSide: BorderSide(color: EmbarkRed100),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            textColor: EmbarkRed100,
                            icon: Icon(
                              Icons.share,
                              color: EmbarkRed100,
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
