import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _theme = ThemeData.light();
  bool _isDark = false;
  ThemeData get theme => _theme;
  bool get isDark => _isDark;

  void toggleTheme(bool value) {
    _isDark = value;
    if (_isDark) {
      _theme = ThemeData.dark();
    } else {
      _theme = ThemeData.light();
    }
    notifyListeners();
  }
}
