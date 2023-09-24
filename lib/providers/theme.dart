import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final isDarkModeProvider = StateProvider<bool>((ref) {
  return true;
});

class AppTheme {
  static final ThemeData uniLightTheme = ThemeData(
    brightness: Brightness.light,
    sliderTheme: const SliderThemeData(
      trackHeight: 25.0,
      valueIndicatorTextStyle: TextStyle(
        color: Color.fromARGB(255, 41, 40, 41),
        fontWeight: FontWeight.bold,
        fontSize: 15.0,
      ),
      valueIndicatorColor: Colors.grey,
    ),
    scaffoldBackgroundColor: const Color.fromARGB(255, 233, 227, 227),
    primaryColor: Colors.green,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color.fromARGB(255, 239, 237, 237),
      onPrimary: Color.fromARGB(255, 31, 30, 30),
      secondary: Color.fromARGB(255, 179, 192, 216),
      onSecondary: Color.fromARGB(255, 192, 186, 186),
      error: Color.fromARGB(255, 255, 0, 0),
      onError: Color.fromARGB(255, 255, 255, 255),
      background: Color.fromARGB(255, 255, 255, 255),
      onBackground: Color.fromARGB(255, 255, 255, 255),
      surface: Color.fromARGB(255, 255, 255, 255),
      onSurface: Color.fromARGB(255, 255, 255, 255),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Color.fromARGB(
        255,
        97,
        169,
        221,
      ),
      cursorColor: Colors.purple,
    ),
    //Color colorButtonAppBar = Colors.white
  );
  static final ThemeData uniDarkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color.fromARGB(255, 56, 53, 53),
    primaryColor: Colors.green,
    sliderTheme: const SliderThemeData(
      trackHeight: 25.0,
      valueIndicatorTextStyle: TextStyle(
        color: Color.fromARGB(255, 246, 243, 246),
        fontWeight: FontWeight.bold,
        fontSize: 15.0,
      ),
      valueIndicatorColor: Colors.grey,
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color.fromARGB(255, 62, 61, 61),
      onPrimary: Color.fromARGB(255, 255, 255, 255),
      secondary: Color.fromARGB(255, 89, 106, 135),
      onSecondary: Color.fromARGB(255, 94, 92, 92),
      error: Color.fromARGB(255, 220, 15, 15),
      onError: Color.fromARGB(255, 255, 255, 255),
      background: Color.fromARGB(255, 255, 255, 255),
      onBackground: Color.fromARGB(255, 255, 255, 255),
      surface: Color.fromARGB(255, 255, 255, 255),
      onSurface: Color.fromARGB(255, 255, 255, 255),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      selectionColor: Color.fromARGB(
        255,
        97,
        169,
        221,
      ),
      cursorColor: Colors.purple,
    ),
    //Color colorButtonAppBar = Colors.white
  );
}
