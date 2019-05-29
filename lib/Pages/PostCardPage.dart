import 'package:flutter/material.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:embark/Styles/Themes.dart';
import 'package:embark/Components/Button.dart';
import 'package:embark/Services/authentication.dart';
import 'package:embark/Styles/Icons.dart';

import 'package:flutter/material.dart';

class PostCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Welcome to Flutter'),
        ),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
