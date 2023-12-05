import 'package:e_book/core/colors/app_colors.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

abstract class _LightColors {
  static const background = AppColors.backgroundLight;
  static const card = AppColors.cardLight;
}

abstract class _DarkColors {
  static const background = AppColors.backgroundDark;
  static const card = AppColors.cardDark;
}

abstract class AppTheme {
  static final visualDensity = VisualDensity.adaptivePlatformDensity;

  ///Light theme
  static ThemeData light() => ThemeData(
        brightness: Brightness.light,
        hintColor: AppColors.backgroundLight,
        visualDensity: visualDensity,
        drawerTheme: const DrawerThemeData(
          backgroundColor: AppColors.appBarLight,
        ),
        appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.appBarLight,
            titleTextStyle: TextStyle(
                color: AppColors.textDark,
                fontSize: 20,
                fontWeight: FontWeight.w600),
            iconTheme: IconThemeData(color: AppColors.textDark),
            elevation: 2),
        scaffoldBackgroundColor: _LightColors.background,
        cardColor: _LightColors.card,
        primaryTextTheme: const TextTheme(
          titleLarge: TextStyle(
              color: AppColors.mainbuttonColor2,
              fontSize: 20,
              fontWeight: FontWeight.w600),
          titleMedium: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.mainbuttonColor),
          bodyLarge: TextStyle(
              fontSize: 16,
              letterSpacing: 1.5,
              height: 1.3,
              fontWeight: FontWeight.w400,
              color: AppColors.mainbuttonColor),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textDark,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.textGray,
          ),
        ),
      );

  ///Dark theme
  static ThemeData dark() => ThemeData(
        brightness: Brightness.dark,
        hintColor: AppColors.backgroundDark,
        visualDensity: visualDensity,
        drawerTheme: const DrawerThemeData(
          backgroundColor: AppColors.mainbuttonColor2,
        ),
        appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.appBarDark,
            titleTextStyle: TextStyle(
                color: AppColors.textLight,
                fontSize: 20,
                fontWeight: FontWeight.w600),
            iconTheme: IconThemeData(color: AppColors.textLight),
            elevation: 2),
        textTheme:
            const TextTheme(bodyMedium: TextStyle(color: AppColors.textLight)),
        scaffoldBackgroundColor: _DarkColors.background,
        cardColor: _DarkColors.card,
        primaryTextTheme: const TextTheme(
          titleLarge: TextStyle(
              decorationThickness: 2,
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textLight),
          titleMedium: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppColors.textLight),
          bodyLarge: TextStyle(
              fontSize: 16,
              letterSpacing: 1.5,
              height: 1.3,
              fontWeight: FontWeight.w400,
              color: AppColors.whiteLikeColor),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textLight,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: AppColors.textLight,
          ),
        ),
      );
}

/// theme mode controller
class ThemeProvider extends ChangeNotifier {
  ThemeData _theme = AppTheme.light();

  ThemeData get theme => _theme;

  void toggleTheme() {
    final isDark = _theme == AppTheme.dark();
    if (isDark) {
      _theme = AppTheme.light();
    } else {
      _theme = AppTheme.dark();
    }
    notifyListeners();
  }
}
class ThemeServices {
  final _box = GetStorage();
  final _key = "isDarkMode";

  _saveThemeBox(bool isDarkMode) => _box.write(_key, isDarkMode);

  bool _loadThemeFromBox() => _box.read(_key) ?? false;

  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeBox(!_loadThemeFromBox());
  }
}
