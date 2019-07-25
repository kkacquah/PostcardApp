import 'package:flutter/material.dart';

const List<IconData> ALIGN_ICONS_ROTATION = [
  Icons.format_align_left,
  Icons.format_align_center,
  Icons.format_align_right
];

class EmbarkAlignment{
  //IconData representing alignment
  final IconData iconData;
  //text alignment representing alignment
  final TextAlign textAlign;
  //CrossAxisAlignment representing alignment
  final CrossAxisAlignment crossAxisAlignment;

  const EmbarkAlignment({this.iconData, this.textAlign, this.crossAxisAlignment});
}


class EmbarkAlignments {
  static const left = EmbarkAlignment(iconData:Icons.format_align_left, textAlign: TextAlign.start, crossAxisAlignment: CrossAxisAlignment.start);
  static const center = EmbarkAlignment(iconData:Icons.format_align_center, textAlign: TextAlign.center, crossAxisAlignment: CrossAxisAlignment.center);
  static const right = EmbarkAlignment(iconData:Icons.format_align_right, textAlign: TextAlign.end, crossAxisAlignment: CrossAxisAlignment.end);
  static const List<EmbarkAlignment> list = [left,center,right];
}