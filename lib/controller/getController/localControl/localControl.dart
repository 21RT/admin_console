import 'dart:ui';
import 'package:get/get.dart';

class LocaleController extends GetxController {
  RxString languageSelect = 'English'.obs;

  void changeLanguage({
    required Locale newLocale,
    required String language,
  }) {
    languageSelect.value = language;
    Get.updateLocale(newLocale);
    update();
  }
}
