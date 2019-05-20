import 'package:flutter/material.dart';
import 'colors.dart';
import 'homePageUtil.dart';
import 'signUp.dart';
import 'logIn.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

//Render home Screen
class BackgroundImage extends StatefulWidget {
  List<EmbarkTheme> _themes;

  //Set Using Themes
  BackgroundImage(List<EmbarkTheme> themes) {
    this._themes = themes;
  }

  @override
  _BackgroundImageState createState() => _BackgroundImageState();
}

class _BackgroundImageState extends State<BackgroundImage> {
  PageController _backgroundController =
  new PageController(); // make seperate controllers
  PageController _cardController =
  new PageController(); // for each scrollables
  int _card = 0;
  double _titleOpacity = 1;
  int AnimationDuration = 400;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    PageList pages = PageList(widget._themes, size);

    return Scaffold(
        body: NotificationListener<ScrollNotification>(
          child: Stack(
              overflow: Overflow.visible,
              fit: StackFit.loose,
              children: <Widget>[
                Container(
                  //BACKGROUND
                  height: size.height,
                  child: ListView(
                    controller: this._backgroundController,
                    scrollDirection: Axis.horizontal,
                    children: pages.getBackgrounds(),
                  ),
                ),
                IgnorePointer(
                  //WHITE SHAPE OVERLAY
                  child: CustomPaint(
                    painter: BackgroundPainter(widget._themes[0]),
                    child:
                    Container(height: size.height / 2, width: size.width),
                  ),
                ),
                Padding(
                    //TITLE
                    padding: EdgeInsets.only(top: 25, left: 20.0),
                    child: AnimatedOpacity(
                      duration: Duration(milliseconds: AnimationDuration),
                      opacity: _titleOpacity,
                      child: Text(
                        'Embark',
                        style: new TextStyle(
                            fontFamily: 'PlayfairDisplayBlack',
                            fontSize: 36.0,
                            color: widget._themes[_card].primaryVariant()),
                      ),
                    )),
                Container(
                  //Card Scroller
                  height: size.height,
                  child: PageView(
                    controller: this._cardController,
                    scrollDirection: Axis.horizontal,
                    children: pages.getCards(),
                  ),
                ),
                Positioned(
                  //Login Buttons
                    bottom: 25, left: 10, right: 10,
                    child: AnimatedOpacity(
                        duration: Duration(milliseconds: AnimationDuration),
                        opacity: _titleOpacity,
                        child:  MaterialButton(
                            height: 50,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(6.0)),
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LogIn(widget._themes[_card])),
                              );
                            },
                            child: Text('Log In',
                                style: TextStyle(
                                    fontSize: 20, color: EmbarkSurfaceWhite)),
                            color: widget._themes[_card].primary()))),
                Positioned(
                  //Sign Up Button
                    bottom: 85, left: 10, right: 10,
                    child: AnimatedOpacity(
                        duration: Duration(milliseconds: AnimationDuration),
                        opacity: _titleOpacity,
                        child:  MaterialButton(
                            height: 50,
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(6.0)),
                            onPressed: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => SignUp(widget._themes[_card])),
                              );
                            },
                            child: Text('Sign Up',
                                style: TextStyle(
                                    fontSize: 20, color: EmbarkSurfaceWhite)),
                            color: widget._themes[_card].secondary()))),
              ]
        ),
        onNotification: (ScrollNotification scrollInfo) {
          // HEY!! LISTEN!!
          // this will set controller1's offset the same as controller2's
          _backgroundController.jumpTo(_cardController.offset);
          double normalizedOffsetTwoPlaces = roundDecimal(2,(_cardController.offset) / (size.width ));
          int cardNumber =
          //epsilon to allow for rounding errors
          normalizedOffsetTwoPlaces.floor();
          double opacityTwoPlaces = roundDecimal(2,(_cardController.offset - size.width * cardNumber)/ (size.width ));
          double progress = (1 -
              opacityTwoPlaces);
          if (progress < 0.99) {
            progress = 0;
          } else {
            progress = 1;
          }
          setState(() {
            _card = cardNumber;
            //opacity decreases as you scroll left
            _titleOpacity = progress;
          });
        }));
  }
}

/*
*  Paint background of home page
* */
class BackgroundPainter extends CustomPainter {
  EmbarkTheme _theme;

  BackgroundPainter(EmbarkTheme theme) {
    this._theme = theme;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    // set the color property of the paint
    paint.color = EmbarkBackgroundWhite;
    // create a path
    var startPoint = Offset(0, 6 * size.height / 4);
    var controlPoint1 = Offset(1 * size.width / 4, 10 * size.height / 8);
    var controlPoint2 = Offset(1 * size.width / 2, 2 * size.height / 2);
    var endPoint = Offset(size.width, 6 * size.height / 8);
    // close the path to form a bounded shape
    var path = Path();
    path.moveTo(size.width, size.height * 2);
    path.lineTo(0, size.height * 2);
    path.lineTo(startPoint.dx, startPoint.dy);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);
    canvas.drawPath(path, paint);
    //TODO: DRAW SHADOW
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
