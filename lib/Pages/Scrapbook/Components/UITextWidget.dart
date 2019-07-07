import 'package:embark/Pages/Scrapbook/Components/ScrapbookComponent.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:embark/Pages/Scrapbook/Utils/ScaleController.dart';
import 'package:flutter/material.dart';
import 'Scalable.dart';

const DEFAULT_TEXT_ALIGN = TextAlign.right;
const DEFAULT_FONT_COLOR = EmbarkAlmostBlack;
const double DEFAULT_FONT_SIZE = 30;
const EdgeInsetsGeometry CROP_GEOMETRY_ZERO = const EdgeInsets.all(0);
const double DEFAULT_INITIAL_WIDTH = 100;
const double DEFAULT_INITIAL_HEIGHT = 150;
const Color IMAGE_BORDER_COLOR = EmbarkAlmostWhite;
const double DEFAULT_INITIAL_BORDER_WIDTH = 10;
const double DEFAULT_INITIAL_ANGLE = 10;
const Offset DEFAULT_INITIAL_POSITION = Offset.zero;

//Mutable object representing TextScrapbookComponentState
class TextScrapbookComponentState implements ScrapbookComponentState {
  @override
  final Offset position;
  @override
  final double angle;
  final String text;
  final double fontSize;
  final Color fontColor;
  final TextAlign textAlign;

  TextScrapbookComponentState(
      {
        this.text,
        this.fontSize = DEFAULT_FONT_SIZE,
        this.fontColor = DEFAULT_FONT_COLOR,
        this.textAlign = DEFAULT_TEXT_ALIGN,
        this.position=DEFAULT_INITIAL_POSITION,
      this.angle=DEFAULT_INITIAL_ANGLE,
        });
}

//ImageScrapbookComponent put on stack
class TextScrapbookComponent implements ScrapbookComponent {
  @override
  final ScrapbookComponentState componentState;

  TextScrapbookComponent({this.componentState})
      : assert(componentState != null);

  @override
  void getState() {}

  @override
  StatefulWidget getUIComponent() {
    return UITextWidget(state: this.componentState);
  }
}

class UITextWidget extends StatefulWidget {

  final TextScrapbookComponentState state;

  UITextWidget({
    this.state});

  @override
  _UITextWidgetState createState() => _UITextWidgetState();
}

class _UITextWidgetState extends State<UITextWidget> {
  OverlayEntry _overlayEntry;
  ScaleController _controller;
  double _fontSize;


  @override
  void initState() {
    super.initState();
    this._controller = ScaleController(
        initialAngle: widget.state.angle,
        initialOffset: widget.state.position
    )
      ..addListener(() {
        this.setState(() {
          _fontSize = widget.state.fontSize * this._controller.scaleState.scale;
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


  Widget _buildTextWidget() {
    return  Text(
      widget.state.text,
      textAlign: widget.state.textAlign,
      style: TextStyle(
          backgroundColor: Colors.transparent,
          fontSize: widget.state.fontSize,
          fontWeight: FontWeight.w700,
          color: widget.state.fontColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scalable(
        onTap: () {
          this._overlayTextField();
        },
        controller: this._controller,
        absorbPointer: false,
        child: _buildTextWidget());
  }
}
