import 'package:embark/Pages/Scrapbook/Components/EditComponents/UICoverTitleEditWidget.dart';
import 'package:embark/Pages/Scrapbook/Components/Primitives/RemovableEditableScalable.dart';
import 'package:embark/Pages/Scrapbook/Components/ViewComponents/ScrapbookComponent.dart';
import 'package:embark/Pages/Scrapbook/Models/ScrapbookInfoModel.dart';
import 'package:embark/Pages/Scrapbook/Utils/UIUtils.dart';
import 'package:embark/Styles/Alignments.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:embark/Pages/Scrapbook/Components/Primitives/EditableScalable.dart';

const DEFAULT_TEXT_ALIGN = 0;
const DEFAULT_FONT_COLOR = EmbarkColors.black;
const double DEFAULT_FONT_SIZE = 30;
const EdgeInsetsGeometry CROP_GEOMETRY_ZERO = const EdgeInsets.all(0);
const double DEFAULT_INITIAL_WIDTH = 100;
const double DEFAULT_INITIAL_HEIGHT = 150;
const Color IMAGE_BORDER_COLOR = EmbarkColors.white;
const double DEFAULT_INITIAL_BORDER_WIDTH = 10;
const double DEFAULT_INITIAL_ANGLE = 0;
const String DEFAULT_FONT = "OpenSans";
const Offset DEFAULT_INITIAL_POSITION = Offset.zero;
const String TITLE_TEXT_PLACEHOLDER = "Title";
const String DATE_TEXT_PLACEHOLDER = "Add Dates...";

//Mutable object representing TextScrapbookComponentState
class CoverTitleScrapbookComponentState extends ScrapbookComponentState {
  String text;
  double fontSize;

  //This can't be stored as an ID because the object list may change
  Color fontColor;
  String fontFamily;

  //However, the ordering of alignment objects will never be changed/
  int embarkAlignmentId;

  //Can be passed by reference as

  //text and date range are initially set to null
  CoverTitleScrapbookComponentState(key,
      {this.text,
      this.fontSize = DEFAULT_FONT_SIZE,
      this.fontColor = DEFAULT_FONT_COLOR,
      this.embarkAlignmentId = DEFAULT_TEXT_ALIGN,
      this.fontFamily = DEFAULT_FONT,
      offset = DEFAULT_INITIAL_POSITION,
      angle = DEFAULT_INITIAL_ANGLE})
      : super(key, offset: offset, angle: angle);
}

//Cover Title Widget put on stack
class CoverTitleScrapbookComponent extends ScrapbookComponent {
  CoverTitleScrapbookComponent({state}) : super(state: state);

  @override
  StatefulWidget getUIComponent(double opacity) {
    return UICoverTitleWidget(state: this.state, opacity: opacity);
  }
}

class UICoverTitleWidget extends StatefulWidget {
  final CoverTitleScrapbookComponentState state;
  final double opacity;

  UICoverTitleWidget({this.state, this.opacity});

  @override
  _UICoverTitleWidgetState createState() => _UICoverTitleWidgetState();
}

class _UICoverTitleWidgetState extends State<UICoverTitleWidget> {
  OverlayEntry _overlayEntry;
  RemoveEditScaleController _controller;
  double initialFontSize;

  @override
  void initState() {
    super.initState();
    initialFontSize = widget.state.fontSize;
    this._controller = RemoveEditScaleController(widget.state.key,
        initialAngle: widget.state.angle, initialOffset: widget.state.offset)
      ..addListener(() {
        this.setState(() {
          widget.state.fontSize =
              initialFontSize * this._controller.scaleState.scale;
        });
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _getTitleText() {
    if (widget.state.text != null) {
      return widget.state.text;
    } else {
      return TITLE_TEXT_PLACEHOLDER;
    }
  }

  Widget _getContextView(ScrapbookInfoModel model) {
    List<Widget> titleContextWidgets = [
      _getContextTextView(model.getDateRangeString()),
      _getContextTextView(model.getCityAddressLineString())
    ];
    return Column(
        children: titleContextWidgets,
        crossAxisAlignment: EmbarkAlignments
            .list[widget.state.embarkAlignmentId].crossAxisAlignment);
  }

  Widget _getContextTextView(String context) {
    if (context != "") {
      return Text(context,
          style: TextStyle(
              fontFamily: widget.state.fontFamily,
              backgroundColor: Colors.transparent,
              fontSize: widget.state.fontSize * (3 / 5),
              fontWeight: FontWeight.w700,
              color: EmbarkColors.lightGray));
    } else {
      return Container();
    }
  }

  List<Widget> _buildTitleColumnList() {
    List<Widget> titleColumnList = [
      Builder(builder: (context) {
        return Text(_getTitleText(),
            textAlign:
                EmbarkAlignments.list[widget.state.embarkAlignmentId].textAlign,
            style: TextStyle(
                fontFamily: widget.state.fontFamily,
                backgroundColor: Colors.transparent,
                fontSize: widget.state.fontSize,
                fontWeight: FontWeight.w700,
                color: widget.state.fontColor));
      }),
    ];

    titleColumnList.add(ScopedModelDescendant<ScrapbookInfoModel>(
        builder: (context, child, model) {
      return _getContextView(model);
    }));
    return titleColumnList;
  }

  Widget _buildTitleColumnWidget() {
    return Column(
        crossAxisAlignment: EmbarkAlignments
            .list[widget.state.embarkAlignmentId].crossAxisAlignment,
        children: _buildTitleColumnList());
  }

  Widget _buildTitleStackWidget() {
    return Material(
        elevation: 2 * widget.opacity,
        borderRadius: BorderRadius.circular(6),
        color: EmbarkColors.extraLightGray,
        child: Container(
            padding: EdgeInsets.all(10),
            constraints: BoxConstraints(maxWidth: widget.state.fontSize * 8),
            decoration: BoxDecoration(
                color: EmbarkColors.white.withOpacity(widget.opacity),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                    width: 3,
                    color: EmbarkColors.lightGray.withOpacity(widget.opacity))),
            child: _buildTitleColumnWidget()));
  }

  @override
  Widget build(BuildContext context) {
    return RemovableEditableScalable(
        overlayWidget: UICoverTitleEditWidget(
            state: widget.state, opacity: widget.opacity),
        controller: this._controller,
        absorbPointer: true,
        child: _buildTitleStackWidget());
  }
}
