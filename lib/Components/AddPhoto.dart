import 'package:flutter/material.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:embark/Styles/Themes.dart';

class AddPhoto extends StatelessWidget {
  Function onSaved = () {};

  AddPhoto(this.onSaved);

  @override
  void _handleAddPhoto() {}

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
                    color: EmbarkExtraLightGray,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
                    onPressed: this._handleAddPhoto,
                        child: Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Icon(Icons.add_photo_alternate,
                                size: 25, color: EmbarkAlmostBlack),
                            Container(
                                child: Container(
                                    width: 90,
                                    child: Text("Add Photo",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            fontFamily: "OpenSans",
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            color: EmbarkAlmostBlack))))
                          ],
                        ))))));
  }
}


