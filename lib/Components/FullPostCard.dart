import 'package:flutter/material.dart';
import 'package:embark/Services/PostcardInfo.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:embark/Styles/Themes.dart';
import 'package:embark/Styles/Colors.dart';
import 'dart:ui';

class FullPostCard extends StatelessWidget {
  PostcardInfo _postcardInfo;

  FullPostCard(this._postcardInfo);

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double imageWidth = size.width;
    //container wrapps whole screen
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              fit: BoxFit.fitWidth,
              image: new NetworkImage(_postcardInfo.photoUrl),
            ),
          ),
        ),
        Container(
            height: size.height,
            width: size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                gradient: LinearGradient(
                  // Where the linear gradient begins and ends
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  // Add one stop for each color. Stops should increase from 0 to 1
                  colors: [
                    Color(0xFFFFFFFF),
                    Color(0x00FFFFFF),
                  ],
                  stops: [0.2, 0.6],
                ))),
        Positioned(
            bottom: size.height * 0.14,
            height: size.height * 0.31,
            left: size.width * 0.05,
            right: size.width * 0.05,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(_postcardInfo.title,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 24,
                          color: EmbarkRed100,
                          fontWeight: FontWeight.bold,
                          fontFamily: _postcardInfo.theme.fontFamily())),
                  Text(_postcardInfo.location,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 15,
                          color: EmbarkAlmostBlack,
                          fontWeight: FontWeight.bold,
                          fontFamily: _postcardInfo.theme.fontFamily())),
                  Text(
                      "Walking off the delicious meal from Ceranno Negro with Belle. Taking pictures at ancient spanish churches ",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 11,
                          color: EmbarkAlmostBlack,
                          fontWeight: FontWeight.w100,
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                          fontFamily: _postcardInfo.theme.fontFamily())),
                  Chip(
                    backgroundColor: EmbarkRed100,
                    labelPadding: EdgeInsets.all(5),
                    label: Text("Birthright", textAlign: TextAlign.left),
                    labelStyle: TextStyle(
                        fontFamily: _postcardInfo.theme.fontFamily(),
                        fontWeight: FontWeight.w100,
                        color: Colors.white),
                  ),
                ],
              ),
            ))
      ],
    );
  }
}
