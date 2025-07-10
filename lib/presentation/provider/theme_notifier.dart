import 'package:flutter/material.dart';
import 'package:restaurant_app/data/services/services.dart';

class ThemeNotifier with ChangeNotifier {
  bool isDarkMode;

  ThemeNotifier({this.isDarkMode = false});

  ThemeMode get themeMode => isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() async {
    isDarkMode = !isDarkMode;
    notifyListeners();
    await SharedPreferencesHelper.setBool(
      SharedPreferenceKey.idDarkMode,
      isDarkMode,
    );
  }
}
