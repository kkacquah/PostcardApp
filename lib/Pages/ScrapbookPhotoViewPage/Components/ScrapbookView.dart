import 'package:flutter/material.dart';
import 'package:embark/Services/ScrapbookInfo.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:embark/Styles/Colors.dart';
import 'dart:ui';

class ScrapbookPostcard extends StatelessWidget {
  PostcardInfo _postcardInfo;
  Size _size;

  //TODO ALLOW changing of fontsize
  ScrapbookPostcard(this._postcardInfo);

  void _openPostcard(BuildContext context) async {
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double postcardWidth = 0.45 * size.width;

    //container wraps whole screen
    return GestureDetector(
        onTap: () => this._openPostcard(context),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 2.0,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                    height: postcardWidth * _postcardInfo.aspectRatio,
                    width: postcardWidth,
                    child: Stack(children: <Widget>[
                      Container(color: _postcardInfo.theme.secondary),
                      Hero(
                          tag: _postcardInfo.photoUrl ,
                          child: FadeInImage.memoryNetwork(
                              fit: BoxFit.cover,
                              placeholder: kTransparentImage,
                              image: _postcardInfo.photoUrl)),
                      BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 0.7, sigmaY: 0.7),
                        child: Container(
                          decoration: new BoxDecoration(
                              gradient: _postcardInfo.theme.postcardGradient()),
                        ),
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Container(
                              padding: EdgeInsets.all(10),
                              child: Text(_postcardInfo.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: EmbarkExtraLightGray,
                                    fontFamily: _postcardInfo.fontFamily,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w700,
                                  )))),
                    ])))));
  }
}
