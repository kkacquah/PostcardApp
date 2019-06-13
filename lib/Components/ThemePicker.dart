import 'package:flutter/material.dart';
import 'package:embark/Styles/Themes.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:embark/Styles/Paintings.dart';

final double widthOfThemeString = 90;
final double widthOfThemeSmall = (50 * (2 / 3));
final double widthOfThemeLarge = (100 * (2 / 3));
final double totalWidthOfThemes =
    widthOfThemeSmall * (EmbarkThemes.themes.length - 1) + widthOfThemeLarge;

class ThemePicker extends StatefulWidget {
  double height = 50;
  double width = 50 * (2 / 3) + 90;
  bool longPressed = false;
  int themeID;
  Function onSaved = () {};

  ThemePicker({this.onSaved, this.themeID = 1});

  @override
  _ThemePickerState createState() => _ThemePickerState();
}

class _ThemePickerState extends State<ThemePicker> {
  void _getThemeIDFromDx(BuildContext context, double dx) {
    Size size = MediaQuery.of(context).size;
    double end = size.width - (15 + 90);
    double begin;
    for (int i = EmbarkThemes.themes.length - 1; i >= 0; i--) {
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

  Widget _getThemeName() {
    if (!widget.longPressed) {
      return Container(
          width: 75,
          child: Text("Theme",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: EmbarkAlmostBlack)));
    } else {
      return Container(
          width: 75,
          child: Text(EmbarkThemes.themes[widget.themeID].name,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: "OpenSans",
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: EmbarkAlmostBlack)));
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
      widget.width = totalWidthOfThemes + widthOfThemeString;
      widget.height = 100;
      widget.longPressed = true;
    });
    //ADDED DELAY
  }

  Future<void> triggerGrowAnimation() async {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        widget.width = totalWidthOfThemes + widthOfThemeString;
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
                        widget.height = 50;
                        widget.width = 50 * (2 / 3) + 90;
                        widget.longPressed = false;
                      });
                      widget.onSaved(widget.themeID);
                    },
                    child: AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: widget.height,
                        width: widget.width,

                        child: Material(
                                color: EmbarkExtraLightGray,
                                elevation: 1.0,
                                borderRadius:
                                BorderRadius.all(Radius.circular(50)),
                            child: Center(
                                child: SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: <Widget>[
                                        _ThemePickerPainter(
                                            longPressed: widget.longPressed,
                                            height: 50,
                                            themeID: widget.themeID),
                                        Container(
                                            //TODO support theme names
                                            child: _getThemeName())
                                      ],
                                    )))))))));
  }
}

class _ThemePickerPainter extends StatefulWidget {
  int themeID;
  double height = 0;
  List<double> heights = List<double>(EmbarkThemes.themes.length);
  bool longPressed = false;
  Function onSaved = () {};

  _ThemePickerPainter({this.longPressed, this.height, this.themeID});

  @override
  State createState() {
    return _ThemePickerPainterState();
  }
}

class _ThemePickerPainterState extends State<_ThemePickerPainter>
    with TickerProviderStateMixin {
  @override
  void _setHeights() {
    for (int i = 0; i < EmbarkThemes.themes.length; i++) {
      if (widget.themeID == i) {
        widget.heights[i] = widget.height * 2;
      } else {
        widget.heights[i] = widget.height;
      }
    }
  }

  List<Widget> _generateThemes() {
    List<Widget> row = List<Widget>();
    for (int i = 0; i < EmbarkThemes.themes.length; i++) {
      row.add(AnimatedContainer(
          duration: Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 5),
          height: widget.heights[i] / 2,
          width: widget.heights[i] / 2,
          child: CustomPaint(
              foregroundPainter: ThemePainter(theme: EmbarkThemes.themes[i]))));
    }
    return row;
  }

  Widget build(BuildContext context) {
    _setHeights();
    if (!widget.longPressed) {
      return Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          height: widget.height / 2,
          width: widget.height / 2,
          child: CustomPaint(
              foregroundPainter:
                  ThemePainter(theme: EmbarkThemes.themes[widget.themeID])));
    } else {
      return Row(children: _generateThemes());
    }
  }
}
