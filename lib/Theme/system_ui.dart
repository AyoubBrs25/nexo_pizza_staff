import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void configureSystemUIOverlay(BuildContext context) {
  final brightness = Theme.of(context).brightness;
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors
          .transparent /*brightness == Brightness.light ? Colors.white : Colors.black*/,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarContrastEnforced: true,
      systemStatusBarContrastEnforced: true,
      statusBarBrightness: brightness,
      statusBarIconBrightness: brightness == Brightness.light
          ? Brightness.dark
          : Brightness.light,
      systemNavigationBarIconBrightness: brightness == Brightness.light
          ? Brightness.dark
          : Brightness.light,
    ),
  );
}
