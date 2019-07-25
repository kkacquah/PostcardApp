import 'dart:io';
import 'dart:math';
import 'package:embark/Pages/Scrapbook/Models/ScrapbookComponentMapModel.dart';
import 'package:embark/Pages/Scrapbook/Models/ScrapbookInfoModel.dart';
import 'package:embark/Pages/Scrapbook/Models/ScrapbookPageMapModel.dart';
import 'package:embark/Pages/Scrapbook/Models/ScrapbookPageUIModel.dart';
import 'package:exif/exif.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:embark/Pages/Scrapbook/Components/ViewComponents/ScrapbookComponent.dart';
import 'package:embark/Pages/Scrapbook/Components/ViewComponents/UIImageWidget.dart';
import 'package:embark/Pages/Scrapbook/Components/ViewComponents/ScrapbookPage.dart';
import 'package:embark/Pages/Scrapbook/EditScrapbook/Components/AppBar.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:embark/Pages/Scrapbook/Components/Primitives/Background.dart';

const double PLACEHOLDER_X = 150;
const double PLACEHOLDER_Y = 200;
const double PLACEHOLDER_WIDTH = 200;
const double PLACEHOLDER_HEIGHT = 350;
const double PLACEHOLDER_BORDER = 10;
const double PLACEHOLDER_ANGLE = pi / 36;

//Mutable object representing TextScrapbookComponentState
class CoverScrapbookPageState extends ScrapbookPageState {
  int backgroundIndex;

  //text and date range are initially set to null
  CoverScrapbookPageState(key,
      {scrapbookComponentMapModel, this.backgroundIndex})
      : super(key, scrapbookComponentMapModel: scrapbookComponentMapModel) {
    if (this.backgroundIndex == null) {
      backgroundIndex = 0;
    }
  }
}

//Cover Title Widget put on stack
class CoverScrapbookPage extends ScrapbookPage {
  CoverScrapbookPage({state}) : super(state: state);

  @override
  StatefulWidget getUIComponent() {
    return UICoverPageWidget(state: this.state);
  }
}

class UICoverPageWidget extends StatefulWidget {
  final CoverScrapbookPageState state;
  ScrapbookPageUIModel scrapbookPageUIModel = ScrapbookPageUIModel();

  UICoverPageWidget({this.state});

  @override
  _UICoverPageWidgetState createState() {
    return _UICoverPageWidgetState();
  }
}

class _UICoverPageWidgetState extends State<UICoverPageWidget> {
  File _imageFile;
  PageController _backgroundController;
  double opacity = 0.0;

  void initState() {
    super.initState();
    _backgroundController = new PageController();
    _backgroundController.addListener(() {
      widget.state.backgroundIndex = _backgroundController.page.floor();
      if (_backgroundController.page <= 1.0) {
        this.setState(() {
          opacity = _backgroundController.page;
        });
      }
    });
  }

  Widget _getWidgetFromComponent(ScrapbookComponent component) {
    return component.getUIComponent(opacity);
  }

  List<Widget> _getWidgetsFromComponents() {
    return widget.state.scrapbookComponentMapModel.components.values
        .map((e) => e.getUIComponent(0))
        .toList();
  }

  Widget _getBackgroundWidget() {
    return PageView(
      controller: this._backgroundController,
      scrollDirection: Axis.horizontal,
      children: BACKGROUND_LIST,
    );
  }

  void addPhoto(File image) async {
    var decodedImage = await decodeImageFromList(image.readAsBytesSync());
    double width = decodedImage.width.toDouble();
    double height = decodedImage.height.toDouble();
    UniqueKey photoKey = UniqueKey();
    this.setState(() {
      _imageFile = image;
      widget.state.scrapbookComponentMapModel.addScrapbookComponent(
          photoKey,
          ImageScrapbookComponent(
              state: ImageScrapbookComponentState(photoKey,
                  offset: Offset(PLACEHOLDER_X, PLACEHOLDER_Y),
                  angle: PLACEHOLDER_ANGLE,
                  scale: 0.5,
                  cropRect: Rect.fromLTWH(0, 0, 1, 1),
                  originalWidth: width,
                  originalHeight: height,
                  imageProvider: FileImage(image))));
    });
  }

  Future _handlePlaceholderPress(ScrapbookInfoModel model) async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    await model.addDateAndLocationFromExif(image);
    if (image != null) {
      this.addPhoto(image);
    }
  }

  Widget _getAddPhotoPlaceholder() {
    return Positioned(
        left: PLACEHOLDER_X,
        top: PLACEHOLDER_Y,
        child: Transform.rotate(
            angle: PLACEHOLDER_ANGLE,
            child: Container(
                child: Material(
                    color: EmbarkColors.extraLightGray,
                    //Add photo placeholder
                    elevation: 2 * this.opacity,
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                        decoration: BoxDecoration(
                          color: EmbarkColors.white.withOpacity(this.opacity),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: DottedBorder(
                          color: EmbarkColors.lightGray,
                          strokeWidth: 4,
                          child: Material(
                              color: EmbarkColors.extraLightGray,
                              child: ScopedModelDescendant<ScrapbookInfoModel>(
                                  builder: (context, child, model) => InkWell(
                                      onTap: () {
                                        _handlePlaceholderPress(model);
                                      },
                                      splashColor: EmbarkColors.lightGray,
                                      child: Container(
                                          color: EmbarkColors.white
                                              .withOpacity(this.opacity),
                                          width: PLACEHOLDER_WIDTH,
                                          height: PLACEHOLDER_HEIGHT,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Text("Add Photo",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontSize: 30,
                                                    color:
                                                        EmbarkColors.lightGray,
                                                    fontWeight:
                                                        FontWeight.w700)),
                                          ))))),
                        ))))));
  }

  List<Widget> _getWidgets() {
    List<Widget> widgets = List();
    widgets.add(this._getBackgroundWidget());
    widgets.add(Container(
        alignment: Alignment.topCenter,
        height: 60,
        child: EditScrapbookAppBar()));
    widgets.addAll(this._getWidgetsFromComponents());

    if (this._imageFile == null) {
      //if null return placeholder
      widgets.add(this._getAddPhotoPlaceholder());
    }

    widgets.add(widget.state.getToolbar());
    return widgets;
  }

  void addComponent(ScrapbookComponent component) {
    UniqueKey key = UniqueKey();
    this.setState(() {
      widget.state.scrapbookComponentMapModel
          .addScrapbookComponent(key, component);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ScopedModel<ScrapbookPageUIModel>(
        model: widget.scrapbookPageUIModel,
        child: ScopedModel<ScrapbookComponentMapModel>(
            model: widget.state.scrapbookComponentMapModel,
            child: Stack(children: this._getWidgets())));
  }
}
