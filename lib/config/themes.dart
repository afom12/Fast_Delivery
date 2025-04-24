// lib/config/themes.dart
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFFFC1F32);
  static const Color secondaryColor = Color(0xFFFFC700);
  static const Color textColor = Color(0xFF020202);
  static const Color greyColor = Color(0xFF8D92A3);
  static const Color backgroundColor = Color(0xFFFAFAFC);

  static ThemeData get theme => ThemeData(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    textTheme: GoogleFonts.poppinsTextTheme(),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: Colors.white,
      titleTextStyle: GoogleFonts.poppins(
        color: textColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
