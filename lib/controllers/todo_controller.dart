import 'package:bank/models/todo_model.dart';
import 'package:get/get.dart';

class TodoController extends GetxController
{
  var tasksList = <TodoModelClass>[].obs;

  void addTask(String element)
  {
    tasksList.add(TodoModelClass(title: element));
  }
  void removeTask(int index)
  {
    tasksList.removeAt(index);
  }
  void toggleTask(int index) {
    final currentTask = tasksList[index];
    tasksList[index] = TodoModelClass(
      title: currentTask.title,
      isDone: !currentTask.isDone,
    );
  }
}