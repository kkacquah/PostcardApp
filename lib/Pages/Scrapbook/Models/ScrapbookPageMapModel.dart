import 'dart:collection';
import 'package:embark/Pages/Scrapbook/Components/ViewComponents/ScrapbookPage.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ScrapbookPageMapModel extends Model {
  LinkedHashMap<UniqueKey, ScrapbookPage> scrapbookPages;

  void addScrapbookComponent(UniqueKey key, ScrapbookPage scrapbookPage) {
    scrapbookPages.putIfAbsent(key, () => scrapbookPage);
  }

  void removeScrapbookComponent(UniqueKey key) {
    scrapbookPages.remove(key);
  }


  ScrapbookPageMapModel({pages}) {
    if (this.scrapbookPages != null) {
      this.scrapbookPages = pages;
    } else {
      this.scrapbookPages = LinkedHashMap<UniqueKey, ScrapbookPage>();
    }
  }
}