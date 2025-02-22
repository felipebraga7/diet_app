import 'package:flutter/material.dart';
import 'app_color_dark_theme.dart';
import 'app_color_light_theme.dart';
import 'light_theme.dart';
import 'dark_theme.dart';

class AppTheme {
  static final ThemeData light = lightTheme;
  static final ThemeData dark = darkTheme;
}

extension AppColorScheme on ColorScheme {
  Color get primary => brightness == Brightness.light ? AppColorsLightTheme.primary : AppColorsDarkTheme.primary;
  Color get onPrimary => brightness == Brightness.light ? AppColorsLightTheme.onPrimary : AppColorsDarkTheme.onPrimary;
  Color get secondary => brightness == Brightness.light ? AppColorsLightTheme.secondary : AppColorsDarkTheme.secondary;
  Color get surface => brightness == Brightness.light ? AppColorsLightTheme.surface : AppColorsDarkTheme.surface;
  Color get inverseSurface => brightness == Brightness.light ? AppColorsLightTheme.inverseSurface : AppColorsDarkTheme.inverseSurface;
  Color get onSecondary => brightness == Brightness.light ? AppColorsLightTheme.onSecondary : AppColorsDarkTheme.onSecondary;
  Color get success => brightness == Brightness.light ? AppColorsLightTheme.success : AppColorsDarkTheme.success;
  Color get successGradientStart => brightness == Brightness.light ? AppColorsLightTheme.successGradientStart : AppColorsDarkTheme.successGradientStart;
  Color get successGradientEnd => brightness == Brightness.light ? AppColorsLightTheme.successGradientEnd : AppColorsDarkTheme.successGradientEnd;
  Color get info => brightness == Brightness.light ? AppColorsLightTheme.info : AppColorsDarkTheme.info;
  Color get infoGradientStart => brightness == Brightness.light ? AppColorsLightTheme.infoGradientStart : AppColorsDarkTheme.infoGradientStart;
  Color get infoGradientEnd => brightness == Brightness.light ? AppColorsLightTheme.infoGradientEnd : AppColorsDarkTheme.infoGradientEnd;
  Color get warning => brightness == Brightness.light ? AppColorsLightTheme.warning : AppColorsDarkTheme.warning;
  Color get warningGradientStart => brightness == Brightness.light ? AppColorsLightTheme.warningGradientStart : AppColorsDarkTheme.warningGradientStart;
  Color get warningGradientEnd => brightness == Brightness.light ? AppColorsLightTheme.warningGradientEnd : AppColorsDarkTheme.warningGradientEnd;
  Color get error => brightness == Brightness.light ? AppColorsLightTheme.error : AppColorsDarkTheme.error;
  Color get errorGradientStart => brightness == Brightness.light ? AppColorsLightTheme.errorGradientStart : AppColorsDarkTheme.errorGradientStart;
  Color get errorGradientEnd => brightness == Brightness.light ? AppColorsLightTheme.errorGradientEnd : AppColorsDarkTheme.errorGradientEnd;
}