import 'dart:io';
import 'package:embark/Pages/Scrapbook/Utils/DateUtils.dart';
import 'package:embark/Pages/Scrapbook/Utils/GeoUtils.dart';
import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:scoped_model/scoped_model.dart';

class ScrapbookInfoModel extends Model {
  DateRange dateRange;
  AddressLine addressLine;

  //The Location is stored in the image
  void addDateAndLocationFromExif(File imageFile) async {
    var bytes = await imageFile.readAsBytes();
    var tags = await readExifFromBytes(bytes);
    bool dateDidChange =  this.dateRange.addDateFromExif(tags);
    bool locationDidChange = this.addressLine.getLocationFromExif(tags);
    if(dateDidChange || locationDidChange){
      this.notifyListeners();
    }
    return;
  }

  String getDateRangeString() {
    return dateRange.toString();
  }

  String getCityAddressLineString() {
    return addressLine.toString();
  }

  ScrapbookInfoModel({dateRange, addressLine}){
    if(dateRange != null){
      this.dateRange = dateRange;
    } else{
      this.dateRange = DateRange();
    }
    if(addressLine != null){
      this.addressLine = addressLine;
    } else{
      this.addressLine = AddressLine();
    }
  }
}
