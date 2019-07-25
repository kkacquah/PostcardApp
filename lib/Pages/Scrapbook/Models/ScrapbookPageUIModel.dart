

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class ScrapbookPageUIModel extends Model {
  Offset _componentDragPointerPosition;

  Offset getComponentDragPointerPosition(){
    if(_componentDragPointerPosition != null){
      return Offset(_componentDragPointerPosition.dx, _componentDragPointerPosition.dy);
    } else {
      return null;
    }

  }
  setComponentDragPointerPosition(Offset pointerPosition){
    if(pointerPosition != null){
      Offset copiedPointerPosition = Offset(pointerPosition.dx, pointerPosition.dy);
      _componentDragPointerPosition = copiedPointerPosition;
    } else {
      _componentDragPointerPosition = null;
    }

    this.notifyListeners();
  }
}