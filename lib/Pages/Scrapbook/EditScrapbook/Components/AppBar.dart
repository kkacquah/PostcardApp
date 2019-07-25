import 'package:embark/Styles/Colors.dart';
import 'package:flutter/material.dart';


class EditScrapbookAppBar extends StatefulWidget with PreferredSizeWidget {
  //Set Using Themes
  EditScrapbookAppBar();

  @override
  _EditScrapbookAppBarState createState() => _EditScrapbookAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(50);
}

class _EditScrapbookAppBarState extends State<EditScrapbookAppBar>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget build(BuildContext context) {
    //container wraps whole screen
    return PreferredSize(
      preferredSize: Size.fromHeight(50),
    child:AppBar(actions: <Widget>[
      Container(
          padding: EdgeInsets.only(right: 15),
          child: IconButton(
              icon: Icon(
            Icons.more_horiz,
            size: 36,
            color: EmbarkColors.black,
          )))
    ]));
  }
}
