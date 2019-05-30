import 'package:flutter/material.dart';
import 'package:embark/Components/FancyTabBar.dart';
import 'package:embark/Components/ScrapbookPostcard.dart';
import 'package:embark/Components/FullPostCard.dart';
import 'package:embark/Services/profile.dart';
import 'package:embark/Components/EmbarkAppBar.dart';
import 'package:embark/Styles/Colors.dart';

class PostCardPage extends StatefulWidget {
  //Set Using Themes
  PostCardPage();
  @override
  __PostCardPageState createState() => __PostCardPageState();
}

class __PostCardPageState extends State<PostCardPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(children: <Widget>[
          Container(child: FullPostCard(profile.myPostcards[0])),

          //Bottom Nav Bar
          Align(alignment: Alignment.bottomCenter, child: FancyTabBar()),
          //Add FAB
          Align(
              alignment: Alignment.topRight,
              child: Container(
                  margin: EdgeInsets.only(right: 25.0, top: 25),
                  child: FloatingActionButton(
                    backgroundColor: EmbarkGray,
                    onPressed: () {},
                    child: Icon(Icons.location_on, color: EmbarkAlmostBlack),
                  ))),
        ]));
  }
}
