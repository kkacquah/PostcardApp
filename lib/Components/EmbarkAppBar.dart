import 'package:embark/Styles/Colors.dart';
import 'package:flutter/material.dart';
import 'package:embark/services/authentication.dart';

class EmbarkAppBar extends StatelessWidget with PreferredSizeWidget {
  Size _size;
  String _photoUrl;
  EmbarkAppBar(this._photoUrl);

  Widget build(BuildContext context) {
    //container wrapps whole screen
    return SliverAppBar(
      backgroundColor: EmbarkAlmostBlack,
      title: Text('Embark',
          style: TextStyle(
              fontFamily: "PlayfairDisplay", fontWeight: FontWeight.w700, fontSize: 30)),
      actions: <Widget>[
        Container(
            margin:EdgeInsets.symmetric(vertical: 7, horizontal: 15),
            decoration: BoxDecoration(
                color: EmbarkGray,
                shape: BoxShape.circle, border: Border.all(color: EmbarkGray)),
            child: ClipOval(child:Image.network(_photoUrl)))
      ],
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
