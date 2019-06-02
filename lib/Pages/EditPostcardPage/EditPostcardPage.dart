import 'package:flutter/material.dart';
import 'package:embark/Components/FancyTabBar.dart';
import 'package:embark/Services/PostcardInfo.dart';
import 'package:embark/Components/EditCard.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:embark/Styles/Themes.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:embark/Services/profile.dart';
import 'dart:ui';

class EditPostcardPage extends StatelessWidget {
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: new NetworkImage(
                          "https://wallpaperplay.com/walls/full/6/0/d/108080.jpg"),
                    ),
                  ),
                  child: new BackdropFilter(
                    filter: new ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
                    child: new Container(
                      decoration: new BoxDecoration(
                          color: Colors.white.withOpacity(0.0)),
                    ),
                  ),
                ),
                Image.network(
                    "https://wallpaperplay.com/walls/full/6/0/d/108080.jpg"),
                EditCard(),
              ],
            ),
            //Bottom Nav Bar
            Align(alignment: Alignment.bottomCenter, child: FancyTabBar()),
          ],
        ));
  }
}
