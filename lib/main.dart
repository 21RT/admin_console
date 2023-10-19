import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymaker/controller/getController/BuildingApp.dart';
import 'package:moneymaker/controller/translation/my.translations.dart';
import 'package:moneymaker/model/route/app_page.dart';
import 'package:moneymaker/model/theme/app_theme.dart';
import 'package:moneymaker/view/DashboardScreen.dart';
import 'package:url_strategy/url_strategy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            appId: '1:915749193055:web:c17fb484786236fb7a22ea',
            apiKey: 'AIzaSyAkLvV41YjhUXzNuUOkQPxFMvcrbPZ0T0M',
            messagingSenderId: '915749193055',
            projectId: 'lrn-firebase-authen'
        ));
  } else {
    await Firebase.initializeApp();
  }
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Admin Console',
      debugShowCheckedModeBanner: false,
      translations: MyTranslations(),
      locale: const Locale('th', 'TH'),
      // locale: const Locale('en', 'EN'),
      fallbackLocale: const Locale('th', 'TH'),
      theme: AppTheme.basic,
      initialBinding: BilndingsApp(context: context),
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
    );
  }
}

