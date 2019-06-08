import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:embark/Components/Button.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:embark/Styles/Themes.dart';
import 'dart:ui';

class EditCard extends StatefulWidget {
  final EmbarkTheme _theme;
  final String _fontFamily;
  TextStyle _titleStyle;
  TextStyle _titleHintStyle;
  TextStyle _inputStyle;
  TextStyle _hintStyle;
  EditCard(this._theme, this._fontFamily) {
    this._titleStyle = TextStyle(
      fontFamily: this._fontFamily,
      color: this._theme.secondary,
      fontSize: 26,
      fontWeight: FontWeight.bold,
    );
    this._titleHintStyle = TextStyle(
      fontFamily: this._fontFamily,
      color: this._theme.secondary.withOpacity(0.4),
      fontSize: 26,
      fontWeight: FontWeight.bold,
    );
    this._inputStyle = TextStyle(
      fontFamily: this._fontFamily,
      color: this._theme.primary.withOpacity(0.4),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
    this._hintStyle = TextStyle(
      fontFamily: this._fontFamily,
      color: this._theme.primary.withOpacity(0.4),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
  }

  @override
  _editCardState createState() {
    return _editCardState();
  }
}

class _editCardState extends State<EditCard> {


  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Positioned(
        bottom: 0,
        width: size.width,
        child: Container(
          decoration: BoxDecoration(
            color: EmbarkAlmostWhite,
            boxShadow: [
              BoxShadow(
                  color: EmbarkAlmostBlack.withOpacity(0.25),
                  offset: new Offset(0, -2),
                  blurRadius: 4)
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(14.0),
                topRight: Radius.circular(14.0)),
//                border: Border(top: BorderSide)
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                    alignment: Alignment.center,
                    child: Container(
                        width: size.width * 0.90,
                        child: TextFormField(
                            maxLines: 1,
                            style: widget._titleStyle,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Title',
                              hintStyle: widget._titleHintStyle,
                            )))),
                Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Align(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  EmbarkIconButton(
                                      widget._theme,
                                      () {},
                                      "Add Location",
                                      true,
                                      EdgeInsets.only(
                                          right: size.width * 0.02,
                                          bottom: size.width * 0.02),
                                      fontSize: 17,
                                      fractionalWidth: 0.44,
                                      fontFamily: widget._fontFamily,
                                      iconData: Icons.add_location),
                                  EmbarkIconButton(
                                      widget._theme,
                                      () {},
                                      "Timestamp",
                                      false,
                                      EdgeInsets.only(
                                          bottom: size.width * 0.02),
                                      fontSize: 17,
                                      fractionalWidth: 0.44,
                                      fontFamily: widget._fontFamily,
                                      iconData: Icons.access_time)
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  EmbarkIconButton(
                                      widget._theme,
                                      () {},
                                      "Sentiments",
                                      false,
                                      EdgeInsets.only(right: size.width * 0.02),
                                      fontSize: 17,
                                      fractionalWidth: 0.44,
                                      fontFamily: widget._fontFamily,
                                      iconData: Icons.sentiment_very_satisfied),
                                  EmbarkIconButton(widget._theme, () {},
                                      "Tag Friends", true, EdgeInsets.all(0),
                                      fractionalWidth: 0.44,
                                      fontFamily: widget._fontFamily,
                                      fontSize: 17,
                                      iconData: Icons.group_add)
                                ])
                          ],
                        ),
                      ),
                    ),
                Container(
                    width: size.width * 0.90,
                    padding: EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      style: widget._inputStyle,
                      maxLength: 150,
                      maxLines: 4,
                      maxLengthEnforced: true,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: widget._hintStyle,
                          hintText: 'Share what you did...'),
                    )),
              ],
            ),
          ),
        ));
  }
}
