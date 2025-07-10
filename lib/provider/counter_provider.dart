import 'package:flutter/cupertino.dart';

class CounterProvider with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }
  void reset() {
    _count = 0;
    notifyListeners();
  }
  // ✅ Button enable disable logic
  bool get isIncrementEnabled => _count < 10;
  bool get isDecrementEnabled => _count > 0;
}
