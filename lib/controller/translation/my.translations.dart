import 'package:get/get.dart';
import 'package:moneymaker/controller/translation/en.dart';
import 'package:moneymaker/controller/translation/th.dart';

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': US().messages,
        'th_TH': Th().messages,
      };
}
