import 'package:flutter/material.dart';

class Rang{

  // Base colors
  static const int _primaryColor = 0xFF0ea982;
  static const int _secondaryColor = 0xFF202123;
  static const int _darkColor = 0xFF343541;
  static const int _darkSecondaryColor = 0xFF444654;
  static const int _accentColor = 0xFF715fde;
  static const int _whiteColor = 0xFFFFFFFF;
  static const int _textColor = 0xFFececf1;

  // Primary colors
  static const primaryColor = Color(_primaryColor);
  static const accentColor = Color(_accentColor);

  // Universal colors
  static const whiteColor = Color(_whiteColor);
  static const blackColor = Color(_darkColor);

  // Background colors
  static const backgroundColor = Color(_darkColor);
  static const cardBackgroundColor = Color(_darkSecondaryColor);
  
  // Text colors
  static const textColor = Color(_textColor);
  static const hintTextColor = Color.fromARGB(150, 236, 236, 241);
}