import 'package:flutter/material.dart';

CrossAxisAlignment textAlignToCrossAxisAlignment(TextAlign textAlign) {
  switch (textAlign) {
    case TextAlign.center:
      return CrossAxisAlignment.center;
      break;
    case TextAlign.left:
      return CrossAxisAlignment.start;
      break;
    case TextAlign.right:
      return CrossAxisAlignment.end;
      break;
    default:
      return CrossAxisAlignment.center;
  }
}

bool pointInCircle(Offset point, Offset circleOrigin, double circleRadius){
  Offset difference = point - circleOrigin;
  return (difference.distance < circleRadius);
}