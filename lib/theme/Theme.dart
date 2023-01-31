import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color darkGrey = Color(0xFF121212);
const Color yellowClr = Color(0xFFFFB746);
const Color pinkClr = Color(0xFFff4667);
const Color darkHeaderClr = Color(0xFF424242);
const blueClr = Color(0xFF4e5ae8);
const Color primaryColor = Color(0xFF487da3);

class Themes {
  static final light = ThemeData(
    backgroundColor: Colors.white,
    primaryColor: primaryColor,
    brightness:  Brightness.light
  );

  static final dark = ThemeData(
    backgroundColor: darkGrey,
    primaryColor: darkGrey,
    brightness: Brightness.dark
  );
}
TextStyle get headingStyle{
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold
      )
  );
}

TextStyle get titleStyle{
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400
      )
  );
}

TextStyle get subTitleStyle{
  return GoogleFonts.lato(
      textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400
      )
  );
}