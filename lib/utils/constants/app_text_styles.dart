// ignore_for_file: type_annotate_public_apis

import '../tools/file_importers.dart';

// ignore: avoid_classes_with_only_static_members
class AppTextStyles {
  static TextStyle displayLarge(context,
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      TextStyle(
          fontFamily: 'Inter',
          fontWeight: fontWeight ?? FontWeight.w400,
          fontSize: fontSize ?? 57.sp,
          color: color ?? AdaptiveTheme.of(context).theme.hintColor);
  static TextStyle displayMedium(context,
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      TextStyle(
          fontFamily: 'Inter',
          fontWeight: fontWeight ?? FontWeight.w500,
          fontSize: fontSize ?? 45.sp,
          color: color ?? AdaptiveTheme.of(context).theme.hintColor);
  static TextStyle displaySmall(context,
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      TextStyle(
          fontFamily: 'Inter',
          fontWeight: fontWeight ?? FontWeight.w300,
          fontSize: fontSize ?? 36.sp,
          color: color ?? AdaptiveTheme.of(context).theme.hintColor);

  // ignore: type_annotate_public_apis
  static TextStyle headlineLarge(context,
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      TextStyle(
          fontFamily: 'Inter',
          fontWeight: fontWeight ?? FontWeight.w400,
          fontSize: fontSize ?? 32.sp,
          color: color ?? AdaptiveTheme.of(context).theme.hintColor);
  // ignore: type_annotate_public_apis
  static TextStyle headlineMedium(context,
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      TextStyle(
          fontFamily: 'Inter',
          fontWeight: fontWeight ?? FontWeight.w400,
          fontSize: fontSize ?? 22.sp,
          color: color ?? AdaptiveTheme.of(context).theme.hintColor);
  // ignore: type_annotate_public_apis
  static TextStyle headlineSmall(context,
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      TextStyle(
          fontFamily: 'Inter',
          fontWeight: fontWeight ?? FontWeight.w300,
          fontSize: fontSize ?? 20.sp,
          color: color ?? AdaptiveTheme.of(context).theme.hintColor);

  // ignore: type_annotate_public_apis
  static TextStyle titleLarge(context,
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      TextStyle(
          fontFamily: 'Inter',
          fontWeight: fontWeight ?? FontWeight.w400,
          fontSize: fontSize ?? 20.sp,
          color: color ?? AdaptiveTheme.of(context).theme.hintColor);
  // ignore: type_annotate_public_apis
  static TextStyle titleMedium(context,
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      TextStyle(
          fontFamily: 'Inter',
          fontWeight: fontWeight ?? FontWeight.w500,
          fontSize: fontSize ?? 16.sp,
          color: color ?? AdaptiveTheme.of(context).theme.hintColor);
  static TextStyle titleSmall(context,
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      TextStyle(
          fontFamily: 'Inter',
          fontWeight: fontWeight ?? FontWeight.w400,
          fontSize: fontSize ?? 16.sp,
          color: color ?? AdaptiveTheme.of(context).theme.hintColor);

  static TextStyle labelSBold(context,
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      TextStyle(
          fontFamily: 'Inter',
          fontWeight: fontWeight ?? FontWeight.w600,
          fontSize: fontSize ?? 16.sp,
          color: color ?? AdaptiveTheme.of(context).theme.hintColor);
  static TextStyle labelLarge(context,
          {Color? color,
          double? fontSize,
          FontWeight? fontWeight,
          bool isLineThrough = false}) =>
      TextStyle(
          fontFamily: 'Inter',
          decoration: isLineThrough
              ? TextDecoration.lineThrough
              : TextDecoration.none,
          fontWeight: fontWeight ?? FontWeight.w500,
          fontSize: fontSize ?? 14.sp,
          color: color ?? AdaptiveTheme.of(context).theme.hintColor);
  static TextStyle labelMedium(context,
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      TextStyle(
          fontFamily: 'Inter',
          fontWeight: fontWeight ?? FontWeight.w500,
          fontSize: fontSize ?? 12.sp,
          color: color ?? AdaptiveTheme.of(context).theme.hintColor);
  static TextStyle labelSmall(context,
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      TextStyle(
          fontFamily: 'Inter',
          fontWeight: fontWeight ?? FontWeight.w400,
          fontSize: fontSize ?? 11.sp,
          color: color ?? AdaptiveTheme.of(context).theme.hintColor);

  static TextStyle bodyLarge(context,
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      TextStyle(
          fontFamily: 'Inter',
          fontWeight: fontWeight ?? FontWeight.w400,
          fontSize: fontSize ?? 20.sp,
          color: color ?? AdaptiveTheme.of(context).theme.hintColor);
  static TextStyle bodyLargeSmall(context,
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      TextStyle(
          fontFamily: 'Inter',
          fontWeight: fontWeight ?? FontWeight.w400,
          fontSize: fontSize ?? 16.sp,
          color: color ?? AdaptiveTheme.of(context).theme.hintColor);
  static TextStyle bodyMedium(context,
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      TextStyle(
          fontFamily: 'Inter',
          fontWeight: fontWeight ?? FontWeight.w500,
          fontSize: fontSize ?? 16.sp,
          color: color ?? AdaptiveTheme.of(context).theme.hintColor);
  static TextStyle bodySmall(context,
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      TextStyle(
          fontFamily: 'Inter',
          fontWeight: fontWeight ?? FontWeight.w400,
          fontSize: fontSize ?? 14.sp,
          color: color ?? AdaptiveTheme.of(context).theme.hintColor);
}
