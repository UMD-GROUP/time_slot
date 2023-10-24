// ignore_for_file: avoid_classes_with_only_static_members

import 'package:time_slot/utils/tools/file_importers.dart';

class AppTheme {
  static ThemeData light = ThemeData(
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: Colors.black),
        bodyLarge: TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.black),
        bodySmall: TextStyle(color: Colors.black),
      ),
      colorScheme: const ColorScheme(
        primary: Color(0xFF3F51B5),
        primaryContainer: Color(0xFF002984),
        secondary: Color(0xFFD32F2F),
        secondaryContainer: Color(0xFF9A0007),
        surface: Color(0xFFDEE2E6),
        background: Color(0xFFF8F9FA),
        error: Color(0xFF96031A),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.black,
        onBackground: Colors.white,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
      backgroundColor: Colors.white,
      hintColor: Colors.black,
      bottomAppBarColor: Colors.black,
      disabledColor: Colors.white,
      hoverColor: Colors.grey,
      fontFamily: 'Inter',
      primaryColor: Colors.deepPurple,
      primarySwatch: Colors.deepPurple,
      canvasColor: Colors.black45);
  static ThemeData dark = ThemeData(
      textTheme: const TextTheme(
        titleLarge: TextStyle(color: Colors.white),
        bodyLarge: TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.white),
        bodySmall: TextStyle(color: Colors.white),
      ),
      colorScheme: const ColorScheme(
        primary: Color(0xFF3F51B5),
        primaryContainer: Color(0xFF002984),
        secondary: Color(0xFFD32F2F),
        secondaryContainer: Color(0xFF9A0007),
        surface: Color(0xFFDEE2E6),
        background: Color(0xFFF8F9FA),
        error: Color(0xFF96031A),
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.white,
        onBackground: Colors.white,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
      backgroundColor: AppColors.c0F1620,
      disabledColor: AppColors.c1C2632,
      bottomAppBarColor: Colors.white,
      hintColor: Colors.white,
      hoverColor: Colors.white.withOpacity(0.6),
      fontFamily: 'Inter',
      primaryColor: Colors.deepPurple,
      primarySwatch: Colors.deepPurple,
      canvasColor: Colors.white);
}
