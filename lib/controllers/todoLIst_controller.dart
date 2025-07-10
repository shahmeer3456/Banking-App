import 'package:bank/models/todo_model.dart';
import 'package:get/get.dart';

class TodoListController extends GetxController
{
  var tasksList=<TodoModelClass>[].obs;

  void addTask(String task)
  {
    tasksList.add(TodoModelClass(title: task));
    tasksList.refresh();
  }
  void removeTask(String task)
  {
    tasksList.removeWhere((element)=>element.title==task);
    tasksList.refresh();
  }
  void toggleTask(int index)
  {
    tasksList[index].isDone = !tasksList[index].isDone;
    tasksList.refresh();
  }
}