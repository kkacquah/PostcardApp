import 'package:flutter/material.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:embark/Pages/PostcardPage/MyPostcardsPage.dart';
import 'dart:io' show Platform;

class EmbarkBackButton extends StatelessWidget with PreferredSizeWidget {
  //TODO ALLOW changing of fontsize
  Icon _icon;

  EmbarkBackButton(BuildContext context) {
    _icon = Icon(
      _getIconData(Theme.of(context).platform),
      color: EmbarkGray,
      size: 24.0,
    );
  }

  static IconData _getIconData(TargetPlatform platform) {
    switch (platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return Icons.arrow_back;
      case TargetPlatform.iOS:
        return Icons.arrow_back_ios;
    }
    assert(false);
    return null;
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Material(color:Colors.transparent, elevation: 16,child:Container(
              height: size.height / 10,
              width: 60,
              child: FlatButton(
                  child: Container( padding: EdgeInsets.only(bottom: 15),child:Align(child: _icon, alignment: Alignment.bottomLeft)),
                  onPressed: () {Navigator.pop(
                    context,
                    MaterialPageRoute(builder: (context) => MyPostcardsPage()),
                  );},
                  color: EmbarkAlmostBlack,
                  shape: new RoundedRectangleBorder(
                    borderRadius:
                        new BorderRadius.only(bottomRight: Radius.circular(25)),
                  ))));
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
