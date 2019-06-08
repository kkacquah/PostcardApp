import 'package:embark/Styles/Colors.dart';
import 'package:flutter/material.dart';
import 'package:embark/services/authentication.dart';

class EmbarkAppBar extends StatelessWidget with PreferredSizeWidget {
  String _photoUrl;

  EmbarkAppBar(this._photoUrl);

  Widget build(BuildContext context) {
    //container wrapps whole screen
    return SliverAppBar(
      backgroundColor: EmbarkAlmostBlack,
      title: Text('Embark',
          style: TextStyle(
              fontFamily: "PlayfairDisplay",
              fontWeight: FontWeight.w700,
              fontSize: 30)),
      actions: <Widget>[
        Container(
            margin: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
            decoration: BoxDecoration(
                color: EmbarkExtraLightGray,
                shape: BoxShape.circle,
                border: Border.all(color: EmbarkExtraLightGray)),
            child: ClipOval(child: Image.network(_photoUrl)))
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

//TODO import profile since all of these need it
class EmbarkPostCardAppBar extends StatelessWidget with PreferredSizeWidget {
  String _photoUrl;

  EmbarkPostCardAppBar(this._photoUrl);

  Widget build(BuildContext context) {
    //container wrapps whole screen
    return AppBar(
      backgroundColor: EmbarkAlmostBlack,
      actions: <Widget>[
        Container(
          margin: EdgeInsets.only(right:10),
        child:IconButton(
            icon: Icon(Icons.favorite_border,
                color: EmbarkAlmostWhite, size: 22))),
    Container(
    margin: EdgeInsets.only(right:10),
        child:
        IconButton(
          icon: Icon(Icons.share, color: EmbarkAlmostWhite, size: 22),
        )),
        Container(
            margin: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
            decoration: BoxDecoration(
                color: EmbarkExtraLightGray,
                shape: BoxShape.circle,
                border: Border.all(color: EmbarkExtraLightGray)),
            child: ClipOval(child: Image.network(_photoUrl)))
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class EmbarkEditCardAppBar extends StatelessWidget with PreferredSizeWidget {
  String _photoUrl;

  EmbarkEditCardAppBar(this._photoUrl);

  Widget build(BuildContext context) {
    //container wrapps whole screen
    return AppBar(
        backgroundColor: EmbarkAlmostBlack,
        actions: <Widget>[Container(
          padding: EdgeInsets.all(10),
          child:
          MaterialButton(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(3   ),
              ),
              onPressed: () {},
              splashColor: EmbarkLightGray,
              child:  Text("Post",
                    style: TextStyle(fontSize: 20, fontFamily: "OpenSans", fontWeight: FontWeight.w600, color: EmbarkAlmostBlack),),
              color: EmbarkExtraLightGray)),
          Container(
              margin: EdgeInsets.symmetric(vertical: 7, horizontal: 15),
              decoration: BoxDecoration(
                  color: EmbarkExtraLightGray,
                  shape: BoxShape.circle,
                  border: Border.all(color: EmbarkExtraLightGray)),
              child: ClipOval(child: Image.network(_photoUrl)))
    ]);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
