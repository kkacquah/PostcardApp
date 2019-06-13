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
  final IconData iconData;
  Icon icon;
  final double fractionalWidth;
  double width;
  final double fontSize;
  final double elevation;
  final String fontFamily;

  //TODO ALLOW changing of fontsize
  EmbarkIconButton(
      this._theme, this._onPressed, this._text, this._outline, this._margin,
      {this.iconData,
      this.fontSize = 22,
        this.width,
      this.fontFamily = "OpenSans",
        this.fractionalWidth = 0.4,
      this.elevation = 1}) {
    if (this.iconData != null) {
      this.icon = Icon(this.iconData,
          size: this.fontSize + 2,
          color: this._outline ? _theme.secondary : EmbarkAlmostWhite);
    }

<<<<<<< HEAD
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
=======
  }
>>>>>>> c61d9e111f67ca40237d9a670fdcbbec38c1bed1

  List<Widget> _innerWidget() {
    if (this.icon == null) {
      return <Widget>[
        Padding(
            padding: EdgeInsets.only(bottom: 2.5),
            child: Text(this._text,
                style: TextStyle(
                    height: 1,
                    fontFamily: this.fontFamily,
                    fontWeight: FontWeight.w700,
                    fontSize: this.fontSize,
                    color: (this._outline
                        ? _theme.secondary
                        : EmbarkAlmostWhite))))
      ];
    } else {
      return <Widget>[
        icon,
        Padding(
            padding: EdgeInsets.only(bottom: 2.5),
            child: Text(this._text,
                style: TextStyle(
                    height: 1,
                    fontFamily: this.fontFamily,
                    fontWeight: FontWeight.w700,
                    fontSize: this.fontSize,
                    color: (this._outline
                        ? _theme.secondary
                        : EmbarkAlmostWhite))))
      ];
    }
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (this.width == null) {
      this.width = size.width * this.fractionalWidth;
    }
    if (_outline) {
      return Container(
          margin: this._margin,
          width: this.width,
          height: 45,
          child: MaterialButton(
              elevation: this.elevation,
              shape: new RoundedRectangleBorder(
                side: BorderSide(color: _theme.secondary),
                borderRadius: new BorderRadius.circular(6),
              ),
              onPressed: _onPressed,
              splashColor: _theme.primary,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: this._innerWidget()),
              color: EmbarkAlmostWhite));
    } else {
      return Container(
          margin: this._margin,
          width: this.width,
          height: 45,
          child: MaterialButton(
              elevation: this.elevation,
              splashColor: _theme.primary,
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(6)),
              onPressed: _onPressed,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: _innerWidget()),
              color: _theme.secondary));
    }
  }
}

<<<<<<< HEAD
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
=======
>>>>>>> c61d9e111f67ca40237d9a670fdcbbec38c1bed1
