import 'package:flutter/material.dart';
import 'package:embark/Styles/Colors.dart';
import 'package:embark/Styles/Themes.dart';
import 'LoginPageUtil.dart';
import 'package:embark/Pages/PostcardPage/MyPostcardsPage.dart';
import 'package:embark/Components/Button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:embark/Services/profile.dart';
import 'package:embark/Styles/Icons.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

//Render home Screen
class LoginPage extends StatefulWidget {
  final List<EmbarkTheme> _themes;
  final List<String> _fonts;

  //Set Using Themes
  LoginPage(this._themes,this._fonts);
  @override
  __LoginPageState createState() => __LoginPageState();
}

class __LoginPageState extends State<LoginPage> {
  PageController _backgroundController =
      new PageController(); // make seperate controllers
  PageController _cardController = new PageController(); // for each scrollables
  int _card = 0;
  double _titleOpacity = 1;
  bool _loginLoading =false;
  int AnimationDuration = 400;

  void login(BuildContext context) {

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyPostcardsPage()),
    );
    setState(() {
      _loginLoading = false;
    });
  }
  void _loginFacebook(BuildContext context) async{
    setState(() {
      _loginLoading = true;
    });
    await profile.facebookSignIn();
    login(context);
  }
  void _loginGoogle(BuildContext context) async{
    setState(() {
        _loginLoading = true;
    });
    await profile.googleSignIn();
    login(context);
  }
  Widget _loadingLogin(BuildContext context){
    if (this._loginLoading){
      return SpinKitRing(
        color: widget._themes[_card].secondary.withOpacity(0.7),
        size: 40.0,
      );
    } else {
      return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            EmbarkIconButton(

                facebookTheme,
                    () => _loginFacebook(context),
                " Facebook",
                true,
                EdgeInsets.symmetric(horizontal: 15),
                iconData: facebook,
                fractionalWidth: 0.42),
            EmbarkIconButton(

                googleTheme,
                    () => _loginGoogle(context),
                " Google",
                true,
                EdgeInsets.symmetric(horizontal: 15),
                iconData: google,
                fractionalWidth: 0.42)
          ]);
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    PageList pages = PageList(widget._themes, size);

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: NotificationListener<ScrollNotification>(
            child: Stack(alignment: Alignment.center, children: <Widget>[
              IgnorePointer(
                  child: Container(
                //BACKGROUND
                height: size.height,
                child: ListView(
                  controller: this._backgroundController,
                  scrollDirection: Axis.horizontal,
                  children: pages.getBackgrounds(),
                ),
              )),
              Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //title 1/8
                    Container(
                        height: size.height / 6,
                        child: Align(
                            alignment: Alignment.topCenter,
                            child: AnimatedOpacity(
                                duration:
                                    Duration(milliseconds: AnimationDuration),
                                opacity: _titleOpacity,
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'HelloFrom',
                                        textAlign: TextAlign.center,
                                        style: new TextStyle(
                                            fontFamily: widget._fonts[_card],
                                            fontWeight: FontWeight.w700,
                                            fontSize: 36.0,
                                            color: EmbarkSurfaceWhite),
                                      ),
                                      Text(
                                        'Share your journeys with the world.',
                                        textAlign: TextAlign.center,
                                        style: new TextStyle(
                                            fontFamily: widget._fonts[_card],
                                            fontWeight: FontWeight.w200,
                                            fontSize: 20.0,
                                            color: EmbarkSurfaceWhite),
                                      )
                                    ])))),
                    Container(
                      //BACKGROUND
                      height: size.height / 2,

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
                          Container(
                            height: 50,
                            padding: EdgeInsets.symmetric(
                                horizontal: size.width / 12),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                          color:
                                              widget._themes[_card].primary,
                                          height: 1)),
                                  Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Text("CONTINUE WITH",
                                          style: TextStyle(
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w500,
                                              color: widget._themes[_card]
                                                  .primary,
                                              fontSize: 12))),
                                  Expanded(
                                      flex: 1,
                                      child: Container(
                                          color:
                                              widget._themes[_card].primary,
                                          height: 1)),
                                ]),
                          ),
                          Container(
                            height: 50,
                            child:_loadingLogin(context)
                          )
                        ]))
                  ])
            ]),
            onNotification: (ScrollNotification scrollInfo) {
              // HEY!! LISTEN!!
              // this will set controller1's offset the same as controller2's
              // do nothing on overscroll

              if (scrollInfo is OverscrollNotification ||
                  scrollInfo.metrics.outOfRange ||
                  (_cardController.offset >=
                      _cardController.position.maxScrollExtent)) {
                return;
              }
              _backgroundController.jumpTo(_cardController.offset);
              double normalizedOffsetTwoPlaces =
                  roundDecimal(2, (_cardController.offset) / (size.width));
              int cardNumber =
                  //epsilon to allow for rounding errors
                  normalizedOffsetTwoPlaces.floor();
              double opacityTwoPlaces = roundDecimal(
                  2,
                  (_cardController.offset - size.width * cardNumber) /
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
