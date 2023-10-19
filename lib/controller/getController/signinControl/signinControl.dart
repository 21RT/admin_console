import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:moneymaker/controller/service/httpService.dart';
import 'package:moneymaker/controller/translation/translation_key.dart';
import 'package:moneymaker/model/modelControl/regisModel.dart';

class SignInController extends GetxController {
  RxInt pageIndex = 0.obs;
  RxBool isAgree = false.obs;
  RxBool isPasswordVisible = false.obs;
  RxBool isPasswordConfirmed = false.obs;
  RxBool isObscureRegister = true.obs;
  RxBool isObscureLogin = true.obs;
  RxInt isSendEmail = 30.obs;
  Timer? timer;


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    startTimer();
  }

  void setPageIndex({required int index}) {
    pageIndex.value = index;
    update();
  }

  void setIsObscureRegister({required bool value}) {
    isObscureRegister.value = value;
    update();
  }

  void setIsObscureLogin({required bool value}) {
    isObscureLogin.value = value;
    update();
  }

  void setIsAgree({required bool value}) {
    isAgree.value = value;
    update();
  }

  void checkIsPasswordVisible({required String password}) {
    RegExp letterRegex = RegExp(r'[a-zA-Z]');
    RegExp digitRegex = RegExp(r'\d');
    isPasswordVisible.value =
        password.length >= 8 && letterRegex.hasMatch(password) &&
            digitRegex.hasMatch(password);
    update();
  }

  void checkIsPasswordConfirmed(
      {required String password, required String confirmedPassword}) {
    isPasswordConfirmed.value = password == confirmedPassword;
    update();
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {
        if (isSendEmail.value > 0) {
          isSendEmail.value--;
        } else {
          timer.cancel();
          isSendEmail.value = 30;
        }
        update();
      },
    );
  }

  void loginEmail(email, password) async {
    try {
      print("loginEmail");
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password
      ).then((value) {
        var user = FirebaseAuth.instance.currentUser;
        print("user: $user");
      }).catchError((error) {
        print("Failed to login: $error");
      });

      return;
    } on FirebaseAuthException catch (e) {} catch (e) {
      print(e);
    }
  }

  void signupEmail(email, password, firstName, lastName, phoneRegis) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password
      );

      User? user = FirebaseAuth.instance.currentUser;

      print(user!.uid);

      /// optional สำหรับส่ง email verification
      if (!user.emailVerified) {
        await user.updateDisplayName(firstName + " " + lastName);
        await user.sendEmailVerification();
      } else {
        print('email is verified');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  register(Map<String, dynamic> userData) async {
    try {
      // Parse the string dates into DateTime objects
      DateTime createTime = DateTime.parse(userData['create_time']);
      DateTime lastTime = DateTime.parse(userData['last_time']);
      // Calculate the difference in seconds
      int secondsDifference = lastTime
          .difference(createTime)
          .inSeconds;
      print(createTime);
      print(lastTime);
      print("อยู่ตรงนี้${secondsDifference.seconds}");
      if(secondsDifference > 1) {
        print("มากกว่า");
        // print("อยู่ตรงนี้${secondsDifference}");
        var response2 = await HttpService.post('http://172.16.0.172:8080/updateData', userData);
        print({response2});
      }else {
        print("น้อยกว่า");
        var response = await HttpService.post('http://172.16.0.172:8080/insertData', userData);
      }
      // print({response});
    } catch (e) {
      print(e);
    }
  }

}
