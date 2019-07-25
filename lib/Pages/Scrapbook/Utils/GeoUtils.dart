import 'package:exif/exif.dart';
import 'package:geocoder/geocoder.dart';

const String LATITUDE_REF_EXIF_KEY = 'GPS GPSLatitudeRef';
const String LATITUDE_EXIF_KEY = 'GPS GPSLatitude';
const String LONGITUDE_REF_EXIF_KEY = 'GPS GPSLongitudeRef';
const String LONGITUDE_EXIF_KEY = 'GPS GPSLongitude';

Future<String> getLocationFromExifCore(Map<String, IfdTag> tags) async {
  //initial "null" value.
  String addressLine = "";
  if (tags[LATITUDE_REF_EXIF_KEY] != null) {
    String latitudeDirection = tags[LATITUDE_REF_EXIF_KEY].toString();
    String latitudeList = tags[LATITUDE_EXIF_KEY].toString();
    String longitudeDirection = tags[LONGITUDE_REF_EXIF_KEY].toString();
    String longitudeList = tags[LONGITUDE_EXIF_KEY].toString();
    double latitude =
        _latitudeExifFormatToDouble(latitudeDirection, latitudeList);
    double longitude =
        _longitudeExifFormatToDouble(longitudeDirection, longitudeList);
    Coordinates exifCoordinates = Coordinates(latitude, longitude);
    print(exifCoordinates);
    List<Address> addresses =
        await Geocoder.local.findAddressesFromCoordinates(exifCoordinates);
    addressLine = addresses.first.addressLine;
    List<String> addressStringList = addressLine.split(",");
    String city = addressStringList[1];
    //removing leading state.
    city = city.substring(1);
    //Remov zipcode
    String state = addressStringList[2];
    state = state.split(" ")[1];
    addressLine = [city, state].join(", ");
    return addressLine;
  } else {
    return addressLine;
  }
}

double _parseFraction(String fraction) {
  List<String> splitFraction = fraction.split("/");
  return double.parse(splitFraction[0]) / double.parse(splitFraction[1]);
}

double _coordinateListToDouble(String coordinateList) {
  String _strippedCoordinateList =
      coordinateList.substring(1, coordinateList.length - 1);
  List<String> _coordinateDMS = _strippedCoordinateList.split(",");
  _coordinateDMS.forEach((element) => print(element));
  double _degrees = double.parse(_coordinateDMS[0]);
  double _minutes = double.parse(_coordinateDMS[1]);
  double _seconds = _parseFraction(_coordinateDMS[2]);
  double _decimalDegrees = _degrees + (_minutes / 60.0) + (_seconds / 3600.0);
  return _decimalDegrees;
}

double _latitudeExifFormatToDouble(
    String latitudeDirection, String latitudeList) {
  double _decimalDegrees = _coordinateListToDouble(latitudeList);
  //if not north, is south
  bool _isNorth = latitudeDirection == "N";
  return _isNorth ? _decimalDegrees : -_decimalDegrees;
}

double _longitudeExifFormatToDouble(
    String longitudeDirection, String longitudeList) {
  double _decimalDegrees = _coordinateListToDouble(longitudeList);
  //if not north, is south
  bool _isEast = longitudeDirection == "E";
  return _isEast ? _decimalDegrees : -_decimalDegrees;
}

class AddressLine {
  String addressLineString = "";

  bool getLocationFromExif(Map<String, IfdTag> tags) {

    String originalAddressLineString = addressLineString;
    getLocationFromExifCore(tags).then((value){
      addressLineString = value;
    });
    //return true only if the address line has changed.
    return (originalAddressLineString != addressLineString);
  }

  String toString(){
    return addressLineString;
  }
}
