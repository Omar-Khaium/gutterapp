import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

import 'constants.dart';

class ThemeHelper {
  final int value;

  ThemeHelper(this.value) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
      systemNavigationBarColor: backgroundColor,
      systemNavigationBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
    ));
  }

  bool get isDark => value == ThemeValue.light
      ? false
      : value == ThemeValue.systemPreferred
          ? SchedulerBinding.instance!.window.platformBrightness == Brightness.dark
          : true;

  MaterialColor get accentColor => Colors.teal;

  Color get primaryColor => isDark ? Colors.white : Colors.black;

  Color get backgroundColor => isDark ? accentColor.shade900 : accentColor.shade50;

  Color get secondaryColor => isDark ? Colors.grey.shade900 : Colors.grey.shade50;

  Color get textColor => isDark ? Colors.grey.shade100 : Colors.grey.shade900;

  Color get iconColor => isDark ? Colors.grey.shade100 : Colors.grey.shade800;

  Color get shadowColor => isDark ? Colors.white12 : Colors.black12;

  Color get hintColor => isDark ? Colors.grey : Colors.grey;

  Color get errorColor => isDark ? Colors.redAccent.shade400 : Colors.redAccent.shade400;

  Color get successColor => isDark ? Colors.greenAccent.shade400 : Colors.greenAccent.shade400;

  Color get shimmerBaseColor => isDark ? Colors.grey.shade800 : Colors.grey.shade100;

  Color get shimmerHighlightColor => isDark ? Colors.grey.shade900 : Colors.grey.shade50;
}
