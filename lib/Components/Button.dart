import 'package:flutter/material.dart';
import 'package:embark/Styles/Themes.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:embark/Styles/Icons.dart';

class EmbarkIconButton extends StatelessWidget {
  final EmbarkTheme _theme;
  final Function _onPressed;
  final String _text;
  final bool _outline;
  final EdgeInsets _margin;
  final Icon _icon;

  //TODO ALLOW changing of fontsize
  EmbarkIconButton(
      this._theme, this._onPressed, this._text, this._outline, this._margin,this._icon);

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (_outline) {
      return Container(
          margin: this._margin,
          width: size.width * 0.4,
          height: 50,
          child: OutlineButton(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25),
              ),
              onPressed: _onPressed,
              splashColor: _theme.primary(),
              borderSide: BorderSide(color: _theme.secondary()),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
              _icon,
                Text(this._text,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: _theme.secondary()))

              ]),
              color: _theme.secondary()));
    } else {
      return Container(
          margin: this._margin,
          width: size.width * (3 / 8),
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
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: EmbarkSurfaceWhite)),
              color: _theme.secondary()));
    }
  }
}

class EmbarkButton extends StatelessWidget {
  final EmbarkTheme _theme;
  final Function _onPressed;
  final String _text;
  final bool _outline;
  final EdgeInsets _margin;

  //TODO ALLOW changing of fontsize
  EmbarkButton(
      this._theme, this._onPressed, this._text, this._outline, this._margin);

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (_outline) {
      return Container(
          margin: this._margin,
          width: size.width * (3 / 8),
          height: 50,
          child: OutlineButton(
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(25),
              ),
              onPressed: _onPressed,
              splashColor: _theme.primary(),
              borderSide: BorderSide(color: _theme.secondary()),
              child: Text(this._text,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: _theme.secondary())),
              color: _theme.secondary()));
    } else {
      return Container(
          margin: this._margin,
          width: size.width * (3 / 8),
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
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      color: EmbarkSurfaceWhite)),
              color: _theme.secondary()));
    }
  }
}

class EmbarkButtonGradient extends StatelessWidget {
  final EmbarkTheme _theme;
  final Function _onPressed;
  final String _text;
  final bool _outline;
  final double _margin;

  //TODO ALLOW changing of fontsize
  EmbarkButtonGradient(
      this._theme, this._onPressed, this._text, this._outline, this._margin);

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (_outline) {
      return Container(
          margin: EdgeInsets.all(this._margin),
          width: 0.4 * size.width,
          padding: EdgeInsets.all(2),
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: _theme.backgroundGradient()),
          child: Container(
              width: 0.4 * size.width,
              height: 50,
              child: MaterialButton(
                  highlightElevation: 0,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(25),
                  ),
                  onPressed: _onPressed,
                  elevation: 0,
                  splashColor: _theme.primary(),
                  child: Text('Sign Up',
                      style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 20,
                          foreground: Paint()
                            ..shader = _theme
                                .backgroundGradient()
                                .createShader(Rect.fromLTWH(0, 0, 100, 20)))),
                  color: Colors.white)));
    } else {
      return Container(
          margin: EdgeInsets.all(this._margin),
          width: 0.4 * size.width,
          padding: EdgeInsets.all(2),
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              gradient: _theme.backgroundGradient()),
          child: MaterialButton(
              elevation: 0,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(25)),
              onPressed: _onPressed,
              highlightElevation: 0,
              color: Colors.transparent,
              child: Text(this._text,
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      color: EmbarkSurfaceWhite))));
    }
  }
}
