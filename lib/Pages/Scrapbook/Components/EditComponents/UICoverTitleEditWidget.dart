import 'package:embark/Pages/Scrapbook/Components/Pickers/DatePicker.dart';
import 'package:embark/Pages/Scrapbook/Components/Pickers/EmbarkAlignmentPicker.dart';
import 'package:embark/Pages/Scrapbook/Components/Pickers/LocationPicker.dart';
import 'package:embark/Pages/Scrapbook/Utils/UIUtils.dart';
import 'package:embark/Styles/Alignments.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:embark/Pages/Scrapbook/Components/Pickers/FontPicker.dart';
import 'package:embark/Pages/Scrapbook/Components/Pickers/ColorPicker.dart';
import 'package:embark/Pages/Scrapbook/Components/ViewComponents/UICoverTitleWidget.dart';

const String TITLE_TEXT_PLACEHOLDER = "Title";
const String DATE_TEXT_PLACEHOLDER = "Add Dates...";
const double TITLE_TEXT_FONT = 30;
const double DATE_TEXT_FONT = 20;

class UICoverTitleEditWidget extends StatefulWidget {
  final CoverTitleScrapbookComponentState state;
  final double opacity;

  UICoverTitleEditWidget({this.state, this.opacity = 0})
      : assert(state != null);

  @override
  _UICoverTitleEditWidgetState createState() => _UICoverTitleEditWidgetState();
}

class _UICoverTitleEditWidgetState extends State<UICoverTitleEditWidget> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.state.text);
    _textEditingController.addListener(() {
      widget.state.text = _textEditingController.text;
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _textEditingController.dispose();
    super.dispose();
  }

  List<Widget> _buildTitleColumnList() {
    List<Widget> titleColumnList = [
      //OnChange change model
      TextFormField(
        maxLines: null,
        keyboardType: TextInputType.multiline,
        decoration: InputDecoration(border: InputBorder.none),
        controller: _textEditingController,
        textAlign: EmbarkAlignments.list[widget.state.embarkAlignmentId].textAlign,
        style: TextStyle(
            fontFamily: widget.state.fontFamily,
            backgroundColor: Colors.transparent,
            fontSize: TITLE_TEXT_FONT,
            fontWeight: FontWeight.w700,
            color: widget.state.fontColor),
      )
    ];

    return titleColumnList;
  }

  Widget _buildTitleColumnWidget() {
    return Column(
        mainAxisSize: MainAxisSize.min,
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
            width: 300,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: EmbarkColors.white.withOpacity(widget.opacity),
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                    width: 3,
                    color: EmbarkColors.lightGray.withOpacity(widget.opacity))),
            child: _buildTitleColumnWidget()));
  }

  void onSavedFont(fontFamily) {
    this.setState(() {
      widget.state.fontFamily = fontFamily;
    });
  }

  void onSavedColor(color) {
    this.setState(() {
      widget.state.fontColor = color;
    });
  }
  void onSavedEmbarkAlignmentId(embarkAlignmentId) {
    this.setState(() {
      widget.state.embarkAlignmentId = embarkAlignmentId;
    });
  }

  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(25),
        child: Stack(children: [
          //text editing chips
          Align(
              alignment: Alignment.topRight,
              child: Column(children: [
                ColorPicker(
                  onSaved: onSavedColor,
                ),
                FontPicker(
                  onSaved: onSavedFont,
                ),
                EmbarkAlignmentPicker(
                  onSaved:onSavedEmbarkAlignmentId,
                  embarkAlignmentId: widget.state.embarkAlignmentId,
                ),
                LocationPicker(),
                DatePicker()
              ])),
          //text editor
          Center(child: _buildTitleStackWidget())
        ]));
  }
}
