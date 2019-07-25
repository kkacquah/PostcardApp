import 'package:flutter/material.dart';

class ScaleState {
  //rotation of component in radians
  double angle = 0;

  //scale of component
  double scale = 1.0;

  //x position in pixels values
  Offset offset;

  ScaleState({this.angle, this.scale, this.offset})
      : assert(offset != null),
        assert(angle != null),
        assert(scale != null);
}

class ScaleController extends ChangeNotifier {
  final double initialAngle;
  final double initialScale;
  final Offset initialOffset;

  ScaleState scaleState;


  //Last focal point in pixels
  //Previously previous focal point
  Offset pointerPosition;

  //Last focal point in pixels
  double _previousAngle;

  //previous scale of component
  double _previousScale;

  void onScaleStart(ScaleStartDetails details) {
    //set up baseline for scale to compare to.
    _previousScale = scaleState.scale;
    pointerPosition = details.focalPoint;
    _previousAngle = scaleState.angle;
    this.notifyListeners();
  }

  void onScaleEnd(ScaleEndDetails details) {
    pointerPosition = null;
    this.notifyListeners();
  }

  void onScaleUpdate(ScaleUpdateDetails details) {
    //compute offset change
    Offset delta = details.focalPoint - pointerPosition;
    Offset computedOffset = scaleState.offset + delta;
    pointerPosition = details.focalPoint;
    //update getters
    scaleState.angle = _previousAngle + details.rotation;
    scaleState.offset = computedOffset;
    scaleState.scale = _previousScale * details.scale;
    this.notifyListeners();
  }

  ScaleController({
      this.initialAngle = 0,
      this.initialScale = 1,
      this.initialOffset = Offset.zero}) {
    _previousScale = initialScale;
    scaleState = ScaleState(
        scale: this.initialScale,
        angle: this.initialAngle,
        offset: this.initialOffset);
  }
}
