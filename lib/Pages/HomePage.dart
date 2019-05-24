import 'package:flutter/material.dart';
import 'package:embark/Styles/Colors.dart';
import 'homePageUtil.dart';
import 'package:embark/Components/BackgroundShape.dart';
import 'SignUp.dart';
import 'package:embark/Components/Button.dart';
import 'LogIn.dart';
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
  PageController _cardController = new PageController(); // for each scrollables
  int _card = 0;
  double _titleOpacity = 1;
  int AnimationDuration = 400;

  @override
  Widget build(BuildContext context) {
    Function login = () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LogIn(widget._themes[_card])),
      );
    };
    Function signup = () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignUp(widget._themes[_card])),
      );
    };
    Size size = MediaQuery.of(context).size;
    PageList pages = PageList(widget._themes, size);
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: NotificationListener<ScrollNotification>(
            child: Stack(alignment: Alignment.center, children: <Widget>[
              IgnorePointer(child:Container(
                //BACKGROUND
                height: size.height,
                child: ListView(
                  controller: this._backgroundController,
                  scrollDirection: Axis.horizontal,
                  children: pages.getBackgrounds(),
                ),
              )),

              Background(),

              Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                    //title 1/8
                    Container(
                        height: size.height / 8,
                        child: Align(
                            alignment: Alignment.center,
                            child: AnimatedOpacity(
                                duration:
                                    Duration(milliseconds: AnimationDuration),
                                opacity: _titleOpacity,
                                child: Text(
                                  'Embark',
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(
                                      fontFamily: 'PlayfairDisplay',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 36.0,
                                      color: EmbarkSurfaceWhite),
                                )))),
                        Container(
                          //BACKGROUND
                          height: size.height/2,

                          child: PageView(
                            controller: this._cardController,
                            scrollDirection: Axis.horizontal,
                            children: pages.getCards(),
                          ),
                        ),
                    //Buttons 5/8 - 8/8
                    AnimatedOpacity(
                        duration: Duration(milliseconds: AnimationDuration),
                        opacity: _titleOpacity,
                        child: Column(children: <Widget>[
//                          Container(
//                            //Card Scroller 1/8 - 5/8
//                            //TODO: FIX OLD ANIMATION
//                            padding:EdgeInsets.only(left:60, right:60, bottom:70),
//                            height: size.height / 2,
//                            child: pages.getCard(_card)
//                          ),
                          EmbarkButton(widget._themes[_card], login, "Log In",
                              false, EdgeInsets.all(25)),
                          EmbarkButton(
                              widget._themes[_card], signup, "Sign Up", true, EdgeInsets.all(15))
                        ]))
                  ])
            ]),
            onNotification: (ScrollNotification scrollInfo) {
              // HEY!! LISTEN!!
              // this will set controller1's offset the same as controller2's
              _backgroundController.jumpTo(_cardController.offset);
              double normalizedOffsetTwoPlaces =
                  roundDecimal(2, (_backgroundController.offset) / (size.width));
              int cardNumber =
                  //epsilon to allow for rounding errors
                  normalizedOffsetTwoPlaces.floor();
              double opacityTwoPlaces = roundDecimal(
                  2,
                  (_backgroundController.offset - size.width * cardNumber) /
                      (size.width));
              double progress = (1 - opacityTwoPlaces);
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
