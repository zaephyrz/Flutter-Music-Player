import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xFF9C27B0);
  static const Color secondaryColor = Color(0xFFE91E63);

  static LinearGradient get gradient => LinearGradient(
    colors: [primaryColor, secondaryColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static ThemeData get theme => ThemeData(
    primaryColor: primaryColor,
    colorScheme: ColorScheme.light(
      primary: primaryColor,
      secondary: secondaryColor,
    ),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
  );
}
