// ignore_for_file: avoid_classes_with_only_static_members

import 'package:time_slot/utils/tools/file_importers.dart';

class AppTheme {
  static ThemeData light = ThemeData(
    backgroundColor: Colors.white,
    hintColor: Colors.black,
    disabledColor:  Colors.white,
    fontFamily: 'Inter',
    primaryColor: Colors.deepPurple,
    primarySwatch: Colors.deepPurple,
    canvasColor: Colors.black45
  );
  static ThemeData dark = ThemeData(
    backgroundColor: AppColors.c0F1620,
    disabledColor:  AppColors.c1C2632,
    hintColor: Colors.white,
    fontFamily: 'Inter',
    primaryColor: Colors.deepPurple,
    primarySwatch: Colors.deepPurple,
    canvasColor: Colors.white
  );
}
