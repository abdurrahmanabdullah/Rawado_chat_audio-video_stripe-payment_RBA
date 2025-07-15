import 'package:flutter/material.dart';

import '../gen/colors.gen.dart';
import '../helpers/helper_methods.dart';

final class CustomTheme {
  CustomTheme._();
  static const MaterialColor kToPurple = MaterialColor(
    0xFF7D12FF, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xFF7D12FF), //10%
      100: Color(0xFF7D12FF), //20%
      200: Color(0xFF7D12FF), //30%
      300: Color(0xFF7D12FF), //40%
      400: Color(0xFF7D12FF), //50%
      500: Color(0xFF7D12FF), //60%
      600: Color(0xFF7D12FF), //70%
      700: Color(0xFF7D12FF), //80%
      800: Color(0xFF7D12FF), //80%
      900: Color(0xFF7D12FF), //80%
    },
  );
  static const MaterialColor kToBlue = MaterialColor(
    0xFF00FFFF, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xFF00FFFF), //10%
      100: Color(0xFF00FFFF), //20%
      200: Color(0xFF00FFFF), //30%
      300: Color(0xFF00FFFF), //40%
      400: Color(0xFF00FFFF), //50%
      500: Color(0xFF00FFFF), //60%
      600: Color(0xFF00FFFF), //70%
      700: Color(0xFF00FFFF), //80%
      800: Color(0xFF00FFFF), //80%
      900: Color(0xFF00FFFF), //80%
    },
  );
  static const MaterialColor kToWhite = MaterialColor(
    0xFFFFFFFF, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xFFFFFFFF), //10%
      100: Color(0xFFFFFFFF), //20%
      200: Color(0xFFFFFFFF), //30%
      300: Color(0xFFFFFFFF), //40%
      400: Color(0xFFFFFFFF), //50%
      500: Color(0xFFFFFFFF), //60%
      600: Color(0xFFFFFFFF), //70%
      700: Color(0xFFFFFFFF), //80%
      800: Color(0xFFFFFFFF), //80%
      900: Color(0xFFFFFFFF), //80%
    },
  );
  static ThemeData get mainTheme {
    return ThemeData(
      primaryColor: appColor(),
      primarySwatch: CustomTheme.kToPurple,
      scaffoldBackgroundColor: AppColors.scaffoldColor,
    );
  }

  static ThemeData get blueTheme {
    return ThemeData(
      primaryColor: AppColors.blueTheamColor,
      scaffoldBackgroundColor: AppColors.scaffoldColor,
    );
  }

  static ThemeData get whiteTheme {
    return ThemeData(
      primaryColor: AppColors.whiteTheamColor,
      scaffoldBackgroundColor: AppColors.scaffoldColor,
    );
  }
}
