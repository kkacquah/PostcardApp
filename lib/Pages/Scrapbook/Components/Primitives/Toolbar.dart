import 'package:embark/Pages/Scrapbook/Models/ScrapbookPageUIModel.dart';
import 'package:embark/Pages/Scrapbook/Utils/UIUtils.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:scoped_model/scoped_model.dart';

const double DELETE_WIDGET_RADIUS = 30;
const double DELETE_WIDGET_RADIUS_FOCUSED = 40;
const double TOOLBAR_HEIGHT = 100;

class CoverToolbar extends StatefulWidget {
  @override
  _ToolbarState createState() {
    return _ToolbarState();
  }
}

class _ToolbarState extends State<CoverToolbar> {
  double _deleteWidgetRadius = DELETE_WIDGET_RADIUS;

  Widget _getDeleteWidget() {
    print(_deleteWidgetRadius);
    //Check if pointer is within delete widget radius
    return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
            height: TOOLBAR_HEIGHT,
            child: Container(

                alignment: Alignment.center,
                child: Material(
                    shape: CircleBorder(),
                    color: Colors.transparent,
                    elevation: 2.0,
                    child: ClipOval(
                        child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: EmbarkColors.gray.withOpacity(0.5),
                            ),
                            child: BackdropFilter(
                                filter:
                                    ui.ImageFilter.blur(sigmaX: 4, sigmaY: 4),
                                child: AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    height: _deleteWidgetRadius * 2,
                                    width: _deleteWidgetRadius * 2,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: EmbarkColors.white,
                                            width: 2),
                                        shape: BoxShape.circle,
                                        color: Colors.transparent),
                                    child: Icon(Icons.delete,
                                        size: 26,
                                        color: EmbarkColors.white)))))))));
  }

  Widget _getFloatingAddButtonWidget() {
    return Align(
        alignment: Alignment.bottomRight,
        child: Container(
            margin: EdgeInsets.only(right: 25, bottom: 25),
            child: FloatingActionButton(
                elevation: 2,
                backgroundColor: EmbarkColors.white,
                child: Icon(Icons.add, color: EmbarkColors.black, size: 30))));
  }

  bool _pointerInDeleteWidgetRadius(
      Offset pointerPosition, double _deleteWidgetRadius, Size screenSize) {
    if(pointerPosition == null){
      return false;
    }
    double deleteWidgetOriginDx = screenSize.width / 2;
    double deleteWidgetOriginDy = screenSize.height - TOOLBAR_HEIGHT / 2;
    Offset deleteWidgetOrigin =
        Offset(deleteWidgetOriginDx, deleteWidgetOriginDy);
    return pointInCircle(
        pointerPosition, deleteWidgetOrigin, _deleteWidgetRadius);
  }

  _getToolbar(){
    if(false){
      return _getFloatingAddButtonWidget();
    } else {
      return _getDeleteWidget();
    }
  }
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    Offset pointerPosition;
    return ScopedModelDescendant<ScrapbookPageUIModel>(
      child: _getToolbar(),
        builder: (context, child, model) {
          pointerPosition = model.getComponentDragPointerPosition();
          WidgetsBinding.instance
              .addPostFrameCallback((_) => executeAfterBuild(pointerPosition,screenSize));
        return child;
    });
  }
  Future<void> executeAfterBuild(Offset pointerPosition, Size screenSize) async {
    // this code will get executed after the build method
    // because of the way async functions are scheduled
    if (_pointerInDeleteWidgetRadius(
        pointerPosition, _deleteWidgetRadius, screenSize)) {
      //on mouse enter grow radius
      this.setState((){
        _deleteWidgetRadius = DELETE_WIDGET_RADIUS_FOCUSED;
      });
    } else {
      //on mouse leave shrink radius
      this.setState((){
        _deleteWidgetRadius = DELETE_WIDGET_RADIUS;
      });
    }
  }
}

