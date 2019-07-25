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
    "Montserrat",
    "MontserratAlternates",
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
