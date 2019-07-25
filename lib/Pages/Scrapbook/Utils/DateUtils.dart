import 'dart:io';

import 'package:exif/exif.dart';
import 'package:flutter/material.dart';

const String DATETIME_EXIF_KEY = 'Image DateTime';

class DateRange {
  DateTime begin;
  DateTime end;

  @override
  String toString() {
    if (this.begin != null && this.end != null) {
      return "${begin.month}/${begin.day}/${begin.year}-${end.month}/${end.day}/${begin.year}";
    } else if (this.begin != null)
      return "${begin.month}/${begin.day}/${begin.year}";
    else {
      return "";
    }
  }

  bool addDate(DateTime dateTime) {
    bool shouldNotify = false;
    if (begin != null && end != null) {
      //if (begin.isBefore(dateTime) && end.isAfter(dateTime))
      //do nothing
      if (begin.isAfter(dateTime)) {
        this.setBegin(dateTime);
        shouldNotify = true;
      } else if (end.isBefore(dateTime)) {
        this.setEnd(dateTime);
        shouldNotify = true;
      }
    } else if (begin != null) {
      if (begin.isAfter(dateTime)) {
        this.setBegin(dateTime);
        this.setEnd(begin);
        shouldNotify = true;
      } else if (begin.isBefore(dateTime)) {
        this.setEnd(dateTime);
        shouldNotify = true;
      }
    } else {
      //They are both null
      print("Begin Set");
      this.setBegin(dateTime);
      shouldNotify = true;
    }
    return shouldNotify;
  }

  String _formatExifDateTime(String exifDateTime) {
    List<String> splitExifDateTime = exifDateTime.split(" ");
    String date = splitExifDateTime[0];
    String formattedDate = date.replaceAll(":", "");
    String time = splitExifDateTime[1];
    String formattedTime = time.replaceAll(":", "");
    return [formattedDate, formattedTime].join("T");
  }

  bool addDateFromExif(Map<String, IfdTag> tags) {
    if (tags[DATETIME_EXIF_KEY] != null) {
      String exifDateTime = tags[DATETIME_EXIF_KEY].toString();
      String formattedExifDateTime = _formatExifDateTime(exifDateTime);
      return this.addDate(DateTime.parse(formattedExifDateTime));
    } else {
      return false;
    }
  }

  getBegin() {
    if (begin != null) {
      return DateTime.fromMicrosecondsSinceEpoch(begin.millisecondsSinceEpoch);
    } else {
      return null;
    }
  }

  getEnd() {
    if (end != null) {
      return DateTime.fromMicrosecondsSinceEpoch(begin.millisecondsSinceEpoch);
    } else {
      return null;
    }
  }

  setBegin(DateTime begin) {
    this.begin = begin;
  }

  setEnd(DateTime end) {
    this.end = end;
  }

  DateRange({this.begin, this.end}) {
    if (begin != null && end != null) {
      assert(this.begin.isBefore(this.end));
    }
  }
}
