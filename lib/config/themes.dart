import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:niu_app/config/colors.dart';

//  LIGHT THEME

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: black2,

  //Background Scaffold
  scaffoldBackgroundColor: backgroundLight,

  //Text Styles
  textTheme: GoogleFonts.afacadTextTheme().apply(
    bodyColor: black2,
    displayColor: black2,
  ),

  //Icons Styles
  iconTheme: const IconThemeData(color: black2),

  //Appbar
  appBarTheme: const AppBarTheme(
    backgroundColor: appbarLight,
    foregroundColor: black2,
  ),

  //Bottom Navigation Bar
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: appbarLight,
    selectedItemColor: black2,
    unselectedItemColor: brown1,
    selectedLabelStyle: GoogleFonts.afacad(fontSize: 12),
    unselectedLabelStyle: GoogleFonts.afacad(fontSize: 10),
  ),

  // Color Scheme
  colorScheme: const ColorScheme.light(
    primary: black2,
    secondary: brown1,
    surface: appbarLight,
    onSurface: black2,
  ),
);

//  DARK THEME

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: lightgrey2,

  //Background Scaffold
  scaffoldBackgroundColor: backgroundDark,

  //Text Styles
  textTheme: GoogleFonts.afacadTextTheme().apply(
    bodyColor: lightgrey1,
    displayColor: lightgrey1,
  ),

  //Icons Styles
  iconTheme: const IconThemeData(color: lightgrey2),

  //Appbar
  appBarTheme: const AppBarTheme(
    backgroundColor: appbarDark,
    foregroundColor: lightgrey1,
  ),

  //Bottom Navigation Bar
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: appbarDark,
    selectedItemColor: lightgrey1,
    unselectedItemColor: brown1,
    selectedLabelStyle: GoogleFonts.afacad(fontSize: 12),
    unselectedLabelStyle: GoogleFonts.afacad(fontSize: 10),
  ),

  // Color Scheme
  colorScheme: const ColorScheme.dark(
    primary: lightgrey2,
    secondary: brown1,
    surface: appbarDark,
    onSurface: lightgrey1,
  ),
);
