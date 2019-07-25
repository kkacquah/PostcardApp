import 'package:embark/Styles/Colors.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class ScrapbookPhotoViewAppbar extends StatefulWidget with PreferredSizeWidget {
  //Set Using Themes
  ScrapbookPhotoViewAppbar();

  @override
  _ScrapbookPhotoViewAppbarState createState() =>
      _ScrapbookPhotoViewAppbarState();

  @override
  Size get preferredSize => Size.fromHeight(50);
}

class _ScrapbookPhotoViewAppbarState extends State<ScrapbookPhotoViewAppbar>
    with TickerProviderStateMixin {
  double MAP_SELECTED_WIDTH = 65;
  double PHOTOS_SELECTED_WIDTH = 105;
  double UNDERLINE_HEIGHT = 3;
  bool _photoSelected = false;
  Animation<Offset> _underlineOffset;
  AnimationController _underlineOffsetController;

  @override
  void initState() {
    super.initState();
    _underlineOffsetController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _underlineOffset = Tween<Offset>(begin: Offset.zero, end: Offset(0.725, 0.0))
        .animate(_underlineOffsetController);

  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    //container wraps whole screen
    return PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBar(
            backgroundColor: EmbarkColors.extraLightGray,
            elevation: 0,
            titleSpacing: 0,
            flexibleSpace: Container(
                margin: EdgeInsets.only(top: 25, left: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                padding: EdgeInsets.only(right: 5),
                                child: InkWell(
                                    onTap: () {
                                      if (_underlineOffsetController
                                          .isCompleted) {
                                        _underlineOffsetController.reverse();
                                        this.setState(() {
                                          _photoSelected = !_photoSelected;
                                        });
                                      }
                                    },
                                    child: Text(
                                      "Map",
                                      style: TextStyle(
                                          fontFamily: "OpenSans",
                                          fontSize: 26,
                                          fontWeight: FontWeight.w700,
                                          color: _photoSelected
                                              ? EmbarkColors.mediumGray
                                              : EmbarkColors.black),
                                    ))),
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: InkWell(

                                    onTap: () {
                                      if (!_underlineOffsetController
                                          .isCompleted) {
                                        _underlineOffsetController.forward();
                                        this.setState(() {
                                          _photoSelected = !_photoSelected;
                                        });
                                      }
                                    },
                                    child: Text(
                                      "Photos",
                                      style: TextStyle(
                                          fontFamily: "OpenSans",
                                          fontSize: 26,
                                          fontWeight: FontWeight.w700,
                                          color: !_photoSelected
                                              ? EmbarkColors.mediumGray
                                              : EmbarkColors.black),
                                    )))
                          ]),
                      Flexible(
                          fit: FlexFit.loose,
                          child: SlideTransition(
                              position: this._underlineOffset,
                              child: AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  color: EmbarkColors.black,
                                  height: UNDERLINE_HEIGHT,
                                  width: _photoSelected
                                      ? PHOTOS_SELECTED_WIDTH
                                      : MAP_SELECTED_WIDTH))),

                    ])),
        actions: <Widget>[
          Container(
            child:IconButton(
              icon:Icon(Icons.more_horiz, color: EmbarkColors.black,size: 36)
            ),
          padding:EdgeInsets.only(right:15))
        ]));
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
