import 'package:flutter/material.dart';

class TextProvider with ChangeNotifier {
  String _text = '';

  String get text => _text;

  void updateText(String value) {
    _text = value;
    notifyListeners();
  }
}
