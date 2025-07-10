import 'package:flutter/cupertino.dart';

class SliderProvider with ChangeNotifier
{
  bool _isEnable = false;
  double _sliderValue = 0;
  double get sliderValue => _sliderValue;
  bool get isEnable => _isEnable;
  void changeState(bool val)
  {
    _isEnable=val;
    notifyListeners();
  }

  void changeSlider(double val)
  {
    _sliderValue = val;
    notifyListeners();
  }




}