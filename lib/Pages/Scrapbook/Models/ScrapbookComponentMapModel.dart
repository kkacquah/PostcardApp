import 'dart:collection';

import 'package:embark/Pages/Scrapbook/Components/ViewComponents/ScrapbookComponent.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ScrapbookComponentMapModel extends Model{
  LinkedHashMap<UniqueKey, ScrapbookComponent> components;
  

  void addScrapbookComponent(UniqueKey key, ScrapbookComponent scrapbookComponent){
    components.putIfAbsent(key, () => scrapbookComponent);
  }
  void removeScrapbookComponent(UniqueKey key){
    components.remove(key);
  }


  ScrapbookComponentMapModel({initialComponents}){
    if(components != null){
      components = initialComponents;
    } else {
      components = new LinkedHashMap<UniqueKey, ScrapbookComponent>();
    }
  }
}