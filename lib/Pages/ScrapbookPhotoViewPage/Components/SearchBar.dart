//import 'package:flutter/material.dart';
//import 'package:embark/Pages/ScrapbookPhotoViewPage/Components/AppBar.dart';
//import 'package:embark/Pages/ScrapbookPhotoViewPage/Components/ScrapbookView.dart';
//import 'package:embark/Services/Profile.dart';
//import 'package:embark/Services/ScrapbookInfo.dart';
//import 'package:embark/Styles/Colors.dart';
//
//class ScrapbookPhotoViewSearchBar extends StatefulWidget {
//
//  Function onSelected;
//  Function onCompleted;
//
//  //Set Using Themes
//  ScrapbookPhotoViewSearchBar(this.onSelected, this.onCompleted);
//
//  @override
//  _ScrapbookPhotoViewSearchBarState createState() =>
//      _ScrapbookPhotoViewSearchBarState();
//}
//
//class _ScrapbookPhotoViewSearchBarState
//    extends State<ScrapbookPhotoViewSearchBar>
//    with SingleTickerProviderStateMixin {
//  static final double BORDER_RADIUS = 10;
//  static final int ANIMATION_DURATION_MILLISECONDS = 200;
//  TextEditingController _searchBarController;
//  bool _selected = false;
//  AnimationController _animationController;
//  Animation<double> _animationTween;
//
//  @override
//  void initState() {
//    super.initState();
//    _animationController = AnimationController(
//      duration: Duration(milliseconds: ANIMATION_DURATION_MILLISECONDS),
//      vsync: this,
//    );
//    _animationTween =
//        Tween<double>(begin: 2, end: 2).animate(_animationController);
//    _searchBarController =
//        TextEditingController(text: "Search destinations or titles");
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    _searchBarController.dispose();
//    _animationController.dispose();
//  }
//
//  BoxDecoration getInputDecoration() {
//    if (!_selected) {
//      return BoxDecoration(
//          border: Border.fromBorderSide(BorderSide(
//            color: EmbarkColors.lightGray,
//            width: 1.5,
//          )),
//          borderRadius: BorderRadius.all(Radius.circular(10)));
//    } else {
//      return BoxDecoration(
//          color: EmbarkColors.white,
//          border: Border.fromBorderSide(BorderSide(
//            color: EmbarkColors.extraLightGray,
//            width: 1.5,
//          )),
//          borderRadius: BorderRadius.all(Radius.circular(10)));
//    }
//  }
//
//  Widget _renderTextField() {
//    Widget innerTextField = TextField(
//        autofocus: true,
//        onSubmitted: (submission) {
//          setState(() {
//            _selected = false;
//          });
//          widget.onCompleted();
//        },
//        controller: _searchBarController,
//        style: TextStyle(
//            color: _selected ? EmbarkColors.gray : EmbarkColors.lightGray,
//            fontWeight: FontWeight.w500),
//        decoration: InputDecoration(
//            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
//            border: InputBorder.none,
//            labelStyle: TextStyle(fontSize: 16),
//            fillColor: Colors.transparent));
//    if (!_selected) {
//      return Container(
//          padding: EdgeInsets.only(left:15),
//          alignment: Alignment.centerLeft,
//          child: Text("Search destinations or titles",
//              style: TextStyle(
//                  fontSize: 16,
//                  fontWeight: FontWeight.w500,
//                  color: EmbarkColors.lightGray)));
//    } else {
//      return Container(
//          child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
//        IconButton(icon: Icon(Icons.arrow_back, size: 16, color: EmbarkColors.gray)),
//        Flexible(child: innerTextField),
//        IconButton(icon: Icon(Icons.clear, size: 16, color: EmbarkColors.gray),padding: EdgeInsets.only(right:0))
//      ]));
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    Size size = MediaQuery.of(context).size;
//    return Container(margin: EdgeInsets.only(top: 10,left: 15, right:15),alignment:Alignment.bottomCenter,child:Material(
//            elevation:2,
//            borderRadius: BorderRadius.all(Radius.circular(BORDER_RADIUS)),
//            child: InkWell(
//                onTap: () {
//                  if(!_selected){
//                    setState(() {
//                      _selected = true;
//                      _animationController.forward();
//                    });
//                    widget.onSelected();
//                  }
//
//                },
//                child: AnimatedContainer(
//                    width: size.width,
//                    duration: Duration(milliseconds: ANIMATION_DURATION_MILLISECONDS),
//                    decoration: getInputDecoration(),
//                    height: _selected ? 50 : 40,
//                    child: _renderTextField()))));
//  }
//}
