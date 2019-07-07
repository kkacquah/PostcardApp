import 'package:embark/Styles/Colors.dart';
import 'package:flutter/material.dart';


class EditScrapbookAppBar  extends StatefulWidget with PreferredSizeWidget {
  //Set Using Themes
  EditScrapbookAppBar();

  @override
  _EditScrapbookAppBarState createState() =>
      _EditScrapbookAppBarState();

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
    return AppBar(
        backgroundColor: EmbarkExtraLightGray,
        actions: <Widget>[
          Container(
              child:IconButton(
                  icon:Icon(Icons.more_horiz, color: EmbarkAlmostBlack,size: 36)
              ),
              padding:EdgeInsets.only(right:15))
        ]);
  }
}