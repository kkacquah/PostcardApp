import 'package:flutter/material.dart';
import 'package:embark/Components/FancyTabBar.dart';
import 'package:embark/Components/ScrapbookPostcard.dart';
import 'package:embark/Services/profile.dart';
<<<<<<< HEAD
import 'package:embark/Components/EmbarkAppBar.dart';
=======
import 'package:embark/Services/PostcardInfo.dart';
import 'package:embark/Pages/EditPage/EditPage.dart';
import 'package:embark/Components/EmbarkAppBar.dart';
import 'package:embark/Components/FullPostcard.dart';
>>>>>>> c61d9e111f67ca40237d9a670fdcbbec38c1bed1
import 'package:embark/Styles/Colors.dart';

class MyPostcardsPage extends StatefulWidget {
  //Set Using Themes
  MyPostcardsPage();
<<<<<<< HEAD
=======

>>>>>>> c61d9e111f67ca40237d9a670fdcbbec38c1bed1
  @override
  __MyPostcardsPageState createState() => __MyPostcardsPageState();
}

class __MyPostcardsPageState extends State<MyPostcardsPage> {
<<<<<<< HEAD

=======
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
  void _goToAddPage(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditPostcardPage()),
    );
  }
>>>>>>> c61d9e111f67ca40237d9a670fdcbbec38c1bed1
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
<<<<<<< HEAD
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
=======
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
                      EmbarkExtraLightGray,
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
                      margin: EdgeInsets.only(right: 10, top: 10),
                      child: FloatingActionButton(
                        elevation: 6,
                        backgroundColor: EmbarkExtraLightGray,
                        onPressed: () => _goToAddPage(context),
                        child: Icon(Icons.add, color: EmbarkAlmostBlack),
                      ))),
            ])));
>>>>>>> c61d9e111f67ca40237d9a670fdcbbec38c1bed1
  }
}
