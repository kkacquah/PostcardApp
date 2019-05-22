import 'package:flutter/material.dart';
import '../colors.dart';

class EmbarkButton extends StatelessWidget {
  final EmbarkTheme _theme;
  final Function _onPressed;
  final String _text;
  final bool _outline;
  final double _margin;

  //TODO ALLOW changing of fontsize
  EmbarkButton(this._theme, this._onPressed, this._text, this._outline,this._margin);

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (_outline) {
      return Container(
          margin: EdgeInsets.all(this._margin),
          width: size.width / 2,
          height: 50,
          child: OutlineButton(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25),
              ),
              onPressed: _onPressed,
              splashColor: _theme.primary(),
              borderSide: BorderSide(color: _theme.secondary()),
              child: Text('Sign Up',
                  style: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: _theme.secondary())),
              color: _theme.secondary()));
    } else {
      return Container(
          margin: EdgeInsets.all(20.0),
          width: size.width / 2,
          height: 50,
          child: MaterialButton(
              elevation: 0,
              height: 50,
              splashColor: _theme.primary(),
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25)),
              onPressed: _onPressed,
              child: Text(this._text,
                  style: TextStyle(
                      fontFamily: 'PlayfairDisplay',
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                      color: EmbarkSurfaceWhite)),
              color: _theme.secondary()));
    }
  }
}
