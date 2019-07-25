
import 'package:embark/Pages/Scrapbook/Components/Primitives/Toolbar.dart';
import 'package:embark/Pages/Scrapbook/Models/ScrapbookComponentMapModel.dart';
import 'package:embark/Pages/Scrapbook/Models/ScrapbookPageUIModel.dart';
import 'package:flutter/material.dart';

import 'package:embark/Pages/Scrapbook/Components/ViewComponents/ScrapbookComponent.dart';

const Offset INITIAL_OFFSET = Offset.zero;
const double INITIAL_ANGLE = 0;

enum ScrapbookPageType {
  COVER,
  NORMAL
}

abstract class ScrapbookPageState {
  ScrapbookComponentMapModel scrapbookComponentMapModel;
  UniqueKey key;

   ScrapbookPageState(this.key,
  {this.scrapbookComponentMapModel});

  Widget getToolbar(){
    return CoverToolbar();
  }
}

abstract class ScrapbookPage {
  final ScrapbookPageState state;

  ScrapbookPage({this.state}) : assert(state != null);

  StatefulWidget getUIComponent();


}
