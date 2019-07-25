import 'package:embark/Pages/Scrapbook/Components/EditComponents/UIImageWidgetEdit.dart';
import 'package:embark/Pages/Scrapbook/Components/ViewComponents/ScrapbookComponent.dart';
import 'package:embark/Styles/Colors.dart';
import 'dart:ui' as ui;
import 'package:embark/Styles/Paintings.dart';
import 'package:flutter/material.dart';
import 'package:embark/Pages/Scrapbook/Components/Primitives/EditableScalable.dart';

const Color IMAGE_BORDER_COLOR = EmbarkColors.white;
const double IMAGE_BORDER_WIDTH = 10;

//Mutable object representing ImageScrapbookComponentState
class ImageScrapbookComponentState extends ScrapbookComponentState {
  @override
  bool deleted;

  //Fractional rect
  Rect cropRect;
  double originalHeight;
  double originalWidth;
  ImageProvider imageProvider;

  ImageScrapbookComponentState(
      key,
      {this.cropRect = Rect.zero,
      this.imageProvider,
      this.originalHeight,
      this.originalWidth,
        scale,
      offset,
      angle})
      : assert(imageProvider != null),

        assert(cropRect != null),
        super(key, offset: offset, angle: angle, scale:scale);
}

//ImageScrapbookComponent put on stack
class ImageScrapbookComponent extends ScrapbookComponent {
  ImageScrapbookComponent({state, opacity}) : super(state: state);

  @override
  StatefulWidget getUIComponent(double opacity) {
    return UIImageComponent(state: this.state);
  }
}

// UI Component rendering the corresponding widget
class UIImageComponent extends StatefulWidget {
  final ImageScrapbookComponentState state;

  UIImageComponent({this.state}) : assert(state != null);

  @override
  UIImageComponentState createState() => UIImageComponentState();
}

//State of UI Component rendering the corresponding widget
class UIImageComponentState extends State<UIImageComponent> {
  OverlayEntry _overlayEntry;
  EditScaleController _controller;
  double width;
  double height;
  double scale;
  double borderWidth;
  double initialBorderWidth;
  Future<ui.Image> _decodedImage;

  @override
  void initState() {
    super.initState();
    double initialWidth =
        widget.state.cropRect.width * widget.state.originalWidth;
    double initialHeight =
        widget.state.cropRect.height * widget.state.originalHeight;
    width = initialWidth;
    height = initialHeight;
    this._controller = EditScaleController(
        initialAngle: widget.state.angle,
        initialOffset: widget.state.offset,
        initialScale: widget.state.scale
    )
      ..addListener(() {
        this.setState(() {
          scale = _controller.scaleState.scale;
          width = initialWidth * scale;
          height = initialHeight * scale;
        });
      });
    this._decodedImage =
        decodeImageFromImageProvider(widget.state.imageProvider);
  }

  OverlayEntry _createOverlayEntry() {
    RenderBox renderBox = context.findRenderObject();
    var size = renderBox.size;
    var offset = renderBox.localToGlobal(Offset.zero);

    return OverlayEntry(
        builder: (context) =>
            Center(child: Container(width: 100, height: 100)));
  }

  void _overlayTextField() {
    this._overlayEntry = this._createOverlayEntry();
    Overlay.of(context).insert(this._overlayEntry);
  }

  @override
  void dispose() {
    super.dispose();
    this._controller.dispose();
  }

  Future<ui.Image> decodeImageFromImageProvider(ImageProvider imageProvider) {
    ui.Image decodedImage;
    FileImage fileImageProvider = imageProvider as FileImage;
    return decodeImageFromList(fileImageProvider.file.readAsBytesSync());
  }

  Widget _getImageWidget() {
    final double xOffset = widget.state.cropRect.left;
    final double yOffset = widget.state.cropRect.top;

    return FutureBuilder<ui.Image>(
        future: _decodedImage, // a Future<String> or null
        builder: (BuildContext context, AsyncSnapshot<ui.Image> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return new Container();
            case ConnectionState.waiting:
              return Container();
            default:
              if (snapshot.hasError)
                return Container();
              else
                return Material(
                    elevation: 1.0,
                    child: Container(
                        width: widget.state.cropRect.width * width,
                        height: widget.state.cropRect.height * height,
                        child: CustomPaint(
                            foregroundPainter: ImagePainter(
                                fractionalCropRect: widget.state.cropRect,
                                image: snapshot.data)),
                        decoration: BoxDecoration(
                            border: Border.fromBorderSide(BorderSide(
                                color: EmbarkColors.white,
                                width: IMAGE_BORDER_WIDTH)))));
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return EditableScalable(
        controller: this._controller,
        absorbPointer: true,
        overlayWidget: UIImageEditComponent(
            state: widget.state, controller: this._controller),
        child: _getImageWidget());
  }
}
