import 'package:embark/Styles/Fonts.dart';
import 'package:flutter/material.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:embark/Styles/Paintings.dart';

final double widthOfThemeSmall = (50 * (2 / 3));
final double widthOfThemeLarge = (100 * (2 / 3));
final double padding = 10;
final double totalWidthOfThemes =
    (widthOfThemeSmall) * (EmbarkColors.fontColors.length - 1) +
        (widthOfThemeLarge) -
        30;

typedef OnSaveFont = void Function(String fontFamily);

class FontPicker extends StatefulWidget {
  double height = (50 * (2 / 3));
  double width = (50 * (2 / 3));
  bool longPressed = false;
  int fontID;
  OnSaveFont onSaved;

  FontPicker({this.onSaved, this.fontID = 0});

  @override
  _FontPickerState createState() => _FontPickerState();
}

class _FontPickerState extends State<FontPicker> {
  void _getThemeIDFromDx(BuildContext context, double dx) {
    Size size = MediaQuery.of(context).size;
    double end = size.width - padding;
    double begin;
    for (int i = EmbarkFonts.fonts.length - 1; i >= 0; i--) {
      if (i == widget.fontID) {
        begin = end - widthOfThemeLarge;
      } else {
        begin = end - widthOfThemeSmall;
      }
      if (dx > begin && dx < end) {
        setState(() {
          widget.fontID = i;
        });

        return;
      } else {
        end = begin;
        continue;
      }
    }
  }

  _onDragUpdate(BuildContext context, DragUpdateDetails update) {
    RenderBox getBox = context.findRenderObject();
    var local = getBox.globalToLocal(update.globalPosition);
    _getThemeIDFromDx(context, local.dx);
  }

  _onDragStart(DragStartDetails start) async {
    setState(() {
      widget.width = totalWidthOfThemes + padding;
      widget.height = widthOfThemeLarge + padding * 2;
      widget.longPressed = true;
    });
    //ADDED DELAY
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(widget.fontID);

    return Container(
        child: Align(
            alignment: Alignment.topRight,
            child: Container(

                child: GestureDetector(
                    onHorizontalDragUpdate: (DragUpdateDetails update) =>
                        _onDragUpdate(context, update),
                    onHorizontalDragStart: _onDragStart,
                    onHorizontalDragEnd: (LongPressEndDetails) {
                      setState(() {
                        widget.height = 50 * (2 / 3);
                        widget.width = 50 * (2 / 3);
                        widget.longPressed = false;
                      });
                      widget.onSaved(EmbarkFonts.fonts[widget.fontID]);
                    },
                    child: AnimatedContainer(
                        alignment: Alignment.centerRight,
                        duration: Duration(milliseconds: 300),
                        height: widget.height,
                        width: widget.width,
                        decoration: BoxDecoration(
                            color: widget.longPressed
                                ? EmbarkColors.black.withOpacity(0.15)
                                : Colors.transparent,
                            borderRadius:
                                BorderRadius.all(Radius.circular(25))),
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                _FontPickerPainter(
                                    longPressed: widget.longPressed,
                                    height: 50,
                                    fontID: widget.fontID)
                              ],
                            )))))));
  }
}

class _FontPickerPainter extends StatefulWidget {
  int fontID;
  double height = 0;
  List<double> heights = List<double>(EmbarkColors.fontColors.length);
  bool longPressed = false;
  Function onSaved = () {};

  _FontPickerPainter({this.longPressed, this.height, this.fontID});

  @override
  State createState() {
    return _ThemePickerPainterState();
  }
}

class _ThemePickerPainterState extends State<_FontPickerPainter>
    with TickerProviderStateMixin {
  @override
  void _setHeights() {
    for (int i = 0; i < EmbarkFonts.fonts.length; i++) {
      if (widget.fontID == i) {
        widget.heights[i] = widget.height * 2;
      } else {
        widget.heights[i] = widget.height;
      }
    }
  }

  List<Widget> _generateFonts() {
    List<Widget> row = List<Widget>();
    for (int i = 0; i < EmbarkFonts.fonts.length; i++) {
      row.add(AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.only(bottom: widget.heights[i] / 2),
          margin: EdgeInsets.only(right: 10),
          height: widget.heights[i] / 2,
          width: widget.heights[i] / 2,
          child: CustomPaint(
              foregroundPainter: FontPainter(
                  fontStyle: EmbarkFonts.fonts[i],
                  yOffset: EmbarkFonts.yOffsets[i]))));
    }
    return row;
  }

  Widget build(BuildContext context) {
    _setHeights();
    if (!widget.longPressed) {
      return Container(
              margin: EdgeInsets.only(right:5, top:2),
              height: widget.height / 2,
              width: widget.height / 2,
              child: CustomPaint(
                  foregroundPainter: FontPainter(
                      fontStyle: EmbarkFonts.fonts[widget.fontID],
                      yOffset: EmbarkFonts.yOffsets[widget.fontID])));
    } else {
      return Row(children: _generateFonts());
    }
  }
}
