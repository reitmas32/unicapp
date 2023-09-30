import 'package:flutter/material.dart';

abstract final class BordersRadius {
  static final br100 = BorderRadius.circular(5);
  static final br200 = BorderRadius.circular(8);
  static final br300 = BorderRadius.circular(10);
  static final br400 = BorderRadius.circular(12);
  static final br500 = BorderRadius.circular(14);
  static final br600 = BorderRadius.circular(17);
  static final br700 = BorderRadius.circular(20);
  static final br800 = BorderRadius.circular(25);
  static final br900 = BorderRadius.circular(30);
}

abstract final class Paddings {
  static const p100 = EdgeInsets.all(5.0);
  static const p200 = EdgeInsets.all(8.0);
  static const p300 = EdgeInsets.all(12.0);
  static const p400 = EdgeInsets.all(16.0);
  static const p500 = EdgeInsets.all(18.0);
  static const p600 = EdgeInsets.all(20.0);
  static const p700 = EdgeInsets.all(25.0);
  static const p800 = EdgeInsets.all(30.0);
  static const p900 = EdgeInsets.all(35.0);

  static const pVertical100 = EdgeInsets.symmetric(vertical: 5.0);
  static const pVertical200 = EdgeInsets.symmetric(vertical: 8.0);
  static const pVertical300 = EdgeInsets.symmetric(vertical: 12.0);
  static const pVertical400 = EdgeInsets.symmetric(vertical: 16.0);
  static const pVertical500 = EdgeInsets.symmetric(vertical: 18.0);
  static const pVertical600 = EdgeInsets.symmetric(vertical: 20.0);
  static const pVertical700 = EdgeInsets.symmetric(vertical: 25.0);
  static const pVertical800 = EdgeInsets.symmetric(vertical: 30.0);
  static const pVertical900 = EdgeInsets.symmetric(vertical: 35.0);

  static const pHorizontal100 = EdgeInsets.symmetric(horizontal: 5.0);
  static const pHorizontal200 = EdgeInsets.symmetric(horizontal: 8.0);
  static const pHorizontal300 = EdgeInsets.symmetric(horizontal: 12.0);
  static const pHorizontal400 = EdgeInsets.symmetric(horizontal: 16.0);
  static const pHorizontal500 = EdgeInsets.symmetric(horizontal: 18.0);
  static const pHorizontal600 = EdgeInsets.symmetric(horizontal: 20.0);
  static const pHorizontal700 = EdgeInsets.symmetric(horizontal: 25.0);
  static const pHorizontal800 = EdgeInsets.symmetric(horizontal: 30.0);
  static const pHorizontal900 = EdgeInsets.symmetric(horizontal: 35.0);
}

abstract final class CustomColors {
  static const Color snackBarBgDark = Color.fromARGB(255, 35, 34, 34);
  static const Color snackBarBgLight = Color.fromARGB(255, 199, 197, 197);

  static const Color cardBgDark = Color.fromARGB(255, 35, 34, 34);
  static const Color cardBgLight = Color.fromARGB(255, 199, 197, 197);

  static const Color textDark = Color.fromARGB(255, 199, 197, 197);
  static const Color textLight = Color.fromARGB(255, 35, 34, 34);
}
