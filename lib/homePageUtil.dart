import 'package:flutter/material.dart';
import 'colors.dart';
import 'Postcard.dart';
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
    for (var i = 0; i < themes.length; i++) {
      backgrounds[i] = _pages[i].getBackground();
    }
    return backgrounds;
  }

  List<Widget> getCards() {
    List<Widget> cards = new List(_pages.length);
    for (var i = 0; i < themes.length; i++) {
      cards[i] = _pages[i].getCard();
    }
    return cards;
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
        height: size.height, width: size.width, color: theme.secondary());
    PostCardInfo pagePostCardInfo = PostCardInfo("2 hours ago", "Practicing My Spanish", "Cafetaria El Indio, Seville Spain");
    _card =  Postcard(_theme, pagePostCardInfo, 160, size);

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
