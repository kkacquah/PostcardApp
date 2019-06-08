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
  PostcardInfo postcardInfo = PostcardInfo();


  @override
  EditPostcardPage();

  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditPostcardPageState();
  }
}

class _EditPostcardPageState extends State<EditPostcardPage> {
  bool _inputFocused;
  double _getOpacity(){
    print(this._inputFocused);
    return this._inputFocused ? 0.0 : 1.0;
  }
  KeyboardVisibilityNotification _keyboardVisibility = new KeyboardVisibilityNotification();
  int _keyboardVisibilitySubscriberId;

  @protected
  void initState() {
    super.initState();
    print("state initialized");

    _inputFocused = _keyboardVisibility.isKeyboardVisible;
    _keyboardVisibilitySubscriberId = _keyboardVisibility.addNewListener(
        onChange: (bool visible) {
          print("made a state change");
          this._inputFocused = visible;
        }
    );
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed
    _keyboardVisibility.removeListener(_keyboardVisibilitySubscriberId);
    super.dispose();
  }
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
                              widget.postcardInfo.themeID = themeID;
                              widget.postcardInfo.theme =
                                  EmbarkThemes.themes[themeID];
                            });
                          },
                          themeID: widget.postcardInfo.themeID),
                      FontPicker(
                          onSaved: (int fontID) {
                            setState(() {
                              widget.postcardInfo.fontID = fontID;
                              widget.postcardInfo.fontFamily =
                                  EmbarkFonts.fonts[fontID];
                            });
                          },
                          fontID: widget.postcardInfo.fontID),
                      AddPhoto((){})
                    ]))),
            EditCard(widget.postcardInfo.theme, widget.postcardInfo.fontFamily),
          ],
        ),
      ],
    ));
  }
}
