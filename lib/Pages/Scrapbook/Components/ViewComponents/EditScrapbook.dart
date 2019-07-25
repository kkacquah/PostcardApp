import 'dart:io';

import 'package:embark/Pages/Scrapbook/Components/ViewComponents/UIScrapbookCoverPage.dart';
import 'package:embark/Pages/Scrapbook/Models/ScrapbookInfoModel.dart';
import 'package:embark/Pages/Scrapbook/Models/ScrapbookPageMapModel.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class EditScrapbookState {
  CoverScrapbookPage coverPage;
  ScrapbookPageMapModel scrapbookPageMapModel;
  ScrapbookInfoModel scrapbookInfoModel;

  EditScrapbookState(
      {this.coverPage, this.scrapbookPageMapModel, this.scrapbookInfoModel})
      : assert(coverPage != null),
        assert(scrapbookPageMapModel != null),
        assert(scrapbookInfoModel != null);
}

class EditScrapbook {
  final EditScrapbookState state;

  EditScrapbook({this.state}) : assert(state != null);

  StatefulWidget getUIComponent() {
    return UIEditScrapbookWidget(state: state);
  }
}

class UIEditScrapbookWidget extends StatefulWidget {
  final EditScrapbookState state;

  UIEditScrapbookWidget({this.state});

  _UIEditScrapbookWidgetState createState() {
    // TODO: implement createState
    return _UIEditScrapbookWidgetState();
  }
}

class _UIEditScrapbookWidgetState extends State<UIEditScrapbookWidget> {
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: EmbarkColors.extraLightGray,
        body: ScopedModel<ScrapbookInfoModel>(
            model: widget.state.scrapbookInfoModel,
            child:  widget.state.coverPage.getUIComponent()));
  }
}
