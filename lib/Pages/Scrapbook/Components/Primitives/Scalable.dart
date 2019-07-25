import 'package:embark/Pages/Scrapbook/Utils/ScaleController.dart';
import 'package:flutter/material.dart';

class Scalable extends StatefulWidget {
  final Widget child;
  final GestureTapCallback onTap;
  final ScaleController controller;
  final double hitBoxBoundary;
  final bool absorbPointer;

  Scalable(
      {this.child,
      this.onTap,
      this.hitBoxBoundary = 0,
      this.absorbPointer = false,
      this.controller})
      : assert(child != null);

  @override
  State createState() {
    return _ScalableState();
  }
}

class _ScalableState extends State<Scalable> {
  //Last focal point in pixels
  Offset _offset;
  double _angle;



  void initState() {
    super.initState();
    _offset = widget.controller.initialOffset;
    _angle = widget.controller.initialAngle;
    widget.controller.addListener(() {
      this.setState(() {
        _offset = widget.controller.scaleState.offset;
        _angle = widget.controller.scaleState.angle;
      });
    });
  }

  Widget renderWithAbsorbedPointer() {
    return Transform.rotate(
        angle: _angle,
        child:
            //background
            GestureDetector(
                onTap: widget.onTap,
                onScaleStart: widget.controller.onScaleStart,
                onScaleUpdate: widget.controller.onScaleUpdate,
                onScaleEnd: widget.controller.onScaleEnd,
                child: Container(
                    child: Container(
                        color: Colors.transparent,
                        child: Container(
                          child: widget.child,
                        )))));
  }

  Widget renderWithUnabsorbedPointer() {
    return Transform.rotate(
        angle: _angle,
        child: Stack(alignment: Alignment.center, children: [
          //background
          GestureDetector(
              onTap: widget.onTap,
              onScaleStart: widget.controller.onScaleStart,
              onScaleUpdate: widget.controller.onScaleUpdate,
              onScaleEnd: widget.controller.onScaleEnd,
              child: Container(
                  color: Colors.transparent,
                  child: Container(
                    child: widget.child,
                  ))),
          widget.child,
        ]));
  }

  @override
  Widget build(BuildContext context) {
      return Positioned(
          left: _offset.dx,
          top: _offset.dy,
          child: widget.absorbPointer
              ? this.renderWithAbsorbedPointer()
              : this.renderWithUnabsorbedPointer());

  }
}
