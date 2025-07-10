import 'package:bank/provider/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoScreen extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todoProvider = Provider.of<TodoProvider>(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text("Todo List"),
          trailing: Icon(Icons.task_sharp),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                ElevatedButton(
                  onPressed: () {
                    todoProvider.addTask(_textEditingController.text);
                    _textEditingController.clear();
                  },
                  child: Icon(Icons.add_task, size: 30),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  final tasks = todoProvider.tasksList[index];
                  return ListTile(
                    title: Text(
                      tasks.title,
                      style: TextStyle(
                        decoration: tasks.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                      ),
                    ),
                    trailing: Checkbox(
                      value: tasks.isDone,
                      onChanged: (val) {
                        todoProvider.toggleTask(index);
                      },
                    ),
                  );
                },
                itemCount: todoProvider.tasksList.length,
              ),
            ),

            Text(
              "Total tasks ${todoProvider.totalTasks}",
              style: TextStyle(fontSize: 30, color: Colors.red,fontWeight: FontWeight.bold),
            ),
            Text(
              "Tasks completed ${todoProvider.tasksCompleted}",
              style: TextStyle(
                fontSize: 30,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
