import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';

import 'package:embark/Pages/Scrapbook/Components/Primitives/EditableScalable.dart';
import 'package:embark/Pages/Scrapbook/Components/ViewComponents/UIImageWidget.dart';

final cropKey = GlobalKey<CropState>();

// UI Component rendering the corresponding widget
class UIImageEditComponent extends StatefulWidget {
  final ImageScrapbookComponentState state;
  final EditScaleController controller;

  UIImageEditComponent({this.state, this.controller})
      : assert(state != null),
        assert(controller != null);

  @override
  UIImageEditComponentState createState() => UIImageEditComponentState();
}

//State of UI Component rendering the corresponding widget
class UIImageEditComponentState extends State<UIImageEditComponent> {
  File _imageFile;

  @override
  void initState() {
    super.initState();

  }

  Widget _buildCroppingImage() {
    return Column(
      children: <Widget>[
        Expanded(
          child: Crop(
            key: cropKey,
            image:widget.state.imageProvider
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 20.0),
          alignment: AlignmentDirectional.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                child: Text(
                  'Crop Image',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Colors.white),
                ),
                onPressed: () => _cropImage(),
              ),
              _buildOpenImage(),
            ],
          ),
        )
      ],
    );
  }

  Future<void> _cropImage() async {
    Rect area = cropKey.currentState.area;
    double scale = cropKey.currentState.scale;
    if (area == null) {
      // cannot crop, widget is not setup
      return;
    }
    print(area);

    this.setState((){
      widget.state.cropRect = cropKey.currentState.area;
      widget.controller.closeOverlay();
    });

  }

  Widget _buildOpenImage() {
    return FlatButton(
      child: Text(
        'Open Image',
        style: Theme.of(context).textTheme.button.copyWith(color: Colors.white),
      ),
      onPressed: () => {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            color: Colors.black,
            padding:
                const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child: _buildCroppingImage()));
  }
}
