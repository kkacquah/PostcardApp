import 'package:embark/Pages/Scrapbook/Components/ViewComponents/EditScrapbook.dart';
import 'package:embark/Pages/Scrapbook/Components/ViewComponents/UICoverTitleWidget.dart';
import 'package:embark/Pages/Scrapbook/Components/ViewComponents/UIScrapbookCoverPage.dart';
import 'package:embark/Pages/Scrapbook/Models/ScrapbookComponentMapModel.dart';
import 'package:embark/Pages/Scrapbook/Models/ScrapbookInfoModel.dart';
import 'package:embark/Pages/Scrapbook/Models/ScrapbookPageMapModel.dart';
import 'package:embark/Pages/Scrapbook/Utils/DateUtils.dart';
import 'package:embark/Pages/Scrapbook/Utils/GeoUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:embark/Styles/Colors.dart';
import 'dart:ui';
import 'dart:io';
import 'dart:typed_data';

class EditScrapbookView extends StatelessWidget {
  @override
  EditScrapbookView();

  Widget build(BuildContext context) {
    //Create default info model for viewing.
    ScrapbookInfoModel scrapbookInfoModel = ScrapbookInfoModel();
    //Create component map model for viewing
    ScrapbookComponentMapModel scrapbookComponentMapModel =
        ScrapbookComponentMapModel();
    //Create key to add to component map model
    UniqueKey titleKey = UniqueKey();
    CoverTitleScrapbookComponent coverTitleScrapbookComponent =
        CoverTitleScrapbookComponent(
            state: CoverTitleScrapbookComponentState(titleKey,
                offset: Offset.zero));
    scrapbookComponentMapModel.addScrapbookComponent(
        titleKey, coverTitleScrapbookComponent);
    //Create key to add to page map model
    UniqueKey pageKey = UniqueKey();
    //Default UI components for initialization of scrapbook cover page
    CoverScrapbookPage defaultCoverPage = CoverScrapbookPage(
        state: CoverScrapbookPageState(pageKey,
            scrapbookComponentMapModel: scrapbookComponentMapModel));
    //Create pageMap for edit scrapbook state.
    //Create edit scrapbook state for ui viewing
    EditScrapbook editScrapbook = EditScrapbook(
        state: EditScrapbookState(
            scrapbookInfoModel: scrapbookInfoModel,
            scrapbookPageMapModel: ScrapbookPageMapModel(),
            coverPage: defaultCoverPage));

    return editScrapbook.getUIComponent();
  }
}
