import 'package:embark/Styles/Themes.dart';

class PostcardInfo {
  String title;
  String uid;
  String photoUrl;
  String location;
  EmbarkTheme theme;
  double aspectRatio;

  //Other Characteristics to set later go to DB and set later
  PostcardInfo(this.title, this.uid, this.photoUrl, this.location,
      this.theme, this.aspectRatio);

  @override
  String toString() {
    return "{title: ${this.title}, uid: ${this.uid},photoUrl: ${this
        .photoUrl},location: ${this.location}, fontFamily: ${this
        .theme}, aspectRatio: ${this.aspectRatio}}";
  }
}
