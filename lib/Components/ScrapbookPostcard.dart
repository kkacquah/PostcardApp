import 'package:flutter/material.dart';
import 'package:embark/Services/PostcardInfo.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:embark/Styles/Themes.dart';
import 'dart:ui';

class ScrapbookPostcard extends StatelessWidget {
  PostcardInfo _postcardInfo;
  Size _size;

  //TODO ALLOW changing of fontsize
  ScrapbookPostcard(this._postcardInfo);

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double postcardWidth = 0.45 * size.width;
    //container wrapps whole screen
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        elevation: 2.0,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child:
            Container(
              height: postcardWidth * _postcardInfo.aspectRatio,
                width: postcardWidth,
            child:Stack(children: <Widget>[

                FadeInImage.memoryNetwork(
                    fit: BoxFit.cover,
                    placeholder: kTransparentImage,
                    image: _postcardInfo.photoUrl
              ),
              BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 0.7, sigmaY: 0.7),
                  child:  Container(
                    decoration:
                        new BoxDecoration(),
                  ))
            ]))));
  }
}
