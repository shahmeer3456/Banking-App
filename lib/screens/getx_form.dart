import 'package:bank/controllers/container_controller.dart';
import 'package:bank/utilities/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/signup_controller.dart';
//import 'signup_controller.dart';

class SignupPage extends StatelessWidget {
  final SignupController controller = Get.put(SignupController());
  final ContainerController _controller = Get.put(ContainerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Signup")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [

              ],
            ),
          ),
        ),
      ),
    );
  }
}
