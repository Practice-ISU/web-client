import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_hoster/ui/kit/dimens.dart';
import 'package:image_hoster/ui/theme/app_colors.dart';
import 'package:image_hoster/ui/theme/app_text_theme.dart';

final appTheme = ThemeData(
    fontFamily: 'Archivo',
    textTheme: appTextTheme,
    primaryColor: AppColors.primary,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      background: AppColors.defaultBackground,
      onBackground: AppColors.defaultBackground,
      surface: AppColors.gray.shade700,
      onSurface: AppColors.gray.shade300,
    ),
    appBarTheme: AppBarTheme(
        color: AppColors.gray.shade800,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.defaultBackground,
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        )),
    tabBarTheme: const TabBarTheme(
      overlayColor: MaterialStatePropertyAll<Color>(AppColors.primary),
    ),
    scaffoldBackgroundColor: AppColors.defaultBackground,
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll(0),
        padding: const MaterialStatePropertyAll(
          EdgeInsets.all(Dimens.md + Dimens.xs),
        ),
        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimens.sm),
          ),
        ),
        textStyle: MaterialStatePropertyAll(appTextTheme.buttonLarge),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll(0),
        backgroundColor: MaterialStatePropertyAll(AppColors.gray.shade700),
        foregroundColor: const MaterialStatePropertyAll(Colors.white),
        padding: const MaterialStatePropertyAll(
            EdgeInsets.all(Dimens.md + Dimens.xs)),
        shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
          RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimens.sm)),
        ),
        side: const MaterialStatePropertyAll(
          BorderSide(width: 0, color: Colors.transparent),
        ),
        textStyle: MaterialStatePropertyAll(
          appTextTheme.buttonLarge,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll(0),
        textStyle: MaterialStatePropertyAll(appTextTheme.buttonLarge),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      fillColor: AppColors.gray.shade700,
      filled: true,
      floatingLabelStyle: appTextTheme.inputLabel?.copyWith(
        color: AppColors.gray.shade300,
      ),
      labelStyle: TextStyle(color: AppColors.gray.shade300),
      prefixStyle: appTextTheme.inputText,
      border: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.sm),
        borderSide: const BorderSide(
          color: Colors.transparent,
          width: Dimens.xs,
        ),
      ),
      errorBorder: UnderlineInputBorder(
        borderRadius: BorderRadius.circular(Dimens.sm),
        borderSide: const BorderSide(
          color: AppColors.red,
          width: Dimens.xs,
        ),
      ),
    ));
