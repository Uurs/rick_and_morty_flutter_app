import 'package:flutter/material.dart';

const textTheme = TextTheme(
  headlineLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  headlineMedium: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
  headlineSmall: TextStyle(fontSize: 18.0, fontFamily: 'Georgia'),
  bodyLarge: TextStyle(fontSize: 18.0, fontFamily: 'Georgia'),
  bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Georgia'),
  bodySmall: TextStyle(fontSize: 12.0, fontFamily: 'Georgia'),
  labelLarge: TextStyle(fontSize: 18.0, fontFamily: 'Georgia'),
  labelMedium: TextStyle(fontSize: 14.0, fontFamily: 'Georgia'),
  labelSmall: TextStyle(fontSize: 12.0, fontFamily: 'Georgia'),
);

final lightAppTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
  textTheme: textTheme,
);

final darkAppTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blue,
  textTheme: textTheme,
);