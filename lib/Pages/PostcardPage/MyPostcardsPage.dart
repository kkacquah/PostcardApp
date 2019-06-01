import 'package:flutter/material.dart';
import 'package:embark/Components/FancyTabBar.dart';
import 'package:embark/Components/ScrapbookPostcard.dart';
import 'package:embark/Services/profile.dart';
import 'package:embark/Services/PostcardInfo.dart';
import 'package:embark/Components/EmbarkAppBar.dart';
import 'package:embark/Components/FullPostcard.dart';
import 'package:embark/Styles/Colors.dart';

class MyPostcardsPage extends StatefulWidget {
  //Set Using Themes
  MyPostcardsPage();

  @override
  __MyPostcardsPageState createState() => __MyPostcardsPageState();
}

class __MyPostcardsPageState extends State<MyPostcardsPage> {
  Widget _getPostcardColumns() {
    if (profile.myPostcards.length == 0) {
      return Align(alignment: Alignment.center,child:Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text("Click the '+' sign above and start scrapbooking",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "OpenSans",
                  color: Colors.black38,
                  fontSize: 26,
              ))));
    } else {
      List<PostcardInfo> oddPostcards = List<PostcardInfo>();
      List<PostcardInfo> evenPostcards = List<PostcardInfo>();
      Widget oddColumn;
      Widget evenColumn;
      for (int i = 0; i < profile.myPostcards.length; i = i + 2) {
        evenPostcards.add(profile.myPostcards[i]);
        //DELETE Later Adds extra postcards
      }
      for (int i = 1; i < profile.myPostcards.length; i = i + 2) {
        oddPostcards.add(profile.myPostcards[i]);
        //DELETE Later Adds extra postcards
      }
      List<Widget> oddColumnWidgets =
          List<Widget>.from(oddPostcards.map((value) {
        return ScrapbookPostcard(value);
      }).toList());

      oddColumnWidgets.add(Container(child: Container(height: 200)));
      List<Widget> evenColumnWidgets =
          List<Widget>.from(evenPostcards.map((value) {
        return ScrapbookPostcard(value);
      }).toList());

      oddColumn = Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: oddColumnWidgets);
      evenColumn = Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: evenColumnWidgets);
      return SingleChildScrollView(
          child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[oddColumn, evenColumn]));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[EmbarkAppBar(profile.user.photoUrl)];
            },
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
              Container(
                margin: EdgeInsets.only(bottom:70),
                  height: double.infinity, child: this._getPostcardColumns()),
              //Bottom Nav Bar
              Align(alignment: Alignment.bottomCenter, child: FancyTabBar()),
              //Add FAB
              Align(
                  alignment: Alignment.topRight,
                  child: Container(
                      margin: EdgeInsets.only(right: 25.0, top: 35),
                      child: FloatingActionButton(
                        elevation: 6,
                        backgroundColor: EmbarkGray,
                        onPressed: () {},
                        child: Icon(Icons.add, color: EmbarkAlmostBlack),
                      ))),
            ])));
  }
}
