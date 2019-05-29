import 'package:flutter/material.dart';
import 'package:embark/Components/FancyTabBar.dart';
import 'package:embark/Components/ScrapbookPostcard.dart';
import 'package:embark/Services/profile.dart';
import 'package:embark/Components/EmbarkAppBar.dart';
import 'package:embark/Styles/Colors.dart';

class MyPostcardsPage extends StatefulWidget {
  //Set Using Themes
  MyPostcardsPage();
  @override
  __MyPostcardsPageState createState() => __MyPostcardsPageState();
}

class __MyPostcardsPageState extends State<MyPostcardsPage> {

  @override
  Widget build(BuildContext context) {
    print(profile.myPostcards[0]);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar:EmbarkAppBar(profile.user.photoUrl),
        resizeToAvoidBottomPadding: false,
        body: Stack(children: <Widget>[
          Container(
              height: size.height,
              width: size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                // Where the linear gradient begins and ends
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                // Add one stop for each color. Stops should increase from 0 to 1
                stops: [0.8, 1.0],
                colors: [
                  // Colors are easy thanks to Flutter's Colors class.
                  EmbarkGray,
                  Color(0xFFD8D8D8),

                  //transparent white
                ],
              ))),
          Container(child:ScrapbookPostcard(profile.myPostcards[0])),
          //Bottom Nav Bar
          Align(alignment: Alignment.bottomCenter, child: FancyTabBar()),
          //Add FAB
          Align(
              alignment: Alignment.topRight,
              child: Container(
                  margin: EdgeInsets.only(right:25.0, top: 25),
                  child: FloatingActionButton(
                    backgroundColor: EmbarkGray,
                    onPressed: () {},
                    child: Icon(Icons.add,color:EmbarkAlmostBlack),
                  ))),
        ]));
  }
}
