import 'package:flutter/material.dart';

Map<int, Color> _color1 = {
  50: Color.fromRGBO(50, 50, 50, .1),
  100: Color.fromRGBO(50, 50, 50, .2),
  200: Color.fromRGBO(50, 50, 50, .3),
  300: Color.fromRGBO(50, 50, 50, .4),
  400: Color.fromRGBO(50, 50, 50, .5),
  500: Color.fromRGBO(50, 50, 50, .6),
  600: Color.fromRGBO(50, 50, 50, .7),
  700: Color.fromRGBO(50, 50, 50, .8),
  800: Color.fromRGBO(50, 50, 50, .9),
  900: Color.fromRGBO(50, 50, 50, 1),
};

MaterialColor primary = MaterialColor(0xFF171717, _color1);

Map<int, Color> _color2 = {
  50: Color.fromRGBO(232, 58, 96, .1),
  100: Color.fromRGBO(232, 58, 96, .2),
  200: Color.fromRGBO(232, 58, 96, .3),
  300: Color.fromRGBO(232, 58, 96, .4),
  400: Color.fromRGBO(232, 58, 96, .5),
  500: Color.fromRGBO(232, 58, 96, .6),
  600: Color.fromRGBO(232, 58, 96, .7),
  700: Color.fromRGBO(232, 58, 96, .8),
  800: Color.fromRGBO(232, 58, 96, .9),
  900: Color.fromRGBO(232, 58, 96, 1),
};

MaterialColor accentMaterial = MaterialColor(0xFFe83a60, _color2);
