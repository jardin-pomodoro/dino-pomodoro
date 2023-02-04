import 'package:flutter/material.dart';

const appTitle = 'Dino pomodoro';

class PomodoroTheme {
  static const Color white = Color(0xFFFCF6F5);
  static const Color primary = Color(0xFF0B6623);
  static const Color secondary = Color(0xFF9B5E3C);
  static const Color accent = Color(0xFFB9D7D9);
  static const Color green = Color(0xFF0B6623);
  static const Color red = Color(0xfffa5252);
  static const Color redLight = Color(0xffFFE5E5);
  static const Color yellow = Color(0xfffab005);
  static const Color errorColor = red;

  static const Color background = white;

  static const TextStyle title1 = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
    color: secondary,
  );

  static const TextStyle title2 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: secondary,
  );

  static const TextStyle title3 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: secondary,
  );

  static const TextStyle title4 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: secondary,
  );
  static const TextStyle title4White = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: white,
  );

  static const TextStyle text = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: secondary,
  );


  static const TextStyle textWhite = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: white,
  );

  static const TextStyle textBold = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
    color: secondary,
  );

  static const TextStyle textLarge = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.normal,
    color: secondary,
  );
}
