import 'package:flutter/material.dart';

class AppColors {
  static const Color primary1 = Color.fromRGBO(46, 52, 175, 1); // Pastel red #FF6A5F
  static const Color primary2 = Color(0xFFBF5C5C); // Muted pastel red
  static const Color primary3 = Color(0xFFE3B7B7); // Light pastel red
  static const Color secondary1 = Color(0xFF465A54); // Dark green #465A54
  static const Color secondary2 = Color(0xFF6B8E6F); // Muted olive green
  static const Color tertiary = Color(0xFF252F2C); // Deeper green #252F2C
  static const Color text1 = Color(0xFF465A54); // #203061
  static const Color text2 = Color(0xFF394944); // #48547C
  static const Color text3 = Color(0xFF252525); // #8D93A3
  static const Color text4 = Color(0xFFFAFAF9); // #F9FAFC
  static const Color cardColor = Color(0xFFEBEBE6);
  static const Color offwhite = const Color(0xFFE0E0E0);
}

final ThemeData lightTheme = ThemeData(
    primaryColor: AppColors.primary1,
    primaryColorDark: Colors.black,
    colorScheme: ColorScheme.light(
      tertiary: AppColors.tertiary,
      primary: AppColors.primary1,
      secondary: AppColors.secondary1,
      background: AppColors.text4,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: AppColors.text1,
      onSurface: AppColors.text2,
    ),
    scaffoldBackgroundColor: const Color.fromARGB(255, 237, 237, 234),
    appBarTheme: AppBarTheme(
          surfaceTintColor: Colors.white,
      backgroundColor: AppColors.cardColor,
      foregroundColor: AppColors.text4,
      iconTheme: IconThemeData(
        color: AppColors.text3,
      ),
      titleTextStyle: TextStyle(
        fontFamily: 'Urbanist',
        color: AppColors.text3,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      toolbarTextStyle: TextStyle(
        fontFamily: 'Urbanist',
        color: AppColors.text4,
        fontSize: 18, // Adjust as needed
        fontWeight: FontWeight.bold,
      ),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontFamily: 'Urbanist',
        color: AppColors.text1,
        fontSize: 56,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: TextStyle(
        fontFamily: 'Urbanist',
        color: AppColors.text1,
        fontSize: 48,
        fontWeight: FontWeight.bold,
      ),
      displaySmall: TextStyle(
        fontFamily: 'Urbanist',
        color: AppColors.text2,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headlineLarge: TextStyle(
        fontFamily: 'Urbanist',
        color: AppColors.text2,
        fontSize: 40,
        fontWeight: FontWeight.bold,
      ),
      headlineMedium: TextStyle(
        fontFamily: 'NunitoSans',
        color: AppColors.text3,
        fontSize: 36,
        fontWeight: FontWeight.normal,
      ),
      headlineSmall: TextStyle(
        fontFamily: 'NunitoSans',
        color: AppColors.text3,
        fontSize: 20,
        fontWeight: FontWeight.normal,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'NunitoSans',
        color: AppColors.text2,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'NunitoSans',
        color: AppColors.text3,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
      bodySmall: TextStyle(
        fontFamily: 'NunitoSans',
        color: AppColors.text3,
        fontSize: 12,
        fontWeight: FontWeight.normal,
      ),
      labelLarge: TextStyle(
        fontFamily: 'Urbanist',
        color: AppColors.text1,
        fontSize: 18, // Increased font size
        fontWeight: FontWeight.bold,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Urbanist',
        color: AppColors.text2,
        fontSize: 16, // Increased font size
        fontWeight: FontWeight.bold,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Urbanist',
        color: AppColors.text3,
        fontSize: 14, // Increased font size
        fontWeight: FontWeight.bold,
      ),
    ),
    cardTheme: CardTheme(color: AppColors.cardColor),
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.secondary1,
      padding: EdgeInsets.symmetric(horizontal: 8),
      textTheme: ButtonTextTheme.primary,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.text4,
        backgroundColor: AppColors.secondary1,
        textStyle: TextStyle(
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.bold,
          fontSize: 18, // Increased font size
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        elevation: 4.0,
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.secondary1,
        textStyle: TextStyle(
          fontFamily: 'Urbanist',
          fontWeight: FontWeight.bold,
          fontSize: 18, // Increased font size
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.text3),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primary1),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.text3),
      ),
      labelStyle: TextStyle(color: AppColors.text2),
      hintStyle: TextStyle(color: AppColors.text3),
    ),
    iconTheme: IconThemeData(
      color: AppColors.text3,
    ),
     bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: AppColors.cardColor),
    bottomAppBarTheme:
        BottomAppBarTheme(color: Colors.transparent)
    
        
        
        );
