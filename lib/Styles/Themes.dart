import 'package:embark/Styles/Colors.dart';
import 'package:flutter/material.dart';
Color hexToColor(String code) {
  return new Color(int.parse(code, radix: 16) + 0xFF000000);
}
//Immutable object representing postcard theme
class EmbarkTheme {
  final Color _primary; //darkest
  final Color _secondary; //medium
  final Color _primaryVariant; //light
  final String _fontFamily; //light
  EmbarkTheme(this._primary, this._secondary,this._primaryVariant,this._fontFamily);
  Color primary(){
    return this._primary;
  }
  Color secondary(){
    return this._secondary;
  }
  String fontFamily(){
    return this._fontFamily;
  }
  static EmbarkTheme fromMap(Map<String,dynamic> inputMap){
    print(inputMap);
    return EmbarkTheme(hexToColor(inputMap["primary"]), hexToColor(inputMap["secondary"]),hexToColor(inputMap["primaryVariant"]),inputMap["fontFamily"]);
  }
  Color primaryVariant(){
    return this._primaryVariant;
  }
  LinearGradient postcardGradient(){
    return  LinearGradient(
      // Where the linear gradient begins and ends
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      // Add one stop for each color. Stops should increase from 0 to 1
      stops: [0, 1.0],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        EmbarkGray.withOpacity(0),
        _secondary.withOpacity(0.55),

        //transparent white
      ],
    );
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



final embarkThemeRed = EmbarkTheme(EmbarkRed900,EmbarkRed100,EmbarkRed50,"Montserrat");
final embarkThemeBlue = EmbarkTheme(EmbarkBlue900,EmbarkBlue100,EmbarkBlue50,"RobotoMono");
final embarkThemePink = EmbarkTheme(EmbarkBrown900,EmbarkPink100,EmbarkPink50, "MontserratAlternates");
final embarkThemeGreen = EmbarkTheme(EmbarkGreen900,EmbarkGreen100,EmbarkGreen50, "OpenSans");
final embarkThemePurple = EmbarkTheme(EmbarkPurple900,EmbarkPurple100,EmbarkPurple50, "PlayfairDisplay");

//This necessary because secondary is used for splash
final googleTheme = EmbarkTheme(EmbarkRed900,EmbarkRed100,EmbarkRed50,"OpenSans");
final facebookTheme = EmbarkTheme(EmbarkBlue900,EmbarkBlue100,EmbarkBlue50,"OpenSans");

var themes  = [embarkThemeRed,embarkThemeBlue,embarkThemePink,embarkThemeGreen,embarkThemePurple];