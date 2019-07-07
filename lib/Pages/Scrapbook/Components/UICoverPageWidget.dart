import 'dart:io';
import 'dart:math';

import 'package:dotted_border/dotted_border.dart';
import 'package:embark/Pages/Scrapbook/Components/ScrapbookComponent.dart';
import 'package:embark/Pages/Scrapbook/Components/UIImageWidget.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

const double PLACEHOLDER_X = 150;
const double PLACEHOLDER_Y = 200;
const double PLACEHOLDER_WIDTH = 200;
const double PLACEHOLDER_HEIGHT = 350;
const double PLACEHOLDER_BORDER = 10;
const double PLACEHOLDER_ANGLE = pi / 36;

class UICoverPageWidget extends StatefulWidget {
  final PreferredSizeWidget appBar;
  final List<ScrapbookComponent> componentList;

  UICoverPageWidget({this.appBar, this.componentList});

  _getWidgetFromComponent(ScrapbookComponent component) {
    return component.getUIComponent();
  }

  _getWidgetsFromComponents() {
    return componentList.map(_getWidgetFromComponent);
  }

  @override
  _UICoverPageWidgetState createState() {
    return _UICoverPageWidgetState();
  }
}

class _UICoverPageWidgetState extends State<UICoverPageWidget> {
  File _imageFile;

  Widget _getBackgroundWidget() {
    Container(color: EmbarkLightGray);
  }

  void addPhoto(File image) {
    this.setState(() {
      _imageFile = image;
      widget.componentList.add(ImageScrapbookComponent(
          componentState: ImageScrapbookComponentState()));
    });
  }

  Future _handlePlaceholderPress() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.addPhoto(image);
  }

  Widget _getFloatingActionButton() {
    return Align(
        alignment: Alignment.bottomRight,
        child: Container(
            margin: EdgeInsets.only(right: 25, bottom: 25),
            child: FloatingActionButton(
              elevation: 6,
              onPressed: () => {},
              child: Container(
                  color: EmbarkExtraLightGray,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.fromBorderSide(
                          BorderSide(color: EmbarkLightGray)))),
            )));
  }

  Widget _getAddPhotoPlaceholder() {
    return Positioned(
        left: PLACEHOLDER_X,
        top: PLACEHOLDER_Y,
        child: Transform.rotate(
            angle: PLACEHOLDER_ANGLE,
            child: Container(
                //Add photo placeholder
                child: DottedBorder(
                    color: EmbarkLightGray,
                    strokeWidth: 4,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                          onTap: () {
                            _handlePlaceholderPress();
                          },
                          splashColor: EmbarkLightGray,
                          child: Container(
                              padding: EdgeInsets.all(50),
                              width: 100,
                              height: 150,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text("Add Photo",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 30,
                                        color: EmbarkLightGray,
                                        fontWeight: FontWeight.w700)),
                              ))),
                    )))));
  }

  _getWidgets() {
    List<Widget> widgets = List(0);
    widgets.add(this._getBackgroundWidget());
    if (this._imageFile == null) {
      //if null return placeholder
      widgets.add(this._getAddPhotoPlaceholder());
    }
    widgets.addAll(widget._getWidgetsFromComponents());

    widgets.add(widget.appBar);
    widgets.add(this._getFloatingActionButton());
    return widgets;
  }

  void addComponent(ScrapbookComponent component) {
    this.setState(() {
      widget.componentList.add(component);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: this._getWidgets());
  }
}
