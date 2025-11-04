import 'package:flutter/material.dart';
import 'app_colors.dart';

final ThemeData appTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.grayLight,
  primaryColor: AppColors.greenDark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.greenDark,
    background: AppColors.grayLight,
  ),
  textTheme: const TextTheme(
    bodyMedium: TextStyle(color: AppColors.gray),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.greenDark,
    foregroundColor: Colors.white,
    elevation: 0,
  ),
);
