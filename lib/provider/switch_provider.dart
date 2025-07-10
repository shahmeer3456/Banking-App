import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDark = false;

  bool get isDark => _isDark;

  void changeTheme() {
    _isDark = !_isDark;
    notifyListeners();
  }

  // Background color
  Color get backgroundColor => _isDark ? Colors.black : Colors.white;

  // Text color
  Color get textColor => _isDark ? Colors.white : Colors.black;

  // AppBar color
  Color get appBarColor => _isDark ? Colors.grey[900]! : Colors.blue;

  // Icon color
  Color get iconColor => _isDark ? Colors.white : Colors.black;
}
