import 'package:flutter/material.dart';

const double DEFAULT_INITIAL_ANGLE = 0;
const Offset DEFAULT_INITIAL_POSITION = Offset.zero;

abstract class ScrapbookComponentState {
  final Offset position;
  final double angle;

  ScrapbookComponentState({this.angle, this.position});
}

abstract class ScrapbookComponent {
  final ScrapbookComponentState componentState;

  ScrapbookComponent({this.componentState}) : assert(componentState != null);

  void getState();

  StatefulWidget getUIComponent();
}


