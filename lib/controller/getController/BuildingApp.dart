import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moneymaker/controller/getController/components/appbarControl.dart';
import 'package:moneymaker/controller/getController/settingControl/settingController.dart';
import 'package:moneymaker/controller/getController/signinControl/signinControl.dart';
import 'package:moneymaker/controller/getController/userControl/userControl.dart';

class BilndingsApp implements Bindings{
  late BuildContext context;

  BilndingsApp({required this.context});
  void dependencies() {
    Get.put(SignInController());
    Get.lazyPut(() => AppBarController());
    Get.put(UserController());
    Get.put(SettingsController());
  }
}