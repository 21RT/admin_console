import 'package:get/get.dart';

class SettingsController extends GetxController {
  RxInt indexSettings = 0.obs;

  void setIndexSettings({required int index}) {
    indexSettings.value = index;
    print(indexSettings.value);
    update();
  }
}