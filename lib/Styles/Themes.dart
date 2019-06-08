import 'package:embark/Styles/Colors.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Color hexToColor(String code) {
  return new Color(int.parse(code, radix: 16) + 0xFF000000);
}

//Immutable object representing postcard theme
class EmbarkTheme {
  final Color primary; //darkest
  final Color secondary; //medium
  final Color primaryVariant; //light
  final double hue; //light
  final String name;
  const EmbarkTheme(this.primary, this.secondary, this.primaryVariant,
      {this.hue = 0,this.name});

  LinearGradient postcardGradient() {
    return LinearGradient(
      // Where the linear gradient begins and ends
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      // Add one stop for each color. Stops should increase from 0 to 1
      stops: [0, 1.0],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        EmbarkExtraLightGray.withOpacity(0),
        secondary.withOpacity(0.55),

        //transparent white
      ],
    );
  }

  LinearGradient backgroundGradient() {
    return LinearGradient(
      // Where the linear gradient begins and ends
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      // Add one stop for each color. Stops should increase from 0 to 1
      stops: [1 / 4, 1.0],
      colors: [
        // Colors are easy thanks to Flutter's Colors class.
        EmbarkAlmostWhite,
        secondary,

        //transparent white
      ],
    );
  }
}

const embarkThemeRed = EmbarkTheme(EmbarkRed900, EmbarkRed100, EmbarkRed50,hue: 0, name: "Tuscan Red" );
const embarkThemeBlue =
    const EmbarkTheme(EmbarkBlue900, EmbarkBlue100, EmbarkBlue50, hue: 240, name: "Violet Blue");
const embarkThemePink = const EmbarkTheme(
    EmbarkBrown900, EmbarkPink100, EmbarkPink50, hue: 300, name: "Pretty in Pink");
const embarkThemeGreen =
    const EmbarkTheme(EmbarkGreen900, EmbarkGreen100, EmbarkGreen50, hue: 100, name: "Sea Green");
const embarkThemePurple = const EmbarkTheme(
    EmbarkPurple900, EmbarkPurple100, EmbarkPurple50, hue: 270, name: "Royal Purple");
const embarkTheme = const EmbarkTheme(
    EmbarkAlmostBlack, EmbarkExtraLightGray, EmbarkLightGray, hue: 0, name: "Midnight");
//This necessary because secondary is used for splash
final googleTheme = EmbarkTheme(
  EmbarkRed900,
  EmbarkRed100,
  EmbarkRed50,
);
final facebookTheme = EmbarkTheme(
  EmbarkBlue900,
  EmbarkBlue100,
  EmbarkBlue50,
);

class EmbarkThemes {
  static const List<EmbarkTheme> themes = [
    embarkThemePurple,
    embarkThemeGreen,
    embarkThemeBlue,
    embarkThemePink,
    embarkThemeRed
  ];

  static EmbarkTheme fromIndex(int index) {
    return themes[index];
  }
}


//Create font object
class EmbarkFonts {
  static List<String> names = [
    "Playfair Display",
    "Roboto Mono",
    "Montserrat",
    "Montserrat Alternates",
    "Open Sans"
  ];
  static List<String> fonts = [
    "PlayfairDisplay",
    "RobotoMono",
    "Montserrat",
    "MontserratAlternates",
    "OpenSans"
  ];
  static List<double> yOffsets = [
    -1.0,
    -1.0,
    2.0,
    2.0,
    -1.0,
  ];

  static String fromIndex(int index) {
    return fonts[index];
  }
}
