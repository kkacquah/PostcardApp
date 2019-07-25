import 'package:flutter/material.dart';
import 'package:embark/Styles/Colors.dart';

final double widthOfThemeSmall = (50 * (2 / 3));
final double widthOfThemeLarge = (100 * (2 / 3));
final double padding = 10;
final double totalWidthOfThemes =
(widthOfThemeSmall+padding) * (EmbarkColors.fontColors.length - 1) +
    (widthOfThemeLarge+padding);

typedef OnSaveColor = void Function(Color color);

class ColorPicker extends StatefulWidget {
  double height = 50 * (2 / 3);
  double width = 50 * (2 / 3);
  bool longPressed = false;
  int themeID;
  OnSaveColor onSaved;

  ColorPicker({this.onSaved, this.themeID = 1});

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  void _getThemeIDFromDx(BuildContext context, double dx) {
    Size size = MediaQuery.of(context).size;
    double end = size.width - (15 + 90);
    double begin;
    for (int i = EmbarkColors.fontColors.length - 1; i >= 0; i--) {
      if (i == widget.themeID) {
        begin = end - widthOfThemeLarge;
      } else {
        begin = end - widthOfThemeSmall;
      }
      if (dx > begin && dx < end) {
        setState(() {
          widget.themeID = i;
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
    //print(local.dx.toString() + "|" + local.dy.toString());
  }

  _onDragStart(DragStartDetails start) async {
    setState(() {
      widget.width = totalWidthOfThemes + padding;
      widget.height = widthOfThemeLarge + padding*2;
      widget.longPressed = true;
    });
    //ADDED DELAY
  }

  Future<void> triggerGrowAnimation() async {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        widget.width = totalWidthOfThemes;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(widget.themeID);

    return Container(
        margin: EdgeInsets.only(top: 10),
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
                      widget.onSaved(EmbarkColors.fontColors[widget.themeID]);
                    },
                    child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: widget.height,
                        width: widget.width,
                        decoration: BoxDecoration(
                            color: widget.longPressed
                                ? EmbarkColors.black.withOpacity(0.15)
                                : Colors.transparent,
                            borderRadius: BorderRadius.all(Radius.circular(25))),
                        child: Center(
                            child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    _ColorPickerPainter(
                                        longPressed: widget.longPressed,
                                        height: 50*(2/3),
                                        themeID: widget.themeID)
                                  ],
                                ))))))));
  }
}

class _ColorPickerPainter extends StatefulWidget {
  int themeID;
  double height = 0;
  List<double> heights = List<double>(EmbarkColors.fontColors.length);
  bool longPressed = false;
  Function onSaved = () {};

  _ColorPickerPainter({this.longPressed, this.height, this.themeID});

  @override
  State createState() {
    return _ColorPickerPainterState();
  }
}

class _ColorPickerPainterState extends State<_ColorPickerPainter>
    with TickerProviderStateMixin {
  @override
  void _setHeights() {
    for (int i = 0; i < EmbarkColors.fontColors.length; i++) {
      if (widget.themeID == i) {
        widget.heights[i] = widget.height * 2;
      } else {
        widget.heights[i] = widget.height;
      }
    }
  }

  List<Widget> _generateThemes() {
    List<Widget> row = List<Widget>();
    for (int i = 0; i < EmbarkColors.fontColors.length; i++) {
      row.add(AnimatedContainer(
        duration: Duration(milliseconds: 300),
        margin: EdgeInsets.symmetric(horizontal: 5),
        height: widget.heights[i],
        width: widget.heights[i],
        child: Material(
          shape: CircleBorder(),
          elevation: 1.0,
          child: Container(
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: EmbarkColors.fontColors[i],
                  border: Border.all(color: EmbarkColors.white))),
        ),
      ));
    }
    return row;
  }

  Widget build(BuildContext context) {
    _setHeights();
    if (!widget.longPressed) {
      return Container(
          height: widget.height,
          width: widget.height,
          child: Material(
              color: Colors.transparent,
              shape: CircleBorder(),
              elevation: 1.0,
              child: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: EmbarkColors.fontColors[widget.themeID],
                      border: Border.all(color: EmbarkColors.white)))));
    } else {
      return Row(children: _generateThemes());
    }
  }
}
