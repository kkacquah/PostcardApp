import 'package:embark/Pages/Scrapbook/Components/Primitives/Scalable.dart';
import 'package:embark/Pages/Scrapbook/Models/ScrapbookComponentMapModel.dart';
import 'package:embark/Pages/Scrapbook/Models/ScrapbookInfoModel.dart';
import 'package:embark/Pages/Scrapbook/Models/ScrapbookPageUIModel.dart';
import 'package:embark/Pages/Scrapbook/Utils/ScaleController.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'EditableScalable.dart';

class RemoveEditScaleController extends EditScaleController {
  //Key of the widget which can be removed
  UniqueKey key;

  removeComponent(ScrapbookComponentMapModel scrapbookComponentMapModel) {
    scrapbookComponentMapModel.removeScrapbookComponent(key);
  }

  RemoveEditScaleController(key,
      {initialAngle, initialScale = 1.0, initialOffset})
      : super(
            initialAngle: initialAngle,
            initialScale: initialScale,
            initialOffset: initialOffset);
}

class RemovableEditableScalable extends EditableScalable {
  final RemoveEditScaleController controller;

  RemovableEditableScalable(
      {this.controller, overlayWidget, child, absorbPointer})
      : super(
            overlayWidget: overlayWidget,
            controller: controller,
            child: child,
            absorbPointer: absorbPointer);

  @override
  State createState() => _RemovableEditableScalableState();
}

class _RemovableEditableScalableState extends State<RemovableEditableScalable> {
  //Last focal point in pixels
  Offset _pointerPositon;
  Offset _isPreparedForDeletion;

  @override
  void initState() {
    widget.controller.addListener(() {
      this.setState(() {
        _pointerPositon = widget.controller.pointerPosition;
      });
    });
    super.initState();
  }

  void onTap() {
    this.setState(() {
      widget.controller.overlayWidget(context, widget.overlayWidget);
    });
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  Widget _getBackground() {
    return (this._pointerPositon == null)
        ? Container()
        : Container(color: Colors.redAccent);
  }

  @override
  Widget build(BuildContext context) {
    //If pointer position is in a circle with particular absolute characteristics
    //Shrink it and grow the deletion circle
    //Use a lerp of scale to get an animation response
    //onScaleEnd if prepared, remove the component
    return ScopedModelDescendant<ScrapbookPageUIModel>(
        builder: (context, child, model) {
      //tell listener that on charge
      widget.controller.addListener(() {
        //sets component is dragged to true when component is dragged
        model
            .setComponentDragPointerPosition(widget.controller.pointerPosition);
      });
      return EditableScalable(
            controller: widget.controller,
            absorbPointer: true,
            overlayWidget: widget.overlayWidget,
            child: widget.child);
    });
  }
}
