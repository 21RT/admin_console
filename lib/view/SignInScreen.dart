// ignore_for_file: use_build_context_synchronously
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lottie/lottie.dart';
import 'package:moneymaker/controller/getController/localControl/localControl.dart';
import 'package:moneymaker/controller/getController/signinControl/signinControl.dart';
import 'package:moneymaker/controller/getController/userControl/userControl.dart';
import 'package:moneymaker/controller/translation/translation_key.dart';
import 'package:moneymaker/model/theme/app_constants.dart';
import 'package:moneymaker/view/components/loading_screen.dart';
import 'package:moneymaker/view/components/responsive_builder.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<SignInScreen> {
  // final activityController = Get.put(ActivityController());

  final _languageList = [
    {'language': 'ภาษาไทย', 'locale': const Locale('th', 'TH')},
    {'language': 'English', 'locale': const Locale('en', 'US')},
  ];

  //Login Page
  final _emailLogin = TextEditingController();
  final _passwordLogin = TextEditingController();

  //Register Page
  final _companyNameRegister = TextEditingController();
  final _firstNameRegister = TextEditingController();
  final _lastNameRegister = TextEditingController();
  final _phoneRegister = TextEditingController();

  final _emailRegister = TextEditingController();
  final _passwordRegister = TextEditingController();
  final _confirmPasswordRegister = TextEditingController();

  String _selectedOption = '+66';

  @override
  void initState() {
    super.initState();
    // _emailLogin.text = 'chanon.suttana.pkg@gmail.com';
    _emailLogin.text = 'jitrawadee.wanichphon.pkg@gmail.com';
    _passwordLogin.text = '123456';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     // Get.put(UserController()).getDataUser();
      //     // Get.put(SignInController()).register();
      //   },
      //   child: const Icon(Icons.language),
      // ),
      // backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: buildContent(),
      ),
    );
  }

  Widget buildContent() {
    return GetBuilder<SignInController>(
        init: SignInController(),
        builder: (signInController) {
          return ResponsiveBuilder(
            mobileBuilder: (context, constraints) {
              return Container(
                width: Get.width,
                height: Get.height,
                padding: const EdgeInsets.symmetric(
                  horizontal: kSpacing,
                  vertical: kSpacing,
                ),
                child: IndexedStack(
                  index: signInController.pageIndex.value,
                  children: <Widget>[
                    buildSignIn(),
                    buildSignUp(),
                    buildCheckEmail(),
                  ],
                ),
              );
            },
            tabletBuilder: (context, constraints) {
              return Container(
                width: Get.width,
                height: Get.height,
                alignment: Alignment.topCenter,
                decoration:  BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      const Color(0xFF8C52FF),
                      const Color(0xFF5CE1E6).withOpacity(0.8),
                      // Color(0xFF8989FF),
                    ],
                  ),
                  image: const DecorationImage(
                    image: AssetImage(ImageRasterPath.imageBg2),
                    repeat: ImageRepeat.repeat,
                    colorFilter: ColorFilter.mode(
                      Colors.white, // Overlay color
                      BlendMode.modulate, // Adjust blend mode as needed
                    ),
                  ),
                ),
                child: Container(
                  width: 600.0,
                  height: Get.height,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: kSpacing * 2,
                    vertical: kSpacing,
                  ),
                  child: IndexedStack(
                    index: signInController.pageIndex.value,
                    children: <Widget>[
                      buildSignIn(),
                      buildSignUp(),
                      buildCheckEmail(),
                    ],
                  ),
                ),
              );
            },
            desktopBuilder: (context, constraints) {
              return SizedBox(
                width: Get.width,
                height: Get.height,
                child: Row(
                  children: <Widget>[
                    Expanded(flex: 1, child: buildBanner()),
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Container(
                          width: 900.0,
                          padding: const EdgeInsets.symmetric(
                            horizontal: kSpacing * 2,
                            vertical: kSpacing,
                          ),
                          color: Colors.white,
                          alignment: Alignment.topCenter,
                          child: IndexedStack(
                            index: signInController.pageIndex.value,
                            children: <Widget>[
                              buildSignIn(),
                              buildSignUp(),
                              buildCheckEmail(),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  Widget buildBanner() {
    return GetBuilder<SignInController>(
        init: SignInController(),
        builder: (signInController) {
          return Container(
            decoration: BoxDecoration(
              image: const DecorationImage(
                image: AssetImage(ImageRasterPath.imageBg2),
                repeat: ImageRepeat.repeat,
                colorFilter: ColorFilter.mode(
                  Colors.white, // Overlay color
                  BlendMode.modulate, // Adjust blend mode as needed
                ),
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  const Color(0xFF8C52FF),
                  const Color(0xFF5CE1E6).withOpacity(0.8),
                  // Color(0xFF8989FF),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(kSpacing * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // ColorFiltered(
                      //   colorFilter: ColorFilter.mode(
                      //     Colors.white.withOpacity(0.8), // Adjust the opacity value as needed
                      //     BlendMode.modulate,
                      //   ),
                      //   child: Image.asset(
                      //     ImageRasterPath.logoMerchantAdmin1,
                      //     height: 70.0,
                      //   ),
                      // ),
                      // const SizedBox()
                    ],
                  ),
                  Container(
                    height: 200,
                    width: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white.withOpacity(0.2),
                    ),
                  ),
                  if (signInController.pageIndex.value == 0)
                    SizedBox(
                      width: 600.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text(
                            'DashBord',
                            style: TextStyle(
                              shadows: [
                                Shadow(color: Colors.white12, blurRadius: 1.0)
                              ],
                              fontSize: 58.0,
                              color: Color(0xFF5271FF),
                              fontWeight: FontWeight.bold,
                              letterSpacing: 5.0,
                            ),
                          ),
                          const Text(
                            'ADMIN CONSOLE',
                            style: TextStyle(
                              shadows: [
                                Shadow(color: Colors.white12, blurRadius: 1.0)
                              ],
                              fontSize: 20.0,
                              color: kFontColor,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 3.0,
                            ),
                          )
                        ],
                      ),
                    )
                  else
                    SizedBox(
                      width: 600.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                welcome.tr,
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: .6,
                                ),
                              ),
                              const SizedBox(width: kSpacing / 2),
                              Text(
                                toLoyaltyPointPlatform.tr,
                                style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white.withOpacity(.9),
                                  letterSpacing: .6,
                                ),
                              )
                            ],
                          ),
                          Text(
                            whereEveryoneCanEasilyParticipate.tr,
                            style: TextStyle(
                              fontSize: 18.0,
                              color: Colors.white.withOpacity(.9),
                              letterSpacing: .6,
                            ),
                          )
                        ],
                      ),
                    )
                ],
              ),
            ),
          );
        });
  }

  //page index = 0
  Widget buildSignIn() {
    final isDesktop = ResponsiveBuilder.isDesktop(context);
    final isMobile = ResponsiveBuilder.isMobile(context);
    return GetBuilder<SignInController>(
      init: SignInController(),
      builder: (signInController) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment:
              isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                if (isDesktop)
                  const SizedBox()
                else
                  const Text('ADMIN CONSOLE',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFF5271FF),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 5.0,
                      )),
                  // Image.asset(
                  //   ImageRasterPath.logoMerchantAdmin2,
                  //   height: 60.0,
                  // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    buildSetLanguage(),
                    // if (!isMobile)
                    //   Row(
                    //     children: [
                    //       const SizedBox(width: kSpacing),
                    //       InkWell(
                    //         splashColor: Colors.transparent,
                    //         focusColor: Colors.transparent,
                    //         hoverColor: Colors.transparent,
                    //         highlightColor: Colors.transparent,
                    //         onTap: () async {
                    //           if (await canLaunchUrlString('https://likepoint.io/privacy-policys')) {
                    //             await launchUrlString('https://likepoint.io/privacy-policy');
                    //           } else {
                    //             throw 'Could not launch https://likepoint.io/privacy-policy';
                    //           }
                    //         },
                    //         child: Text(
                    //           policy.tr,
                    //           style: const TextStyle(
                    //             fontSize: 14.0,
                    //             color: kFontColor,
                    //             letterSpacing: .6,
                    //           ),
                    //         ),
                    //       ),
                    //       const SizedBox(width: kSpacing),
                    //       InkWell(
                    //         splashColor: Colors.transparent,
                    //         focusColor: Colors.transparent,
                    //         hoverColor: Colors.transparent,
                    //         highlightColor: Colors.transparent,
                    //         onTap: () async {
                    //           if (await canLaunchUrlString('https://likepoint.io/terms-and-conditions')) {
                    //             await launchUrlString('https://likepoint.io/terms-and-conditions');
                    //           } else {
                    //             throw 'Could not launch https://likepoint.io/terms-and-conditions';
                    //           }
                    //         },
                    //         child: Text(
                    //           terms.tr,
                    //           style: const TextStyle(
                    //             fontSize: 14.0,
                    //             color: kFontColor,
                    //             letterSpacing: .6,
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: isDesktop
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  welcomeBack.tr,
                  style: TextStyle(
                    fontSize: isDesktop ? 42.0 : 32.0,
                    color: kFontColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .6,
                  ),
                ),
                Text(
                  signSubtext.tr,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[600],
                    letterSpacing: .6,
                  ),
                )
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  email.tr,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: kFontColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .6,
                  ),
                ),
                const SizedBox(height: kSpacing / 2),
                TextField(
                  controller: _emailLogin,
                  autofocus: false,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: kFontColor,
                    letterSpacing: .6,
                  ),
                  cursorHeight: 18.0,
                  cursorColor: Colors.grey,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    isCollapsed: true,
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: kSpacing,
                      vertical: 15.0,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kSpacing),
                      borderSide:
                          BorderSide(width: 1.4, color: Colors.grey.shade400),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kSpacing),
                      borderSide:
                          BorderSide(width: 1.4, color: Colors.grey.shade400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kSpacing),
                      borderSide:
                          BorderSide(width: 1.4, color: Colors.grey.shade400),
                    ),
                    hintText: enterEmail.tr,
                    hintStyle: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                      letterSpacing: .6,
                    ),
                  ),
                ),
                const SizedBox(height: kSpacing * 2),
                Text(
                  password.tr,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: kFontColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .6,
                  ),
                ),
                const SizedBox(height: kSpacing / 2),
                TextField(
                  controller: _passwordLogin,
                  autofocus: false,
                  style: const TextStyle(
                    fontSize: 18.0,
                    color: kFontColor,
                    letterSpacing: .6,
                  ),
                  cursorHeight: 18.0,
                  cursorColor: Colors.grey,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    isCollapsed: true,
                    fillColor: Colors.white,
                    filled: true,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: kSpacing,
                      vertical: 15.0,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kSpacing),
                      borderSide:
                          BorderSide(width: 1.4, color: Colors.grey.shade400),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kSpacing),
                      borderSide:
                          BorderSide(width: 1.4, color: Colors.grey.shade400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kSpacing),
                      borderSide:
                          BorderSide(width: 1.4, color: Colors.grey.shade400),
                    ),
                    suffixIcon: IconButton(
                      padding: const EdgeInsets.only(right: kSpacing / 2),
                      hoverColor: Colors.transparent,
                      onPressed: () => signInController.setIsObscureLogin(
                          value: !signInController.isObscureLogin.value),
                      icon: Icon(
                        signInController.isObscureLogin.value
                            ? Icons.visibility_off
                            : Icons.visibility,
                        size: 18.0,
                        color: Colors.grey[600],
                      ),
                    ),
                    hintText: enterPassword.tr,
                    hintStyle: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.grey,
                      letterSpacing: .6,
                    ),
                  ),
                  obscureText: signInController.isObscureLogin.value,
                  // obscureText: _isObscure,
                ),
                const SizedBox(height: kSpacing),
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    // onTap: () => Get.toNamed('/reset_password'),
                    child: Text(
                      forgotPassword.tr,
                      style: TextStyle(
                        fontSize: 16.0,
                        // color: Color(0xFF5271FF),
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.bold,
                        letterSpacing: .6,
                      ),
                    ),
                  ),
                )
              ],
            ),
            Column(
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // loginWithEmail();
                    // loginMerchant();
                    signInController.loginEmail(_emailLogin.text, _passwordLogin.text);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: kFontColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kBorderRadius),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(kSpacing / 2),
                      child: Text(
                        signIn.tr,
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: .6,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: kSpacing * 2),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     Text(
                //       donHaveAccount.tr,
                //       style: const TextStyle(
                //         fontSize: 18.0,
                //         color: kFontColor,
                //         letterSpacing: 1.4,
                //       ),
                //     ),
                //     const SizedBox(width: kSpacing / 2),
                //     InkWell(
                //       splashColor: Colors.transparent,
                //       focusColor: Colors.transparent,
                //       hoverColor: Colors.transparent,
                //       highlightColor: Colors.transparent,
                //       onTap: () => signInController.setPageIndex(index: 1),
                //       child: Text(
                //         signUp.tr,
                //         style: const TextStyle(
                //           fontSize: 18.0,
                //           color: kFontColor,
                //           fontWeight: FontWeight.bold,
                //           letterSpacing: 1.4,
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
              ],
            ),
            Center(
              child: InkWell(
                onTap: () {
                  // _signInWithGoogle(context);
                  print("Sign in with google");
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 5,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                          child: Image.asset(ImageRasterPath.iconGoogle,scale: 2,)
                      ),
                      Text("Sign in with google"),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox()
          ],
        );
      },
    );
  }

  buildSetLanguage() {
    return GetBuilder<LocaleController>(
      init: LocaleController(),
      builder: (localeController) {
        return Theme(
          data: Theme.of(context).copyWith(
            focusColor: Colors.transparent,
          ),
          child: DropdownButton<Locale>(
            value: Get.locale!,
            underline: const SizedBox(),
            focusColor: Colors.transparent,
            icon: const Icon(
              EvaIcons.arrowIosDownwardOutline,
              color: kFontColor,
            ),
            borderRadius: BorderRadius.circular(kBorderRadius),
            onChanged: (Locale? locale) {},
            elevation: 1,
            items: _languageList.map<DropdownMenuItem<Locale>>((
              Map<String, Object> language,
            ) {
              return DropdownMenuItem<Locale>(
                value: language['locale'] as Locale,
                onTap: () {
                  localeController.changeLanguage(
                    newLocale: language['locale'] as Locale,
                    language: language['language'] as String,
                  );
                },
                child: Text(
                  language['language'].toString(),
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: kFontColor,
                    letterSpacing: .6,
                  ),
                ),
              );
            }).toList(),
          ),
        );
      },
    );
  }

  //page index = 1
  Widget buildSignUp() {
    final isDesktop = ResponsiveBuilder.isDesktop(context);
    return GetBuilder<SignInController>(
      init: SignInController(),
      builder: (signInController) {
        return Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: kSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Align(
                  alignment:
                      isDesktop ? Alignment.topLeft : Alignment.topCenter,
                  child: Column(
                    crossAxisAlignment: isDesktop
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        signUp.tr,
                        style: const TextStyle(
                          fontSize: 32.0,
                          color: Color(0xFF5271FF),
                          fontWeight: FontWeight.bold,
                          letterSpacing: .6,
                        ),
                      ),
                      Text(
                        signUpSubtext.tr,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.grey[600],
                          letterSpacing: .6,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: kSpacing),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildTextField(
                      headText: businessName.tr,
                      hintText: enterBusinessName.tr,
                      controller: _companyNameRegister,
                    ),
                    const SizedBox(height: kSpacing),
                    Text(
                      userInformation.tr,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Color(0xFF5271FF),
                        fontWeight: FontWeight.bold,
                        letterSpacing: .6,
                      ),
                    ),
                    const SizedBox(height: kSpacing / 2),
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: buildTextField(
                            headText: firstName.tr,
                            hintText: enterFirstName.tr,
                            controller: _firstNameRegister,
                          ),
                        ),
                        const SizedBox(width: kSpacing / 2),
                        Expanded(
                          flex: 1,
                          child: buildTextField(
                            headText: lastName.tr,
                            hintText: enterLastName.tr,
                            controller: _lastNameRegister,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: kSpacing / 2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          phoneNumber.tr,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: kFontColor,
                            fontWeight: FontWeight.bold,
                            letterSpacing: .6,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1.4, color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(kBorderRadius),
                          ),
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: kSpacing),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    focusColor: Colors.transparent,
                                  ),
                                  child: DropdownButton<String>(
                                    value: _selectedOption,
                                    isDense: true,
                                    autofocus: false,
                                    elevation: 1,
                                    underline: const SizedBox(),
                                    borderRadius:
                                        BorderRadius.circular(kBorderRadius),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedOption = newValue!;
                                      });
                                    },
                                    items: <String>['+66', '+855', '+856']
                                        .map<DropdownMenuItem<String>>((
                                      String value,
                                    ) {
                                      return DropdownMenuItem(
                                          value: value,
                                          child: Text(
                                            value,
                                            style: const TextStyle(
                                              fontSize: 14.0,
                                              color: kFontColor,
                                              letterSpacing: .6,
                                            ),
                                          ));
                                    }).toList(),
                                  ),
                                ),
                              ),
                              Flexible(
                                child: TextField(
                                  controller: _phoneRegister,
                                  autofocus: false,
                                  style: const TextStyle(
                                    fontSize: 16.0,
                                    color: kFontColor,
                                    letterSpacing: .6,
                                  ),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  onChanged: (value) {
                                    if (value.startsWith('0')) {
                                      _phoneRegister.text = value.substring(1);
                                      _phoneRegister.selection =
                                          TextSelection.fromPosition(
                                              TextPosition(
                                                  offset: _phoneRegister
                                                      .text.length));
                                    }
                                  },
                                  cursorHeight: 16.0,
                                  cursorColor: kFontColor,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    isCollapsed: true,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: kSpacing,
                                      vertical: 15.0,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(kBorderRadius),
                                      borderSide: BorderSide.none,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(kBorderRadius),
                                      borderSide: BorderSide.none,
                                    ),
                                    hintText: enterPhoneNumber.tr,
                                    hintStyle: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey[600],
                                      letterSpacing: .6,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: kSpacing / 2),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          email.tr,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: kFontColor,
                            fontWeight: FontWeight.bold,
                            letterSpacing: .6,
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        TextField(
                          controller: _emailRegister,
                          autofocus: false,
                          style: const TextStyle(
                            fontSize: 16.0,
                            color: kFontColor,
                            letterSpacing: .6,
                          ),
                          cursorHeight: 16.0,
                          cursorColor: kFontColor,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            isCollapsed: true,
                            fillColor: Colors.white,
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: kSpacing,
                              vertical: 15.0,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kSpacing),
                              borderSide: BorderSide(
                                  width: 1.4, color: Colors.grey.shade400),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kSpacing),
                              borderSide: BorderSide(
                                  width: 1.4, color: Colors.grey.shade400),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(kSpacing),
                              borderSide: BorderSide(
                                  width: 1.4, color: Colors.grey.shade400),
                            ),
                            hintText: enterEmail.tr,
                            hintStyle: TextStyle(
                              fontSize: 16.0,
                              color: Colors.grey[600],
                              letterSpacing: .6,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: kSpacing / 2),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                password.tr,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: kFontColor,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: .6,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              TextField(
                                controller: _passwordRegister,
                                autofocus: false,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: kFontColor,
                                  letterSpacing: .6,
                                ),
                                cursorHeight: 16.0,
                                cursorColor: kFontColor,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  isCollapsed: true,
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: kSpacing,
                                    vertical: 15.0,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(kSpacing),
                                    borderSide: BorderSide(
                                        width: 1.4,
                                        color: Colors.grey.shade400),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(kSpacing),
                                    borderSide: BorderSide(
                                        width: 1.4,
                                        color: Colors.grey.shade400),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(kSpacing),
                                    borderSide: BorderSide(
                                        width: 1.4,
                                        color: Colors.grey.shade400),
                                  ),
                                  suffixIcon: IconButton(
                                    padding: const EdgeInsets.only(
                                        right: kSpacing / 2),
                                    hoverColor: Colors.transparent,
                                    onPressed: () =>
                                        signInController.setIsObscureRegister(
                                            value: !signInController
                                                .isObscureRegister.value),
                                    icon: Icon(
                                      signInController.isObscureRegister.value
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      size: 18.0,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  hintText: enterPassword.tr,
                                  hintStyle: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey[600],
                                    letterSpacing: .6,
                                  ),
                                ),
                                obscureText:
                                    signInController.isObscureRegister.value,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: kSpacing / 2),
                        Flexible(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                confirmPassword.tr,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: kFontColor,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: .6,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              TextField(
                                controller: _confirmPasswordRegister,
                                autofocus: false,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: kFontColor,
                                  letterSpacing: .6,
                                ),
                                cursorHeight: 16.0,
                                cursorColor: kFontColor,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  isCollapsed: true,
                                  fillColor: Colors.white,
                                  filled: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: kSpacing,
                                    vertical: 15.0,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(kSpacing),
                                    borderSide: BorderSide(
                                        width: 1.4,
                                        color: Colors.grey.shade400),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(kSpacing),
                                    borderSide: BorderSide(
                                        width: 1.4,
                                        color: Colors.grey.shade400),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(kSpacing),
                                    borderSide: BorderSide(
                                        width: 1.4,
                                        color: Colors.grey.shade400),
                                  ),
                                  suffixIcon: IconButton(
                                    padding: const EdgeInsets.only(
                                        right: kSpacing / 2),
                                    hoverColor: Colors.transparent,
                                    onPressed: () {
                                      // signInController.setIsObscureRegister(value: !signInController.isObscureRegister.value);
                                    },
                                    icon: Icon(
                                      // signInController.isObscureRegister.value ? Icons.visibility_off : Icons.visibility,
                                      Icons.visibility,
                                      size: 18.0,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                  hintText: enterConfirmPassword.tr,
                                  hintStyle: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey[600],
                                    letterSpacing: .6,
                                  ),
                                ),
                                obscureText:
                                    signInController.isObscureRegister.value,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: kSpacing / 2),
                    Text(
                      passwordConditions.tr,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: kFontColor,
                        letterSpacing: .6,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kSpacing * 2),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: kSpacing / 2),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () => signInController.setIsAgree(
                            value: !signInController.isAgree.value),
                        child: Icon(
                          signInController.isAgree.value
                              ? EvaIcons.checkmarkSquare2Outline
                              : EvaIcons.squareOutline,
                          size: 24.0,
                          color: const Color(0xFF5271FF),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5.0),
                    Flexible(
                      child: Wrap(
                        runAlignment: WrapAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Text(
                              haveReadAndAgree.tr,
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: kFontColor,
                                letterSpacing: .6,
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              // if (await canLaunchUrlString('https://likepoint.io/terms-and-conditions')) {
                              //   await launchUrlString('https://likepoint.io/terms-and-conditions');
                              // } else {
                              //   throw 'Could not launch https://likepoint.io/terms-and-conditions';
                              // }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Text(
                                termsAndConditions.tr,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Color(0xFF5271FF),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: .6,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Text(
                              and.tr,
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: kFontColor,
                                letterSpacing: .6,
                              ),
                            ),
                          ),
                          InkWell(
                            splashColor: Colors.transparent,
                            focusColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () async {
                              // if (await canLaunchUrlString('https://likepoint.io/terms-and-conditions')) {
                              //   await launchUrlString('https://likepoint.io/terms-and-conditions');
                              // } else {
                              //   throw 'Could not launch https://likepoint.io/terms-and-conditions';
                              // }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5.0),
                              child: Text(
                                privacyPolicy.tr,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Color(0xFF5271FF),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: .6,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Text(
                              readAndAgreeLikepoint.tr,
                              style: const TextStyle(
                                fontSize: 16.0,
                                color: kFontColor,
                                letterSpacing: .6,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kSpacing * 2),
                ElevatedButton(
                  onPressed: () {
                    signInController.signupEmail(
                        _emailRegister.text,
                        _passwordRegister.text,
                        _firstNameRegister.text,
                        _lastNameRegister.text,
                        _phoneRegister.text);
                    // if (signInController.isAgree.value && _companyNameRegister.text.isNotEmpty && _firstNameRegister.text.isNotEmpty && _lastNameRegister.text.isNotEmpty && _phoneRegister.text.isNotEmpty && _emailRegister.text.isNotEmpty && _passwordRegister.text.isNotEmpty && _confirmPasswordRegister.text.isNotEmpty) {
                    //   signInController.checkIsPasswordVisible(
                    //     password: _passwordRegister.text,
                    //   );
                    //   if (signInController.isPasswordVisible.value) {
                    //     signInController.checkIsPasswordConfirmed(
                    //       password: _passwordRegister.text,
                    //       confirmedPassword: _confirmPasswordRegister.text,
                    //     );
                    //     if (signInController.isPasswordConfirmed.value) {
                    //       getRegister();
                    //     } else {
                    //       Get.snackbar(
                    //         failed.tr,
                    //         alertConfirmPasswordIncorrect.tr,
                    //         maxWidth: 400.0,
                    //         backgroundColor: Colors.red[400],
                    //         colorText: Colors.white,
                    //         snackPosition: SnackPosition.TOP,
                    //         margin: const EdgeInsets.only(top: kSpacing),
                    //       );
                    //     }
                    //   } else {
                    //     Get.snackbar(
                    //       failed.tr,
                    //       alertPasswordConditions.tr,
                    //       maxWidth: 400.0,
                    //       backgroundColor: Colors.red[400],
                    //       colorText: Colors.white,
                    //       snackPosition: SnackPosition.TOP,
                    //       margin: const EdgeInsets.only(top: kSpacing),
                    //     );
                    //   }
                    // } else {
                    //   Get.snackbar(
                    //     failed.tr,
                    //     alertHaveReadAndAgree.tr,
                    //     maxWidth: 400.0,
                    //     backgroundColor: Colors.red[400],
                    //     colorText: Colors.white,
                    //     snackPosition: SnackPosition.TOP,
                    //     margin: const EdgeInsets.only(top: kSpacing),
                    //   );
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: kFontColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(kBorderRadius),
                    ),
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(kSpacing / 2),
                      child: Text(
                        signUp.tr,
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: .6,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: kSpacing * 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      alreadyHaveAccount.tr,
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: kFontColor,
                        letterSpacing: .6,
                      ),
                    ),
                    const SizedBox(width: kSpacing / 2),
                    InkWell(
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () => signInController.setPageIndex(index: 0),
                      child: Text(
                        signIn.tr,
                        style: const TextStyle(
                          fontSize: 18.0,
                          color: kFontColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: .6,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildTextField({
    required String headText,
    required String hintText,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          headText,
          style: const TextStyle(
            fontSize: 18.0,
            color: kFontColor,
            fontWeight: FontWeight.bold,
            letterSpacing: .6,
          ),
        ),
        const SizedBox(height: kSpacing / 2),
        TextField(
          controller: controller,
          autofocus: false,
          style: const TextStyle(
            fontSize: 16.0,
            color: kFontColor,
            letterSpacing: .6,
          ),
          cursorHeight: 16.0,
          cursorColor: kFontColor,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            isCollapsed: true,
            fillColor: Colors.white,
            filled: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: kSpacing,
              vertical: 15.0,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kSpacing),
              borderSide: BorderSide(width: 1.4, color: Colors.grey.shade400),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kSpacing),
              borderSide: BorderSide(width: 1.4, color: Colors.grey.shade400),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(kSpacing),
              borderSide: BorderSide(width: 1.4, color: Colors.grey.shade400),
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              fontSize: 16.0,
              color: Colors.grey[600],
              letterSpacing: .6,
            ),
          ),
        )
      ],
    );
  }

  //page index = 2
  Widget buildCheckEmail() {
    return GetBuilder<SignInController>(
        init: SignInController(),
        builder: (signInController) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Lottie.asset(
                    ImageVectorPath.imageDone,
                    repeat: false,
                    height: 300.0,
                  ),
                ),
                Text(
                  verifyYourEmail.tr,
                  style: const TextStyle(
                    fontSize: 24.0,
                    color: Color(0xFF5271FF),
                    fontWeight: FontWeight.bold,
                    letterSpacing: .6,
                  ),
                ),
                const SizedBox(height: kSpacing / 2),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      verifySubtext1.tr,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: kFontColor,
                        letterSpacing: .6,
                      ),
                    ),
                    Text(
                      _emailRegister.text,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: kFontColor,
                        fontWeight: FontWeight.bold,
                        letterSpacing: .6,
                      ),
                    ),
                    Text(
                      verifySubtext2.tr,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: kFontColor,
                        letterSpacing: .6,
                      ),
                    ),
                    Text(
                      verifySubtext3.tr,
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: kFontColor,
                        letterSpacing: .6,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: kSpacing),
                Text(
                  verifySubtext4.tr,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: kFontColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .6,
                  ),
                ),
                const SizedBox(height: kSpacing * 2),
                if (signInController.isSendEmail.value > 0 &&
                    signInController.isSendEmail.value < 30)
                  Container(
                    width: 200,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    decoration: BoxDecoration(
                      color: kFontColor,
                      borderRadius: BorderRadius.circular(kBorderRadius),
                    ),
                    child: Text(
                      '${signInController.isSendEmail.value} ${seconds.tr}',
                      style: const TextStyle(
                        fontSize: 16.0,
                        color: Colors.white,
                        letterSpacing: .6,
                      ),
                    ),
                  )
                else
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    // onTap: () => signInController.startTimer(),
                    child: Container(
                      width: 200,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      decoration: BoxDecoration(
                        color: kFontColor,
                        borderRadius: BorderRadius.circular(kBorderRadius),
                      ),
                      child: Text(
                        sendAgain.tr,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          letterSpacing: .6,
                        ),
                      ),
                    ),
                  )
              ],
            ),
          );
        });
  }

  //
  // loginWithEmail(){
  //   try{
  //     AppLoader.loader(context);
  //     if(_emailLogin.text.isNotEmpty && _passwordLogin.text.isNotEmpty){
  //       FirebaseAuth.instance.signInWithEmailAndPassword(email: _emailLogin.text, password: _passwordLogin.text).then((value) {
  //       Get.offAllNamed('/dashboard');
  //       }
  //       );}}catch(e){
  //     print(e);
  //   }
  // }
  //
  // Future<void> _signInWithGoogle(BuildContext context) async {
  //   final FirebaseAuth _auth = FirebaseAuth.instance;
  //   try {
  //     final GoogleSignInAccount? googleSignInAccount = await GoogleSignIn(
  //       clientId: '915749193055-b85tn40gkjuqt8iolpifv8ho7sddi96c.apps.googleusercontent.com',
  //       scopes: [
  //         'email',
  //         'https://www.googleapis.com/auth/contacts.readonly',
  //       ],
  //     ).signIn();
  //     final GoogleSignInAuthentication? googleSignInAuthentication =
  //     await googleSignInAccount?.authentication;
  //     if (googleSignInAccount != null && googleSignInAuthentication != null) {
  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleSignInAuthentication.accessToken,
  //         idToken: googleSignInAuthentication.idToken,
  //       );
  //
  //       // Show loader while processing
  //       AppLoader.loader(context);
  //
  //       var data = await _auth.signInWithCredential(credential);
  //
  //       // Check if data.user is of type User before accessing properties
  //       if (data.user is User) {
  //         User user = data.user as User;
  //
  //         // Access properties like uid, displayName, email, etc.
  //         var uid = user.uid;
  //         var displayName = user.displayName;
  //         var email = user.email;
  //         var creationTime = user.metadata.creationTime.toString();
  //         var lastSignInTime = user.metadata.lastSignInTime.toString();
  //
  //         Map<String, dynamic> userData = {
  //           'UID': uid,
  //           'name': displayName,
  //           'email': email,
  //           'create_time': creationTime,
  //           'last_time': lastSignInTime,
  //         };
  //         // print(userData);
  //         // var regis = Get.put(SignInController());
  //         var regis = Get.find<SignInController>();
  //         var userControl = Get.find<UserController>();
  //
  //         // Assuming register is a function that registers the user in your system
  //         await regis.register(userData);
  //         await userControl.getDataUser(email!);
  //
  //         // Navigate to the dashboard after successful registration
  //         Get.offAllNamed('/dashboard');
  //       } else {
  //         // Handle the case when data.user is not a User object
  //         print('Invalid data.user type: ${data.user.runtimeType}');
  //       }
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     // Handle authentication exception
  //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //       content: Text(e.message ?? 'An error occurred'),
  //     ));
  //   }
  // }

}
