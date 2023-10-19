import 'package:get/get.dart';

class AppBarController extends GetxController {
  RxBool scrollController = false.obs;

  void setScrollController(double scroll) {
    scrollController.value = scroll > 20;
    update();
  }
}
