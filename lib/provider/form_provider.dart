import 'package:flutter/cupertino.dart';

class FormProvider with ChangeNotifier {
  String _name = " ";
  String _email = " ";
  bool _isEnable = false;

  String get name => _name;

  String get email => _email;

  bool get isEnable => _isEnable;

  void nameValidate() {
    if (_name.isNotEmpty &&
        _email.isNotEmpty &&
        _email.contains("@") &&
        _email.contains(".")) {
      _isEnable = true;
    } else {
      _isEnable = false;
    }
    notifyListeners();
  }
}
