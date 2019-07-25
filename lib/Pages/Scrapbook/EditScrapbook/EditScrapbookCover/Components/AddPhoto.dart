import 'package:flutter/material.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:line_icons/line_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddPhoto extends StatelessWidget {
  Function onSaved;

  AddPhoto(this.onSaved);

  Future _handleAddPhoto() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.onSaved(image);
  }

  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Align(
            alignment: Alignment.topRight,
            child: Container(
                height: 50,
                width: 50 * (2 / 3) + 90,
                child: MaterialButton(
                    padding: EdgeInsets.all(0),
                    elevation: 1.0,
                    color: EmbarkColors.extraLightGray,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
                    onPressed: this._handleAddPhoto,
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(LineIcons.photo,
                                size: 25, color: EmbarkColors.black),
                            Container(
                                child: Container(
                                    width: 82,
                                    child: Text("Photo",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "OpenSans",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18,
                                            color: EmbarkColors.black))))
                          ],
                        ))))));
  }
}


