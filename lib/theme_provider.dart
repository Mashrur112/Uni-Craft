import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeData get currentTheme {
    if (_isDarkMode) {
      return darkTheme;
    } else {
      return lightTheme;
    }
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}

final lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  backgroundColor: Colors.white,
);

final darkTheme = ThemeData.dark().copyWith(
  backgroundColor: Colors.black,
);
