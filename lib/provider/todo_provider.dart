import 'package:bank/models/todo_model.dart';
import 'package:flutter/cupertino.dart';

class TodoProvider with ChangeNotifier {
  final List<TodoModelClass> _tasksList = [];

  List<TodoModelClass> get tasksList => _tasksList;
  int _tasksCompleted = 0;

  int get totalTasks =>
      _tasksList.where((element) => element.title.isNotEmpty).length;

  int get tasksCompleted => _tasksCompleted;

  void addTask(String task) {
    _tasksList.add(TodoModelClass(title: task));

    notifyListeners();
  }

  void removeTask(String task) {
    _tasksList.removeWhere((element) => element.title == task);
    notifyListeners();
  }

  void toggleTask(int index) {
    _tasksList[index].isDone = !_tasksList[index].isDone;
    _tasksCompleted = _tasksList.where((element) => element.isDone).length;
    notifyListeners();
  }
}
