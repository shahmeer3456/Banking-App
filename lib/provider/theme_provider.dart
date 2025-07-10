import 'package:flutter/cupertino.dart';

class ThemeProvider1 with ChangeNotifier
{
  bool _isOn = false;

  bool get isOn => _isOn;

  void changeTheme(bool val)
  {
    _isOn = val;
    notifyListeners();
  }
}