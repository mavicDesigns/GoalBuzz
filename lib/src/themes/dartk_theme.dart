import 'package:flutter/material.dart';

class AppColors {
  static const Color primary1 = Color(0xFFFF6A5F); // Pastel red #FF6A5F
  static const Color primary2 = Color(0xFFBF5C5C); // Muted pastel red
  static const Color primary3 = Color(0xFFE3B7B7); // Light pastel red
  static const Color secondary1 = Color(0xFF465A54); // Dark green #465A54
  static const Color secondary2 = Color(0xFF6B8E6F); // Muted olive green
  static const Color tertiary = Color(0xFF252F2C); // Deeper green #252F2C
  static const Color background = Color(0xFF252525); // Dark background RGB(37,37,35)
  static const Color text1 = Color(0xFFE0E0E0); // Light gray for text
  static const Color text2 = Color(0xFFB0B0B0); // Medium gray for text
  static const Color text3 = Color(0xFF8D93A3); // Light gray for text
    static const Color cardColor = Color.fromRGBO(64, 64, 61, 1);

  static const Color text4 = Color(0xff252523); // Darker gray for background
}

final ThemeData darkTheme = ThemeData(
  primaryColor: AppColors.primary1,
  colorScheme: ColorScheme.dark(
    primary: AppColors.primary1,
    secondary: AppColors.secondary1,
    background: AppColors.background,
    onPrimary: Colors.black,
    onSecondary: Colors.black,
    onBackground: AppColors.text1,
    onSurface: AppColors.text2,
  ),
  scaffoldBackgroundColor: AppColors.background,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.cardColor,
    foregroundColor: AppColors.text1,
    iconTheme: IconThemeData(
      color: AppColors.text1,
    ),
    titleTextStyle: TextStyle(
      fontFamily: 'Urbanist',
      color: AppColors.text1,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    toolbarTextStyle: TextStyle(
      fontFamily: 'Urbanist',
      color: AppColors.text1,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  ),

  cardTheme: CardTheme(
    color: AppColors.cardColor
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
  buttonTheme: ButtonThemeData(
    buttonColor: AppColors.text1,
    padding: EdgeInsets.symmetric(horizontal: 8),
    textTheme: ButtonTextTheme.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: AppColors.text1, backgroundColor: AppColors.secondary1,
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
      foregroundColor: AppColors.secondary1, textStyle: TextStyle(
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
    color: AppColors.primary1,
  ),

  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: AppColors.cardColor
  )
);
