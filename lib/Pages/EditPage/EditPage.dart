import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:embark/Components/EmbarkAppBar.dart';
import 'package:embark/Components/ThemePicker.dart';
import 'package:embark/Components/FontPicker.dart';
import 'package:embark/Components/AddPhoto.dart';
import 'package:embark/Components/editCard.dart';
import 'package:embark/Styles/Themes.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:embark/Services/PostcardInfo.dart';
import 'package:embark/Services/profile.dart';
import 'dart:ui';

class EditPostcardPage extends StatefulWidget {



  @override
  EditPostcardPage();

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditPostcardPageState();
  }
}

class _EditPostcardPageState extends State<EditPostcardPage>{
  final PostcardInfo postcardInfo = PostcardInfo();
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar:EmbarkEditCardAppBar(profile.user.photoUrl),
        body: Stack(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: new NetworkImage(
                      "https://wallpaperplay.com/walls/full/6/0/d/108080.jpg"),
                ),
              )
            ),
            Image.network(
                "https://wallpaperplay.com/walls/full/6/0/d/108080.jpg"),

            Align(
                alignment: Alignment.topRight,
                child: Container(
                    margin: EdgeInsets.only(top: 10, right: 10),
                    child: Column(mainAxisSize: MainAxisSize.max, children: [
                      ThemePicker(
                          onSaved: (int themeID) {
                            setState(() {
                              this.postcardInfo.themeID = themeID;
                              this.postcardInfo.theme =
                                  EmbarkThemes.themes[themeID];
                            });
                          },
                          themeID: this.postcardInfo.themeID),
                      FontPicker(
                          onSaved: (int fontID) {
                            setState(() {
                              this.postcardInfo.fontID = fontID;
                              this.postcardInfo.fontFamily =
                                  EmbarkFonts.fonts[fontID];
                            });
                          },
                          fontID: this.postcardInfo.fontID),
                      AddPhoto((){})
                    ]))),
            EditCard(this.postcardInfo.theme, this.postcardInfo.fontFamily),
          ],
        ),
      ],
    ));
  }
}
