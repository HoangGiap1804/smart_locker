import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF6200EA);
  static const Color secondaryColor = Color(0xFF03DAC6);
  static const Color backgroundColor = Color(0xFFF5F5F5);

  static final TextTheme textTheme = TextTheme(
    headlineLarge: TextStyle(fontSize: 37, fontWeight: FontWeight.bold, color: Colors.black, fontFamily: 'Montserrat'),
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.black, fontFamily: 'Montserrat'),
    headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black, fontFamily: 'Montserrat'),
    titleLarge: TextStyle(fontSize: 37, color: Colors.black, fontFamily: 'Montserrat'),
    titleMedium: TextStyle(fontSize: 24, color: Colors.black, fontFamily: 'Montserrat'),
    titleSmall: TextStyle(fontSize: 18, color: Colors.black, fontFamily: 'Montserrat'),
    bodyLarge: TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'Montserrat'),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.black, fontFamily: 'Montserrat'),
    bodySmall: TextStyle(fontSize: 12, color: Colors.black, fontFamily: 'Montserrat'),
  );

  static final TextTheme textBaner = TextTheme(
    headlineLarge: TextStyle(fontSize: 37, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Montserrat'),
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: 'Montserrat'),
    headlineSmall: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white, fontFamily: 'Montserrat'),
    bodyLarge: TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'Montserrat'),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.white, fontFamily: 'Montserrat'),
    bodySmall: TextStyle(fontSize: 12, color: Colors.white, fontFamily: 'Montserrat'),
  );
  
  static final TextTheme textfield = TextTheme(
    bodyLarge: TextStyle(fontSize: 16, color: Colors.grey, fontFamily: 'Montserrat'),
    bodyMedium: TextStyle(fontSize: 14, color: Colors.grey, fontFamily: 'Montserrat'),
    bodySmall: TextStyle(fontSize: 12, color: Colors.grey, fontFamily: 'Montserrat'),
  );
  static final TextTheme textInk = TextTheme(
    bodyLarge: TextStyle(
      fontSize: 16, 
      color: Color(0xfff83758), 
      fontFamily: 'Montserrat',
      decoration: TextDecoration.underline,
      decorationColor: Colors.red,
      decorationThickness: 2,
    ),
    bodyMedium: TextStyle(
      fontSize: 14, 
      color: Color(0xfff83758), 
      fontFamily: 'Montserrat',
      decoration: TextDecoration.underline
    ),
    bodySmall: TextStyle(
      fontSize: 12, 
      color: Color(0xfff83758), 
      fontFamily: 'Montserrat',
      decoration: TextDecoration.underline
    ),
  );
}
