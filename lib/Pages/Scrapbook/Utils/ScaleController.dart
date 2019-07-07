import 'package:flutter/material.dart';

class ScaleState {
  //rotation of component in radians
  double angle = 0;

  //scale of component
  double scale = 1.0;

  //x position in pixels values
  Offset offset = null;

  ScaleState({angle, scale, offset});
}

class ScaleController extends ChangeNotifier {
  final double initialAngle;
  final double initialScale;
  final Offset initialOffset;

  ScaleState scaleState;

  //Last focal point in pixels
  Offset _previousFocalPoint;

  //Last focal point in pixels
  double _previousAngle;

  //previous scale of component
  double _previousScale = 1.0;

  void onScaleStart(ScaleStartDetails details) {
    //set up baseline for scale to compare to.
    _previousScale = scaleState.scale;
    _previousFocalPoint = details.focalPoint;
    _previousAngle = scaleState.angle;
  }

  void onScaleEnd(ScaleEndDetails details) {}

  void onScaleUpdate(ScaleUpdateDetails details) {
    //compute offset change
    print(details);
    Offset delta = details.focalPoint - _previousFocalPoint;
    Offset computedOffset = scaleState.offset + delta;
    _previousFocalPoint = details.focalPoint;
    //update getters
    scaleState.angle = _previousAngle + details.rotation;
    scaleState.offset = computedOffset;
    scaleState.scale = _previousScale * details.scale;
    this.notifyListeners();
  }

  ScaleController(
      {this.initialAngle = 0,
        this.initialScale = 1,
        this.initialOffset = Offset.zero}) {
    scaleState = ScaleState(
        scale: this.initialScale,
        angle: this.initialAngle,
        offset: this.initialOffset);
  }
}
