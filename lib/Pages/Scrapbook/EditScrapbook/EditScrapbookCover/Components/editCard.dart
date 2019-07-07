import 'package:embark/Services/ScrapbookInfo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:line_icons/line_icons.dart';
import 'package:embark/Styles/Themes.dart';
import 'package:google_maps_webservice/places.dart';
import 'dart:ui';

const kGoogleApiKey = "AIzaSyCPjtIDmF-EFdN7ucFR2ZwxjhSt9kjaqgk";

// to get places detail (lat/lng)
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: kGoogleApiKey);
final homeScaffoldKey = GlobalKey<ScaffoldState>();
final searchScaffoldKey = GlobalKey<ScaffoldState>();

class EditCard extends StatefulWidget {
  final PostcardInfo _postcardInfo;
  EmbarkTheme _theme;
  String _fontFamily;
  TextStyle _titleStyle;
  TextStyle _titleHintStyle;
  TextStyle _inputStyle;
  TextStyle _hintStyle;
  Function(DateTime date) onSaveDate;
  Function(String status) onSaveStatus;
  Function(String title) onSaveTitle;
  Function(String location) onSaveLocation;
  Function(List<String> tags)  onSaveTags;
  Function(List<String> friends) onSaveFriends;

  //rerendered on theme and fontFamily change
  //TODO: functions that change state will have to be defined in AddScrapbookCover.dart
  EditCard(this._postcardInfo,
  {this.onSaveDate,
    this.onSaveStatus,
    this.onSaveTitle,
    this.onSaveLocation,
    this.onSaveTags,
    this.onSaveFriends,
   }) {
    this._theme = EmbarkThemes.themes[this._postcardInfo.themeID];
    this._fontFamily = EmbarkFonts.fonts[this._postcardInfo.fontID];
    this._titleStyle = TextStyle(
      fontFamily: this._fontFamily,
      color: this._theme.secondary,
      fontSize: 26,
      fontWeight: FontWeight.bold,
    );
    this._titleHintStyle = TextStyle(
      fontFamily: this._fontFamily,
      color: this._theme.secondary.withOpacity(0.4),
      fontSize: 26,
      fontWeight: FontWeight.bold,
    );
    this._inputStyle = TextStyle(
      fontFamily: this._fontFamily,
      color: this._theme.primary.withOpacity(0.4),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
    this._hintStyle = TextStyle(
      fontFamily: this._fontFamily,
      color: this._theme.primary.withOpacity(0.4),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    );
  }

  @override
  _EditCardState createState() {
    return _EditCardState();
  }
}

class _EditCardState extends State<EditCard> {
  void _setDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: widget._postcardInfo.date,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != widget._postcardInfo.date)
      widget.onSaveDate(picked);
  }

  Future<Null> displayPrediction(Prediction p, ScaffoldState scaffold) async {
    if (p != null) {
      // get detail (lat/lng)
      PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
      final lat = detail.result.geometry.location.lat;
      final lng = detail.result.geometry.location.lng;

      scaffold.showSnackBar(
        SnackBar(content: Text("${p.description} - $lat/$lng")),
      );
    }
  }

  Widget _renderLocation() {
    if ( widget._postcardInfo.location != ""){
      return Row(children: <Widget>[
        Icon(
          Icons.location_on,
          color: Colors.grey,
          size: 14,
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
          child: Text(" " + widget._postcardInfo.location + " ",
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w200,
                  fontFamily: widget._fontFamily)),
        )
      ]);
    }
    return Container();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    void onError(PlacesAutocompleteResponse response) {
      homeScaffoldKey.currentState.showSnackBar(
        SnackBar(content: Text(response.errorMessage)),
      );
    }

    Future<void> _setLocation() async {
      // show input autocomplete with selected mode
      // then get the Prediction selected
//      Prediction p = await PlacesAutocomplete.show(
//        context: context,
//        apiKey: kGoogleApiKey,
//        onError: onError,
//        mode: Mode.overlay,
//        language: "en-us",
//        components: [Component(Component.country, "us")],
//      );
//      if(p.description != null){
//        widget.onSaveLocation(p.description);
//      }
    }

    return Positioned(
      bottom: 0,
      width: size.width,
      child: Container(
        decoration: BoxDecoration(
          color: EmbarkAlmostWhite,
          boxShadow: [
            BoxShadow(
                color: EmbarkAlmostBlack.withOpacity(0.25),
                offset: new Offset(0, -2),
                blurRadius: 4)
          ],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(14.0), topRight: Radius.circular(14.0)),
//                border: Border(top: BorderSide)
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 5, 20, 0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Align(
                    alignment: Alignment.center,
                    child: Container(
                        width: size.width * 0.90,
                        child: TextFormField(
                            maxLines: 1,
                            style: widget._titleStyle,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Title',
                              hintStyle: widget._titleHintStyle,
                            )))),
                Row(
                  children: <Widget>[
                    _renderLocation(),
                    Icon(
                      Icons.access_time,
                      color: Colors.grey,
                      size: 14,
                    ),
                    Padding(
                        padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                        child: Text(
                            " ${widget._postcardInfo.date.month}/${widget._postcardInfo.date.day}/${widget._postcardInfo.date.year}",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.w200,
                                fontFamily: widget._fontFamily))),
                  ],
                ),
                Container(
                    width: size.width * 0.90,
                    child: TextFormField(
                      style: widget._inputStyle,
                      maxLength: 150,
                      maxLines: 3,
                      maxLengthEnforced: true,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: widget._hintStyle,
                          hintText: 'Share what you did...'),
                    )),
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
//                      IconButton(
//                          icon: Icon(LineIcons.user_plus,
//                              size: 25, color: EmbarkGray)),
                      IconButton(
                          splashColor: EmbarkLightGray,
                          onPressed: () => _setDate(context),
                          icon: Icon(LineIcons.calendar,
                              size: 25, color: EmbarkGray)),
                      IconButton(
                          splashColor: EmbarkLightGray,
                          onPressed: () => _setLocation(),
                          icon: Icon(LineIcons.map_marker,
                              size: 25, color: EmbarkGray)),
//                      IconButton(
//                          icon: Icon(LineIcons.smile_o,
//                              size: 25, color: EmbarkGray)),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
