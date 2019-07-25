
import 'package:flutter/material.dart';

const Offset INITIAL_OFFSET = Offset.zero;
const double INITIAL_ANGLE = 0;
const double INITIAL_SCALE = 1.0;
abstract class ScrapbookComponentState {
  Offset offset;
  double angle;
  double scale;
  UniqueKey key;

  ScrapbookComponentState(
      this.key,
      {this.angle = INITIAL_ANGLE,
      this.offset = INITIAL_OFFSET,
      this.scale = INITIAL_SCALE});
}

abstract class ScrapbookComponent {
  final ScrapbookComponentState state;

  ScrapbookComponent({this.state}) : assert(state != null);


  StatefulWidget getUIComponent(double opacity);
}
