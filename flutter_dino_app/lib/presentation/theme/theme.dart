import 'package:flutter/material.dart';

const appTitle = 'Dino pomodoro';

final themeData = ThemeData(
  brightness: Brightness.dark,
  primaryColor: Colors.green,
  fontFamily: 'Roboto',
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.green,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
  ),
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
    contentPadding:
        const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
  ),
);