import 'package:embark/Pages/Scrapbook/Components/ScrapbookComponent.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:embark/Pages/Scrapbook/Utils/ScaleController.dart';
import 'package:embark/Pages/Scrapbook/Utils/DateRange.dart';
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
const String TITLE_TEXT_PLACEHOLDER = "Title";
const String DATE_TEXT_PLACEHOLDER = "Add Dates...";

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
  final DateRange dateRange;

  //text and date range are initially set to null
  TextScrapbookComponentState({
    this.text,
    this.fontSize = DEFAULT_FONT_SIZE,
    this.fontColor = DEFAULT_FONT_COLOR,
    this.textAlign = DEFAULT_TEXT_ALIGN,
    this.position = DEFAULT_INITIAL_POSITION,
    this.angle = DEFAULT_INITIAL_ANGLE,
    this.dateRange
  });
}

//Cover Title Widget put on stack
class TextScrapbookComponent implements ScrapbookComponent {
  @override
  final ScrapbookComponentState componentState;

  TextScrapbookComponent({this.componentState})
      : assert(componentState != null);

  @override
  void getState() {}

  @override
  StatefulWidget getUIComponent() {
    return UICoverTitleWidget(state: this.componentState);
  }
}

class UICoverTitleWidget extends StatefulWidget {
  final TextScrapbookComponentState state;

  UICoverTitleWidget({this.state});

  @override
  _UICoverTitleWidgetState createState() => _UICoverTitleWidgetState();
}

class _UICoverTitleWidgetState extends State<UICoverTitleWidget> {
  OverlayEntry _overlayEntry;
  ScaleController _controller;
  double _fontSize;

  @override
  void initState() {
    super.initState();
    this._controller = ScaleController(
        initialAngle: widget.state.angle, initialOffset: widget.state.position)
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

  String _getTitleText(){
    if(widget.state.text != null){
      return widget.state.text;
    } else {
      return TITLE_TEXT_PLACEHOLDER;
    }
  }
  String _getDateText(){
    if(widget.state.text != null){
      DateTime startingDate = widget.state.dateRange.begin;
      DateTime endingDate = widget.state.dateRange.end;
      return "${startingDate.month}/${startingDate.day}-${endingDate.month}/${endingDate.day}";
    } else {
      return DATE_TEXT_PLACEHOLDER;
    }
  }

  Widget _buildTitleColumnWidget() {
    return Column(children: [
      Text(
        _getTitleText(),
        textAlign: widget.state.textAlign,
        style: TextStyle(
            backgroundColor: Colors.transparent,
            fontSize: widget.state.fontSize,
            fontWeight: FontWeight.w700,
            color: widget.state.fontColor),
      ),
      Text(_getDateText(),
          style: TextStyle(
              backgroundColor: Colors.transparent,
              fontSize: widget.state.fontSize * (3 / 5),
              fontWeight: FontWeight.w700,
              color: EmbarkLightGray))
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scalable(
        onTap: () {
          this._overlayTextField();
        },
        controller: this._controller,
        absorbPointer: false,
        child: _buildTitleColumnWidget());
  }
}
