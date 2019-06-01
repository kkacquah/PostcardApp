import 'package:flutter/material.dart';
import 'package:embark/Services/PostcardInfo.dart';
import 'package:embark/Components/FancyTabBar.dart';
import 'package:embark/Components/EmbarkBackButton.dart';
import 'package:embark/Components/FullPostcard.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:embark/Styles/Colors.dart';

import 'dart:ui';

class FullPostcardPage extends StatelessWidget {
  PostcardInfo _postcardInfo;
  Size _size;

  //TODO ALLOW changing of fontsize
  FullPostcardPage(this._postcardInfo);


  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MediaQuery.of(context);
    double postcardWidth = 0.45 * size.width;


    //container wraps whole screen
    return Scaffold(
      body: Stack(children: <Widget>[
        FullPostcard(this._postcardInfo),
        EmbarkBackButton(context),
        Align(
            alignment: Alignment.topRight,
            child: Container(
                margin: EdgeInsets.only(right: 25.0, top: 35),
                child: FloatingActionButton(
                  elevation: 6,
                  backgroundColor: EmbarkGray,
                  onPressed: () {},
                  child: Icon(Icons.location_on, color: EmbarkAlmostBlack),
                ))),
        Align(alignment: Alignment.bottomCenter, child: FancyTabBar()),
      ]),
    );
  }
}
