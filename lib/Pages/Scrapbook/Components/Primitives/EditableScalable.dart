import 'package:embark/Pages/Scrapbook/Components/Primitives/Scalable.dart';
import 'package:embark/Pages/Scrapbook/Utils/ScaleController.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:flutter/material.dart';

class EditScaleController extends ScaleController {
  OverlayEntry _overlayEntry;
  bool isVisible = true;

  void hide() {
    isVisible = false;
    this.notifyListeners();
  }

  void overlayWidget(BuildContext context, Widget widget) {
    this.hide();
    this._overlayEntry = this._createOverlayEntry(widget);
    Overlay.of(context).insert(this._overlayEntry);
  }

  OverlayEntry _createOverlayEntry(Widget widget) {
    return OverlayEntry(builder: _getBuilderForWidget(widget));
  }

  void closeOverlay() {
    this.show();
    this.notifyListeners();
    _overlayEntry.remove();
  }

  Function _getBuilderForWidget(Widget widget) {
    Widget _overlayEntryBuilder(context) {
      return Stack(children: [
        GestureDetector(
            onTap: this.closeOverlay,
            child: Container(color: EmbarkColors.black.withOpacity(0.3))),
        Align(alignment: Alignment.center, child: widget)
      ]);
    }

    return _overlayEntryBuilder;
  }

  void show() {
    isVisible = true;
  }

  EditScaleController({initialAngle, initialScale = 1.0, initialOffset})
      : super(
            initialAngle: initialAngle,
            initialScale: initialScale,
            initialOffset: initialOffset);
}

class EditableScalable extends Scalable {
  final Widget overlayWidget;
  final EditScaleController controller;

  EditableScalable({this.overlayWidget, this.controller, child, absorbPointer})
      : assert(overlayWidget != null),
        assert(controller != null),
        assert(child != null),
        super(child: child, absorbPointer: absorbPointer);

  @override
  State createState() {
    return _EditableScalableState();
  }
}

class _EditableScalableState extends State<EditableScalable> {
  //Last focal point in pixels
  OverlayEntry _overlayEntry;
  bool _isVisible;

  @override
  void initState() {
    _isVisible = widget.controller.isVisible;
   widget.controller.addListener((){
     this.setState((){
       _isVisible = widget.controller.isVisible;
     });
   });
    super.initState();
  }

  void onTap() {
    this.setState(() {
      widget.controller.overlayWidget(context, widget.overlayWidget);
    });
  }

  @override
  void dispose() {
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scalable(
        child: Visibility(
            maintainState: true,
            child: widget.child,
            visible: _isVisible),
        controller: widget.controller,
        hitBoxBoundary: widget.hitBoxBoundary,
        absorbPointer: widget.absorbPointer,
        onTap: this.onTap);
  }
}
