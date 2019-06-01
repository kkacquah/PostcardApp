import 'package:embark/Styles/Themes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostcardInfo {
  String title;
  String uid;
  String photoUrl;
  String location;
  EmbarkTheme theme;
  double aspectRatio;
  List<dynamic> sentiments;
  GeoPoint geopoint;
  Timestamp timestamp;
  String status;

  //Other Characteristics to set later go to DB and set later
  PostcardInfo(this.title, this.uid, this.photoUrl, this.location,
      this.theme, this.aspectRatio, this.sentiments, this.geopoint, this.timestamp, this.status);

  @override
  String toString() {
    return "{title: ${this.title}, uid: ${this.uid},photoUrl: ${this
        .photoUrl},location: ${this.location}, fontFamily: ${this
        .theme}, aspectRatio: ${this.aspectRatio}}";
  }
}
