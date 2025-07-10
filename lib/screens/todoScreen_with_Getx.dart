import 'package:bank/controllers/todoLIst_controller.dart';
import 'package:bank/utilities/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoScreen1 extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  final TodoListController controller = Get.put(TodoListController());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text("Todo list"),
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
                    style: TextStyle(),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    controller: _textEditingController,
                  ),
                ),
                SizedBox(width: 24),
                ElevatedButton(
                  onPressed: () {
                    controller.addTask(_textEditingController.text);
                    _textEditingController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),

                  child: Icon(Icons.add_task, size: 30, color: Colors.green),
                ),
              ],
            ),
            Expanded(
              child: Obx(
                () => ListView.builder(
                  itemBuilder: (context, index) {
                    final tasks = controller.tasksList[index];
                    return ListTile(
                      title: Text(
                        tasks.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          decoration: tasks.isDone
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: Checkbox(
                        value: tasks.isDone,
                        onChanged: (val) {
                          controller.toggleTask(index);
                        },
                      ),
                      leading: IconButton(
                        onPressed: () {
                          controller.removeTask(tasks.title);
                        },
                        icon: Icon(Icons.delete, color: Colors.red),
                      ),
                    );
                  },
                  itemCount: controller.tasksList.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
