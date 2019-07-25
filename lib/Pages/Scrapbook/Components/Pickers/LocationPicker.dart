import 'package:embark/Pages/Scrapbook/Components/Primitives/ShadowIcon.dart';
import 'package:flutter/material.dart';

class LocationPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: Container(
            height: (50 * (2 / 3)),
            width: (50 * (2 / 3)),
            alignment: Alignment.centerRight,
            child: ShadowIcon(icon: Icons.location_on)));
  }
}
