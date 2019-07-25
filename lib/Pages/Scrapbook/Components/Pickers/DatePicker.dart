import 'package:embark/Pages/Scrapbook/Components/Primitives/ShadowIcon.dart';
import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.centerRight,
        child: Container(
            height: (50 * (2 / 3)),
            width: (50 * (2 / 3)),
            child: ShadowIcon(icon: Icons.calendar_today)));
  }
}
