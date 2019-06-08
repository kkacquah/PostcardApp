import 'package:flutter/material.dart';
import 'package:embark/Services/PostcardInfo.dart';
import 'package:embark/Components/EmbarkAppBar.dart';
import 'package:embark/Components/EmbarkBackButton.dart';
import 'package:embark/Services/profile.dart';
import 'package:embark/Components/FullPostcard.dart';
import 'PostcardMap.dart';
import 'package:embark/Styles/Colors.dart';

import 'dart:ui';

class FullPostcardPage extends StatefulWidget {
  PostcardInfo _postcardInfo;
  Size _size;

  //TODO ALLOW changing of fontsize
  FullPostcardPage(this._postcardInfo);

  @override
  _FullPostcardPageState createState() => _FullPostcardPageState();
}

class _FullPostcardPageState extends State<FullPostcardPage>
    with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> _fadeOutAnimation;

  bool _photoState = false;
  Animation<Offset> offset;

  _FullPostcardPageState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _fadeOutAnimation = Tween<double>(begin: 0.0, end: 1.0)
        .animate(controller);
    offset = Tween<Offset>(end: Offset.zero, begin: Offset(1.0,0.0))
        .animate(controller);
  }

  IconData _getIcon() {
    if (_photoState) {
      return Icons.location_on;
    } else {
      return Icons.photo;
    }
  }

  double _getIconOpacity() {
    if (_photoState) {
      return 1.0;
    } else {
      return 0.0;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  //Image and Map
  Widget _getBackground(Size size) {
      return Stack(children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: new NetworkImage(widget._postcardInfo.photoUrl),
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
            margin: EdgeInsets.only(bottom: size.height * (1 / 4)),
            child: ClipRect(
                clipper: CustomRect(),
                child: Image.network(widget._postcardInfo.photoUrl,
                    fit: BoxFit.fitWidth))),
        SlideTransition(
            position: offset,
            child: Container(child: PostcardMap(widget._postcardInfo.geopoint,widget._postcardInfo.theme.hue)))
      ]);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    MediaQuery.of(context);
    double postcardWidth = 0.45 * size.width;

    //container wraps whole screen
    return Scaffold(
      appBar: EmbarkPostCardAppBar(profile.user.photoUrl),
      body: Stack(children: <Widget>[
        this._getBackground(size),
        //postcard info
        FullPostcard(widget._postcardInfo, this._photoState),
        //FAB
        Align(
          alignment: Alignment.topRight,
          child: Container(
              margin: EdgeInsets.only(right: 10, top: 10),
              child: FloatingActionButton(
                  elevation: 6,
                  backgroundColor: EmbarkExtraLightGray,
                  onPressed: () {
                    switch (controller.status) {
                      case AnimationStatus.completed:
                        controller.reverse();
                        break;
                      case AnimationStatus.dismissed:
                        controller.forward();
                        break;
                      default:
                    }
                  },

                  child: Stack(children: [
                    Icon(Icons.location_on, color: EmbarkAlmostBlack),
                    FadeTransition(
                        opacity: this._fadeOutAnimation,
                        child: Container(
                            child: Icon(Icons.photo,
                                color: EmbarkAlmostBlack),
                            decoration: BoxDecoration(
                                shape: BoxShape.circle, color: EmbarkExtraLightGray)))
                  ]))),
        )
      ]),
    );
  }
}
