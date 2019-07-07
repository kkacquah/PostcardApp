import 'package:embark/Pages/Scrapbook/Components/ScrapbookComponent.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:embark/Pages/Scrapbook/Utils/ScaleController.dart';
import 'package:flutter/material.dart';
import 'Scalable.dart';

const EdgeInsetsGeometry CROP_GEOMETRY_ZERO = const EdgeInsets.all(0);
const double DEFAULT_INITIAL_WIDTH = 100;
const double DEFAULT_INITIAL_HEIGHT = 150;
const Color IMAGE_BORDER_COLOR = EmbarkAlmostWhite;
const double DEFAULT_INITIAL_BORDER_WIDTH = 10;
const double DEFAULT_INITIAL_ANGLE = 10;
const Offset DEFAULT_INITIAL_POSITION = Offset.zero;

//Mutable object representing ImageScrapbookComponentState
class ImageScrapbookComponentState implements ScrapbookComponentState {
  @override
  final Offset position;
  @override
  final double angle;
  double height;
  EdgeInsetsGeometry cropGeometry;
  double width;
  ImageProvider imageProvider;

  ImageScrapbookComponentState(
      {this.cropGeometry = CROP_GEOMETRY_ZERO,
      this.height = DEFAULT_INITIAL_HEIGHT,
      this.width = DEFAULT_INITIAL_WIDTH,
      this.imageProvider,
      this.angle = DEFAULT_INITIAL_ANGLE,
      this.position = DEFAULT_INITIAL_POSITION});
}

//ImageScrapbookComponent put on stack
class ImageScrapbookComponent implements ScrapbookComponent {
  @override
  final ScrapbookComponentState componentState;

  ImageScrapbookComponent({this.componentState})
      : assert(componentState != null);

  @override
  void getState() {}

  @override
  StatefulWidget getUIComponent() {
    return UIImageComponent(state: this.componentState);
  }
}

// UI Component rendering the corresponding widget
class UIImageComponent extends StatefulWidget {
  final ImageScrapbookComponentState state;

  UIImageComponent({this.state}) : assert(state != null);

  @override
  UIImageComponentState createState() => UIImageComponentState();
}

//State of UI Component rendering the corresponding widget
class UIImageComponentState extends State<UIImageComponent> {
  OverlayEntry _overlayEntry;
  ScaleController _controller;
  double _width;
  double _height;
  double _imageBorderWidth;

  @override
  void initState() {
    super.initState();
    this._controller = ScaleController(
        initialAngle: widget.state.angle, initialOffset: widget.state.position)
      ..addListener(() {
        this.setState(() {
          _width = widget.state.width * this._controller.scaleState.scale;
          _height = widget.state.height * this._controller.scaleState.scale;
          _imageBorderWidth =
              DEFAULT_INITIAL_BORDER_WIDTH * this._controller.scaleState.scale;
        });
      });
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
        builder: (context) =>
            Center(child: Container(width: 100, height: 100)));
  }

  void _overlayTextField() {
    this._overlayEntry = this._createOverlayEntry();
    Overlay.of(context).insert(this._overlayEntry);
  }

  @override
  void dispose() {
    super.dispose();
    this._controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scalable(
        controller: this._controller,
        absorbPointer: true,
        child: Material(
            elevation: 1.0,
            child: Container(
              width: _width,
              height: _height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover, image: widget.state.imageProvider),
                  border: Border.fromBorderSide(BorderSide(
                      color: EmbarkAlmostWhite, width: _imageBorderWidth))),
            )));
  }
}
