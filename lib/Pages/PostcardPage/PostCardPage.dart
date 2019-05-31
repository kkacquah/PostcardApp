import 'package:flutter/material.dart';
import 'package:embark/Components/FancyTabBar.dart';
import 'package:embark/Components/ScrapbookPostcard.dart';
import 'package:embark/Components/FullPostcard.dart';
import 'package:embark/Services/profile.dart';
import 'package:embark/Components/EmbarkAppBar.dart';
import 'package:embark/Styles/Colors.dart';

class PostcardPage extends StatefulWidget {
  //Set Using Themes
  PostcardPage();
  @override
  __PostcardPageState createState() => __PostcardPageState();
}

class __PostcardPageState extends State<PostcardPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(children: <Widget>[
          Container(child: FullPostcard(profile.myPostcards[0])),

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
