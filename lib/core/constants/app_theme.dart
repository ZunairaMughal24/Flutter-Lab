
import 'package:api_integration/core/utils/app_colors.dart';

import 'package:flutter/material.dart';

class AppTheme {
  static Color get primaryLight => const Color.fromARGB(255, 216, 193, 149);

  static ThemeData get lightTheme {
    return ThemeData(
      canvasColor: Colors.white,
      primaryColor: primaryLight,
      dividerColor: Colors.grey,
      scaffoldBackgroundColor: const Color.fromARGB(255, 236, 234, 234),
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryLight,
        brightness: Brightness.light,
        primary: primaryLight,
        secondary: primaryLight,
        surface: const Color(0XFFF5F5F5),
      ),
      appBarTheme: const AppBarTheme(
        surfaceTintColor: Colors.transparent,
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(
          color: AppColors.blackColor,
          fontSize: 19,
          fontWeight: FontWeight.w600,

    
        ),
        centerTitle: true,
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: AppColors.blackColor,
          
        ),
        bodyMedium: TextStyle(
          color: AppColors.blackColor,
       
        ),
        bodySmall: TextStyle(
          color: AppColors.blackColor,
       
        ),
      ),
    );
  }
}
