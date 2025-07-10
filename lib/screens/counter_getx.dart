import 'package:bank/controllers/counter_controller.dart';
import 'package:bank/controllers/todo_controller.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dummy extends StatelessWidget {
  final CounterController controller = Get.put(CounterController());
  final TodoController _controller = Get.put(TodoController());
  final TextEditingController _textEditingController = TextEditingController();
  bool value = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(title: Text("Page")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

          ],
        ),
      ),
    );
  }
}
