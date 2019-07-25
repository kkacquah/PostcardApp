import 'package:embark/Pages/Scrapbook/Components/Primitives/RemovableEditableScalable.dart';
import 'package:embark/Pages/Scrapbook/Components/ViewComponents/ScrapbookComponent.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:embark/Pages/Scrapbook/Utils/ScaleController.dart';
import 'package:flutter/material.dart';
import 'package:embark/Pages/Scrapbook/Components/Primitives/EditableScalable.dart';

const DEFAULT_TEXT_ALIGN = TextAlign.right;
const DEFAULT_FONT_COLOR = EmbarkColors.black;
const double DEFAULT_FONT_SIZE = 30;
const EdgeInsetsGeometry CROP_GEOMETRY_ZERO = const EdgeInsets.all(0);
const double DEFAULT_INITIAL_WIDTH = 100;
const double DEFAULT_INITIAL_HEIGHT = 150;
const Color IMAGE_BORDER_COLOR = EmbarkColors.white;
const double DEFAULT_INITIAL_BORDER_WIDTH = 10;
const double DEFAULT_INITIAL_ANGLE = 10;
const Offset DEFAULT_INITIAL_POSITION = Offset.zero;

//Mutable object representing TextScrapbookComponentState
class TextScrapbookComponentState extends ScrapbookComponentState {
  @override
  bool deleted;
  final String text;
  final double fontSize;
  final Color fontColor;
  final TextAlign textAlign;

  TextScrapbookComponentState(
    key, {
    angle,
    offset,
    scale,
    this.text,
    this.fontSize = DEFAULT_FONT_SIZE,
    this.fontColor = DEFAULT_FONT_COLOR,
    this.textAlign = DEFAULT_TEXT_ALIGN,
  }) : super(key, angle: angle, offset: offset, scale: scale);
}

//ImageScrapbookComponent put on stack
class TextScrapbookComponent extends ScrapbookComponent {
  TextScrapbookComponent({state}) : super(state: state);

  @override
  StatefulWidget getUIComponent(double opacity) {
    return UITextWidget(state: this.state);
  }
}

class UITextWidget extends StatefulWidget {
  final TextScrapbookComponentState state;

  UITextWidget({this.state});

  @override
  _UITextWidgetState createState() => _UITextWidgetState();
}

class _UITextWidgetState extends State<UITextWidget> {
  ScaleController _controller;

  @override
  void initState() {
    super.initState();
    this._controller = ScaleController(
        initialAngle: widget.state.angle, initialOffset: widget.state.offset);
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
        builder: (context) =>
            Center(child: Container(width: 100, height: 100)));
  }

  Widget _buildTextWidget() {
    return Text(
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
    return RemovableEditableScalable(
        overlayWidget: _buildTextWidget(),
        controller: this._controller,
        absorbPointer: false,
        child: _buildTextWidget());
  }
}
