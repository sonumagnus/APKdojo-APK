import 'package:flutter/material.dart';

class DarkThemeToggler extends ChangeNotifier {
  bool _isDarkThemeEnabled = false;
  bool get isDarkThemeEnabled => _isDarkThemeEnabled;

  toggleDarkTheme() {
    _isDarkThemeEnabled = !_isDarkThemeEnabled;
    notifyListeners();
  }
}
