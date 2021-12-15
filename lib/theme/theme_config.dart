import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(

  appBarTheme: AppBarTheme(brightness: Brightness.dark),
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  primaryColor: Color(0xFF2E2E3D),
  scaffoldBackgroundColor: Color(0xFF2f2e3c),
  appBarTheme: AppBarTheme(color: Color(0xFF494a5f)),
 
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: Colors.white, // This is a custom color variable
    ),
  ),
 
  brightness: Brightness.dark,
  dialogTheme: DialogTheme(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30),
    ),
  ),
);
