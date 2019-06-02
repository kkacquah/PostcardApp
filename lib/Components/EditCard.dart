import 'package:flutter/material.dart';
import 'package:embark/Services/PostcardInfo.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/widgets.dart' as prefix0;
import 'package:transparent_image/transparent_image.dart';
import 'package:embark/Styles/Themes.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:embark/Services/profile.dart';
import 'dart:ui';

final TextStyle titleStyle = TextStyle(
  color: EmbarkRed100,
  fontSize: 26,
  fontWeight: FontWeight.bold,
);

final TextStyle titleHintStyle = TextStyle(
  color: EmbarkRed100.withOpacity(0.5),
  fontSize: 26,
  fontWeight: FontWeight.bold,
);

class EditCard extends StatelessWidget {
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Positioned(
        bottom: size.height * 0.085,
        width: size.width,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: size.width * 0.7,
                      child: TextFormField(
                          maxLines: 1,
                          style: titleStyle,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Title',
                            hintStyle: titleHintStyle,
                          )),
                    ),
                    IconButton(
                        color: Colors.green[600],
                        onPressed: () {},
                        icon: Icon(
                          Icons.check_circle_outline,
                        )),
                  ],
                ),
                TextFormField(
                  maxLength: 150,
                  maxLines: 4,
                  maxLengthEnforced: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Share what you did...'),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Align(
                    child: Wrap(
                      spacing: 12,
                      children: <Widget>[
                        ButtonTheme(
                          minWidth: 150,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: OutlineButton.icon(
                            onPressed: () {},
                            borderSide: BorderSide(color: EmbarkRed100),
                            textColor: EmbarkRed100,
                            icon: Icon(
                              Icons.add_location,
                              color: EmbarkRed100,
                              size: 24,
                            ),
                            label: Text('Add Location'),
                          ),
                        ),
                        ButtonTheme(
                          minWidth: 150,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: FlatButton.icon(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            textColor: Colors.white,
                            color: EmbarkRed100,
                            icon: Icon(
                              Icons.access_time,
                              color: Colors.white,
                              size: 24,
                            ),
                            label: Text('Timestamp'),
                          ),
                        ),
                        ButtonTheme(
                          minWidth: 150,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: FlatButton.icon(
                            onPressed: () {},
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            textColor: Colors.white,
                            color: EmbarkRed100,
                            icon: Icon(
                              Icons.sentiment_very_satisfied,
                              color: Colors.white,
                              size: 24,
                            ),
                            label: Text('Sentiments'),
                          ),
                        ),
                        ButtonTheme(
                          minWidth: 150,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: OutlineButton.icon(
                            onPressed: () {},
                            borderSide: BorderSide(color: EmbarkRed100),
                            textColor: EmbarkRed100,
                            icon: Icon(
                              Icons.group_add,
                              color: EmbarkRed100,
                              size: 24,
                            ),
                            label: Text('Tag Friends'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
