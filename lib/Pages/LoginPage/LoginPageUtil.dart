import 'package:flutter/material.dart';
import 'package:embark/Styles/Themes.dart';
import 'package:embark/Components/LoginPostcard.dart';
import 'dart:math';

//list of pages to scroll through
class PageList {
  List<Page> _pages;

  PageList(List<EmbarkTheme> themes, Size size) {
    _pages = new List(themes.length);
    for (var i = 0; i < themes.length; i++) {
      _pages[i] = Page(themes[i], size);
    }
  }

  List<Widget> getBackgrounds() {
    List<Widget> backgrounds = new List(_pages.length);
    for (var i = 0; i < EmbarkThemes.themes.length; i++) {
      backgrounds[i] = _pages[i].getBackground();
    }
    return backgrounds;
  }

  List<Widget> getCards() {
    List<Widget> cards = new List(_pages.length);
    for (var i = 0; i < EmbarkThemes.themes.length; i++) {
      cards[i] = _pages[i].getCard();
    }
    return cards;
  }

  Widget getCard(int i) {
    return _pages[i].getCard();
  }
}

//Page to scroll through
class Page {
  EmbarkTheme _theme;
  Widget _background;
  Widget _card;

  Page(EmbarkTheme theme, Size size) {
    _theme = theme;
    _background = Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(gradient: _theme.backgroundGradient()));
    _card = Container(
        padding: EdgeInsets.only(left: 60, right: 60, bottom: 10, top: 10),
        child: LoginPostcard(_theme));
  }

  Widget getBackground() {
    return _background;
  }

  Widget getCard() {
    return _card;
  }
}

double roundDecimal(int decimals, double d) {
  int fac = pow(10, decimals);
  d = (d * fac).round() / fac;
  return d;
}
