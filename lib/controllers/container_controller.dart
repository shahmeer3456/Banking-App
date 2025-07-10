import 'package:get/get.dart';

class ContainerController extends GetxController {
  var isSelected = false.obs;

  void changeSelected() {
    isSelected.value = !isSelected.value;
  }
}
