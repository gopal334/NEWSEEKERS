import 'package:flutter/material.dart';


import 'colors.dart';

// 🌞 Light Theme
var lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: lightBgColor,
  inputDecorationTheme: InputDecorationTheme(
    fillColor: lightBgColor,
    filled: true,
    enabledBorder: InputBorder.none,
    prefixIconColor: lightLableColor,
    labelStyle: TextStyle(
      fontFamily: "Poppins",
      fontSize: 15,
      color: lightFontColor,
      fontWeight: FontWeight.w500,
    ),
    hintStyle: TextStyle(
      fontFamily: "Poppins",
      fontSize: 15,
      color: lightFontColor,
      fontWeight: FontWeight.w500,
    ),
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      fontFamily: "Poppins",
      fontSize: 15,
      color: lightFontColor,
    ),
  ),
  primaryColor: lightPrimaryColor,
);

// 🌙 Dark Theme
var darkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: darkBgColor,
  inputDecorationTheme: InputDecorationTheme(
    fillColor: darkBgColor,
    filled: true,
    enabledBorder: InputBorder.none,
    prefixIconColor: darkLableColor,
    labelStyle: TextStyle(
      fontFamily: "Poppins",
      fontSize: 15,
      color: darkFontColor,
      fontWeight: FontWeight.w500,
    ),
    hintStyle: TextStyle(
      fontFamily: "Poppins",
      fontSize: 15,
      color: darkFontColor,
      fontWeight: FontWeight.w500,
    ),
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      fontFamily: "Poppins",
      fontSize: 15,
      color: darkFontColor,
    ),
  ),
  primaryColor: darkPrimaryColor,
);
