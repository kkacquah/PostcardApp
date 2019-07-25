//import 'package:embark/Pages/Scrapbook/EditScrapbook/EditScrapbookCover/EditScrapbookCover.dart';
//import 'package:flutter/material.dart';
//import 'package:embark/Pages/ScrapbookPhotoViewPage/Components/AppBar.dart';
//import 'package:embark/Pages/ScrapbookPhotoViewPage/Components/ScrapbookView.dart';
//import 'package:embark/Pages/ScrapbookPhotoViewPage/Components/SearchBar.dart';
//import 'package:embark/Services/Profile.dart';
//import 'package:embark/Services/ScrapbookInfo.dart';
//import 'package:embark/Styles/Colors.dart';
//
//class ScrapbookPhotoViewPage extends StatefulWidget {
//  //Set Using Themes
//  ScrapbookPhotoViewPage();
//
//  @override
//  __ScrapbookPhotoViewPageState createState() =>
//      __ScrapbookPhotoViewPageState();
//}
//
//class __ScrapbookPhotoViewPageState extends State<ScrapbookPhotoViewPage> {
//
//  bool _selected;
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//    _selected = false;
//  }
//  void _onSelectSearchBar(){
//    setState(() {
//      _selected = true;
//    });
//  }
//  void _onCompleteSearchBar(){
//    _selected = false;
//  }
//  Widget _getPostcardColumns() {
//    if (profile.myPostcards == null) {
//      return Align(
//          alignment: Alignment.center,
//          child: Padding(
//              padding: EdgeInsets.symmetric(horizontal: 20),
//              child: Text("Click the '+' sign above and start scrapbooking",
//                  textAlign: TextAlign.center,
//                  style: TextStyle(
//                    fontFamily: "OpenSans",
//                    color: Colors.black38,
//                    fontSize: 26,
//                  ))));
//    } else {
//      List<PostcardInfo> oddPostcards = List<PostcardInfo>();
//      List<PostcardInfo> evenPostcards = List<PostcardInfo>();
//      Widget oddColumn;
//      Widget evenColumn;
//      for (int i = 0; i < profile.myPostcards.length; i = i + 2) {
//        evenPostcards.add(profile.myPostcards[i]);
//        //DELETE Later Adds extra postcards
//      }
//      for (int i = 1; i < profile.myPostcards.length; i = i + 2) {
//        oddPostcards.add(profile.myPostcards[i]);
//        //DELETE Later Adds extra postcards
//      }
//      List<Widget> oddColumnWidgets =
//          List<Widget>.from(oddPostcards.map((value) {
//        return ScrapbookPostcard(value);
//      }).toList());
//
//      oddColumnWidgets.add(Container(child: Container(height: 200)));
//      List<Widget> evenColumnWidgets =
//          List<Widget>.from(evenPostcards.map((value) {
//        return ScrapbookPostcard(value);
//      }).toList());
//
//      oddColumn = Column(
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: oddColumnWidgets);
//      evenColumn = Column(
//          mainAxisAlignment: MainAxisAlignment.start,
//          children: evenColumnWidgets);
//      return SingleChildScrollView(
//          child: Row(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              mainAxisAlignment: MainAxisAlignment.center,
//              children: <Widget>[oddColumn, evenColumn]));
//    }
//  }
//
//  void _goToAddPage(BuildContext context) async {
//    Navigator.push(
//      context,
//      MaterialPageRoute(builder: (context) => AddScrapbookCover()),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    Size size = MediaQuery.of(context).size;
//    return Scaffold(
//        appBar: _selected ?  null : ScrapbookPhotoViewAppbar(),
//        resizeToAvoidBottomPadding: false,
//        body: AnimatedContainer(duration: Duration(milliseconds: 100), child:NestedScrollView(
//            headerSliverBuilder:
//                (BuildContext context, bool innerBoxIsScrolled) {
//              return <Widget>[
//                PreferredSize(
//                    preferredSize: Size.fromHeight(70),
//                    child:
//                SliverAppBar(
//                  //TODO: Add IOS functionality as well
//                    automaticallyImplyLeading: false,
//                    backgroundColor: EmbarkColors.extraLightGray,
//                    flexibleSpace: ScrapbookPhotoViewSearchBar(this._onSelectSearchBar,this._onCompleteSearchBar)))
//              ];
//            },
//            body: Stack(children: <Widget>[
//              Container(
//                  height: size.height,
//                  width: size.width,
//                  decoration: BoxDecoration(
//                      gradient: LinearGradient(
//                    // Where the linear gradient begins and ends
//                    begin: Alignment.bottomCenter,
//                    end: Alignment.topCenter,
//                    // Add one stop for each color. Stops should increase from 0 to 1
//                    stops: [0.8, 1.0],
//                    colors: [
//                      // Colors are easy thanks to Flutter's Colors class.
//                      EmbarkColors.white,
//                      EmbarkColors.extraLightGray,
//
//                      //transparent white
//                    ],
//                  ))),
//              Container(
//                  padding: EdgeInsets.only(top: 10),
//                  height: double.infinity, child: this._getPostcardColumns()),
//              //Add FAB
//              Align(
//                  alignment: Alignment.bottomRight,
//                  child: Container(
//                      margin: EdgeInsets.only(right: 25, bottom: 25),
//                      child: FloatingActionButton(
//                        elevation: 6,
//                        backgroundColor: EmbarkColors.extraLightGray,
//                        onPressed: () => _goToAddPage(context),
//                        child: Icon(Icons.add, color: EmbarkColors.black),
//                      ))),
//            ]))));
//  }
//}
