import 'package:flutter/material.dart';
const EmbarkSurfaceWhite = const Color(0xFFFFFBFA);
const EmbarkSurfaceWhiteTransparent70 = const Color(0xB2FFFBFA);
const EmbarkBackgroundWhite = Colors.white;
const Black = const Color(0xFF000000);
const EmbarkGray = const Color(0x66000000);
const Transparent = const Color(0x00000000);


//Light Colors for titles
const EmbarkPurple900 = const Color(0xFF28264B);
const EmbarkPurple100 = const Color(0xFF4E40B9);
const EmbarkPurple50 = const Color(0xFFE3DFFF);

const EmbarkBrown900 = const Color(0xFF442B2D);
const EmbarkPink100 = const Color(0xFFF8B9C2);
const EmbarkPink50 = const Color(0xFFFEEAE6);

const EmbarkBlue900 = const Color(0xFF080c2a);
const EmbarkBlue100 = const Color(0xFF3F51B5);
const EmbarkBlue50 = const Color(0xFFE8EAF6);

const EmbarkRed900 = const Color(0xFF141301);
const EmbarkRed100 = const Color(0xFFAD0000);
const EmbarkRed50 = const Color(0xFFFFD9DA);

const FacebookBlue = const Color(0xFF3C5A99);
const GoogleRed = const Color(0xFFDB4437);


class EmbarkTheme {
  Color _primary; //darkest
  Color _secondary; //medium
  Color _primaryVariant; //light
  Shader _titleGradient;
  EmbarkTheme(Color primary, Color secondary, Color primaryVariant) {
    this._primary = primary;
    this._secondary = secondary;
    this._primaryVariant = primaryVariant;
  }
  Color primary(){
    return this._primary;
  }
  Color secondary(){
    return this._secondary;
  }
  Color primaryVariant(){
    return this._primaryVariant;
  }
  LinearGradient backgroundGradient(){
    return  LinearGradient(
      // Where the linear gradient begins and ends
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      // Add one stop for each color. Stops should increase from 0 to 1
      stops: [1/4, 1.0],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        Colors.white,
        _secondary,

        //transparent white
      ],
    );
  }
}



final embarkThemePurple = EmbarkTheme(EmbarkPurple900,EmbarkPurple100,EmbarkPurple50);
final embarkThemePink = EmbarkTheme(EmbarkBrown900,EmbarkPink100,EmbarkPink50);
final embarkThemeBlue = EmbarkTheme(EmbarkBlue900,EmbarkBlue100,EmbarkBlue50);
final embarkThemeRed = EmbarkTheme(EmbarkRed900,EmbarkRed100,EmbarkRed50);
final googleTheme = EmbarkTheme(EmbarkRed900,GoogleRed,EmbarkRed50);
final facebookTheme = EmbarkTheme(EmbarkBlue900,FacebookBlue,EmbarkBlue50);
var themes  = [embarkThemePurple,embarkThemePink,embarkThemeRed,embarkThemeBlue];
