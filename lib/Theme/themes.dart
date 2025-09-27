import 'package:flutter/material.dart';

class Themedata {
  Themedata._();
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    fontFamily: 'Urbanist',
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.white,
    applyElevationOverlayColor: true,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    fontFamily: 'Urbanist',
    primaryColor: Colors.white,
    scaffoldBackgroundColor: Colors.black,
    applyElevationOverlayColor: true,
  );
}
