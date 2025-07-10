import 'package:get/get.dart';
import 'package:flutter/material.dart';


class CounterController extends GetxController {
  var counter = 0.obs;
  var text = " ".obs;
  var fruitsList = <String>["apple", "banana"].obs;
  var count = 0.obs;
  var status = false.obs;
  var bkColor = Colors.white.obs;
  var items=<String>["item 1","item 2","item 3","item 4",].obs;
  var selectedItem = " ".obs;
  var currentIndex = -1.obs;
  var todoList = <String>[].obs;
  RxDouble currentValue = 50.0.obs;

  var currentState = "bulb is off".obs;

  void changeText(var n) {
    text.value = n;
  }

  void counterReset() {
    counter.value = 0;
  }

  void increment() {
    counter++;
  }

  void decrement() {
    if (counter.value > 0) {
      counter--;
    }
  }

  void addItem(String value) {
    fruitsList.add(value);
  }

  void deleteItem(String value) {
    fruitsList.remove(value);
  }
}
