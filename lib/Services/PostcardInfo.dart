import 'package:embark/Styles/Themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const geoPointZero = GeoPoint(0, 0);
const timestampZero = Timestamp;
const sentimentsZero = [];

class PostcardInfo {
  String title;
  String uid;
  String photoUrl;
  String location;
  int themeID;
  EmbarkTheme theme;
  int fontID;
  String fontFamily;
  double aspectRatio;
  List<dynamic> sentiments;
  GeoPoint geopoint;
  Timestamp timestamp;
  String status;

  //Other Characteristics to set later go to DB and set later
  PostcardInfo(
      {this.title = "",
      this.uid = "",
      this.photoUrl = "",
      this.location = "",
      this.themeID = 0,
      this.fontID = 0,
      this.aspectRatio = 1,
      this.sentiments = sentimentsZero,
      this.geopoint = geoPointZero,
      this.timestamp,
      this.status = ""}) {
    theme = EmbarkThemes.themes[this.themeID];
    fontFamily = EmbarkFonts.fonts[this.fontID];
    if (this.timestamp == null) {
      timestamp = Timestamp.now();
    }
  }

  @override
  String toString() {
    return "{title: ${this.title}, uid: ${this.uid},photoUrl: ${this.photoUrl},location: ${this.location}, themeID: ${this.theme},fontFamily: ${this.fontFamily}, aspectRatio: ${this.aspectRatio}}";
  }
}
