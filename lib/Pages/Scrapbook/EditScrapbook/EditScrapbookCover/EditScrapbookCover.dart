import 'package:embark/Pages/Scrapbook/Components/UICoverPageWidget.dart';
import 'package:embark/Pages/Scrapbook/Components/UIImageWidget.dart';
import 'package:flutter/material.dart';
import 'package:embark/Pages/Scrapbook/EditScrapbook/Components/AppBar.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:embark/Services/ScrapbookInfo.dart';
import 'package:embark/Styles/Colors.dart';
import 'dart:ui';
import 'dart:io';
import 'dart:typed_data';

class AddScrapbookCover extends StatefulWidget {
  @override
  AddScrapbookCover();

  _AddScrapbookCoverState createState() {
    // TODO: implement createState
    return _AddScrapbookCoverState();
  }
}

class _AddScrapbookCoverState extends State<AddScrapbookCover> {
  bool previewState = true;
  final PostcardInfo postcardInfo = PostcardInfo();

  void addPhoto(File image) {
    this.setState(() {
      postcardInfo.imageFile = image;
    });
  }

  Uint8List loadData(File imageFile) {
    Uint8List bytes = imageFile.readAsBytesSync();
    return bytes;
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: EmbarkExtraLightGray,
        body: UICoverPageWidget(appBar: EditScrapbookAppBar(), componentList: [
          ImageScrapbookComponent(
              componentState: ImageScrapbookComponentState())
        ]));
  }
}
