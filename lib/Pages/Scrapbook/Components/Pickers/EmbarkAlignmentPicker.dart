import 'package:embark/Pages/Scrapbook/Components/Primitives/ShadowIcon.dart';
import 'package:embark/Styles/Alignments.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

typedef OnSaveEmbarkAlignmentPicker = void Function(int embarkAlignmentId);


class EmbarkAlignmentPicker extends StatefulWidget {
  OnSaveEmbarkAlignmentPicker onSaved;
  int embarkAlignmentId;

  EmbarkAlignmentPicker({this.onSaved, this.embarkAlignmentId});

  @override
  _EmbarkAlignmentPickerState createState() => _EmbarkAlignmentPickerState();
}

class _EmbarkAlignmentPickerState extends State<EmbarkAlignmentPicker> {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: Container(
            child: GestureDetector(
                onTap: () {
                  this.setState(() {
                    widget.embarkAlignmentId =
                        (widget.embarkAlignmentId + 1) % 3;
                  });
                  widget.onSaved(widget.embarkAlignmentId);
                },
                child: Container(
                    height: (50 * (2 / 3)),
                    width: (50 * (2 / 3)),
                    child: ShadowIcon(
                      icon: EmbarkAlignments
                          .list[widget.embarkAlignmentId].iconData,
                    )))));
  }
}
