import 'package:get/get.dart';

class TryController extends GetxController {
  bool isColored = false;

  void setColored() {
    isColored = !isColored;
    update();
  }
}
