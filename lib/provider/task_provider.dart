import 'package:bank/models/todo_model.dart';
import 'package:flutter/material.dart';

class TodoProvider with ChangeNotifier {
  List<TodoModelClass> _tasks = [];

  List<TodoModelClass> get tasks => _tasks;

  void addTask(String task) {
    if (task.isNotEmpty) {
      TodoModelClass;
      notifyListeners();
    }
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    notifyListeners();
  }
}
