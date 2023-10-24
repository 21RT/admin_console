import 'dart:math';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animated_text_lerp/animated_text_lerp.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:moneymaker/controller/getController/components/appbarControl.dart';
import 'package:moneymaker/controller/getController/settingControl/swapControl/swapSettingController.dart';

import 'package:moneymaker/controller/getController/userControl/userControl.dart';
import 'package:moneymaker/controller/getController/userControl/userControl.dart';
import 'package:moneymaker/controller/translation/translation_key.dart';
import 'package:moneymaker/model/theme/app_constants.dart';
import 'package:moneymaker/model/theme/sizebox_wiget.dart';
import 'package:moneymaker/view/components/admin_drawer.dart';
import 'package:moneymaker/view/components/appbar.dart';
import 'package:moneymaker/view/components/responsive_builder.dart';
import 'package:random_avatar/random_avatar.dart';

import '../controller/getController/userControl/userControl.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _scrollController = ScrollController();

  double padding = 0;

  List firstNames = [
    "Alice",
    "Bob",
    "Charlie",
    "David",
    "Eva",
    "Frank",
    "Grace",
    "Helen",
    "Ivy",
    "Jack"
  ];
  List lastNames = [
    "Smith",
    "Johnson",
    "Brown",
    "Davis",
    "Lee",
    "Wilson",
    "Clark",
    "Hall",
    "Wright",
    "Young"
  ];

  String selectedValue = '';
  List<String> selectedValues = [];
  List<String> options = [
    '',
    'Activated',
    'Status',
    'PIN',
    'Ask to recover PIN',
    'Skip SMS verification',
    'Referral Code',
    'Inherit user',
    'KYC Status',
    'Extra Info'
  ];
  bool isFirstTime = true;
  var userController = Get.find<UserController>();
  TextEditingController coinController = TextEditingController();
  TextEditingController feeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    userController.getDataUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // Get.put(UserController()).getDataUser();

            if(padding == 30){
              padding = 0;
            } else {
              padding = 30;
            }

            setState(() {});
          },
          backgroundColor: Colors.red,
        ),
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        endDrawer: AdminDrawer(),
        body:
            // body: Container(
            //   width: Get.width,
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage(ImageRasterPath.imageBg2),
            //       repeat: ImageRepeat.repeat,
            //       colorFilter: ColorFilter.mode(
            //         Colors.white, // Overlay color
            //         BlendMode.modulate, // Adjust blend mode as needed
            //       ),
            //     ),
            //     gradient: LinearGradient(
            //       begin: Alignment.topCenter,
            //       end: Alignment.bottomCenter,
            //       colors: <Color>[
            //         Color(0xFF5271FF),
            //         Color(0xFFA2A2FF),
            //       ],
            //     ),
            //   ),
            //   child:
            Stack(
          children: <Widget>[
            buildContent(),
            AppBarAdmin(scaffoldKey: _scaffoldKey),
            // AppBar(scaffoldKey: _scaffoldKey),
            // AppBarLikepoint(scaffoldKey: _scaffoldKey),
          ],
        )
        // ),
        );
  }

  Widget buildContent() {
    return GetBuilder<AppBarController>(
      init: AppBarController(),
      builder: (appBarController) {
        return ResponsiveBuilder(
          mobileBuilder: (context, constraints) {
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification) {
                  appBarController
                      .setScrollController(_scrollController.offset);
                }
                return true;
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    // image: DecorationImage(
                    //   image: AssetImage(ImageRasterPath.imageBg2),
                    //   repeat: ImageRepeat.repeat,
                    //   colorFilter: ColorFilter.mode(
                    //     Colors.white, // Overlay color
                    //     BlendMode.modulate, // Adjust blend mode as needed
                    //   ),
                    // ),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        Color(0xFF8C52FF),
                        Color(0xFF5CE1E6).withOpacity(0.8),
                        // Color(0xFF8989FF),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kSpacing / 2),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: 1440.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: kSpacing * 5),
                            buildHeadText(),
                            const SizedBox(height: kSpacing),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: kSpacing * 1.5,
                                vertical: kSpacing,
                              ),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: kFontColor,
                                borderRadius:
                                    BorderRadius.circular(kBorderRadius),
                              ),
                              // child: buildTotalBalance(),
                            ),
                            const SizedBox(height: kSpacing / 2),
                            Container(
                              height: 280.0,
                              alignment: Alignment.center,
                              child: const Text('Say..Hi Mobile'),
                              // child: buildSayHi(),
                            ),
                            const SizedBox(height: kSpacing / 2),
                            Container(
                              height: 360.0,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                horizontal: kSpacing * 1.5,
                                vertical: kSpacing * 1.5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(kBorderRadius),
                              ),
                              child: buildBalanceSummary(),
                            ),
                            const SizedBox(height: kSpacing / 2),
                            Container(
                              height: 160.0,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                horizontal: kSpacing * 1.5,
                                // vertical: kSpacing * 1.5,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border:
                                    Border.all(width: 1.2, color: Colors.white),
                                borderRadius:
                                    BorderRadius.circular(kBorderRadius),
                                image: const DecorationImage(
                                  alignment: Alignment.center,
                                  image: AssetImage(ImageRasterPath.imageBg2),
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              child: buildLikepointCommunity(),
                            ),
                            const SizedBox(height: kSpacing / 2),
                            Container(
                              height: 400.0,
                              padding: const EdgeInsets.all(kSpacing / 2),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: kFontColor,
                                borderRadius:
                                    BorderRadius.circular(kBorderRadius),
                              ),
                              child: buildPointReport(),
                            ),
                            const SizedBox(height: kSpacing / 2),
                            Container(
                              height: 600.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(kBorderRadius),
                              ),
                              child: const Text('ระดับความร่วมมือกิจกรรม'),
                            ),
                            const SizedBox(height: kSpacing / 2),
                            Container(
                              height: 600.0,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.circular(kBorderRadius),
                              ),
                              child: const Text('ระดับผู้ใช้งาน'),
                            ),
                            const SizedBox(height: kSpacing / 2),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          tabletBuilder: (context, constraints) {
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification) {
                  appBarController
                      .setScrollController(_scrollController.offset);
                }
                return true;
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
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
                        Color(0xFF8C52FF),
                        Color(0xFF5CE1E6).withOpacity(0.8),
                        // Color(0xFF8989FF),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kSpacing),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: 1440.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: kSpacing * 5),
                            buildHeadText(),
                            const SizedBox(height: kSpacing),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kSpacing * 2, vertical: kSpacing),
                              decoration: BoxDecoration(
                                color: kFontColor,
                                borderRadius:
                                    BorderRadius.circular(kBorderRadius),
                              ),
                              // child: buildTotalBalance(),
                            ),
                            const SizedBox(height: kSpacing / 2),
                            Row(
                              children: <Widget>[
                                Flexible(
                                  flex: 3,
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 350.0,
                                        alignment: Alignment.center,
                                        padding:
                                            const EdgeInsets.all(kSpacing * 2),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              kBorderRadius),
                                        ),
                                        child: const Text('Say..Hi Tablet'),
                                        // child: buildSayHi(),
                                      ),
                                      const SizedBox(height: kSpacing / 2),
                                      Container(
                                        height: 140.0,
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: kSpacing * 2),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              width: 1.2, color: Colors.white),
                                          borderRadius: BorderRadius.circular(
                                              kBorderRadius),
                                          image: const DecorationImage(
                                            alignment: Alignment.center,
                                            image: AssetImage(
                                                ImageRasterPath.imageBg2),
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                        child: buildLikepointCommunity(),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: kSpacing / 2),
                                Flexible(
                                  flex: 2,
                                  child: Container(
                                    height: 500.0,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: kSpacing,
                                      vertical: kSpacing * 1.5,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(kBorderRadius),
                                    ),
                                    child: buildBalanceSummary(),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: kSpacing / 2),
                            Container(
                              height: 500.0,
                              padding: const EdgeInsets.all(kSpacing * 1.5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: kFontColor,
                                borderRadius:
                                    BorderRadius.circular(kBorderRadius),
                              ),
                              child: buildPointReport(),
                            ),
                            const SizedBox(height: kSpacing / 2),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Flexible(
                                  flex: 3,
                                  child: Container(
                                    height: 700.0,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(kBorderRadius),
                                    ),
                                    child:
                                        const Text('ระดับความร่วมมือกิจกรรม'),
                                  ),
                                ),
                                const SizedBox(width: kSpacing / 2),
                                Flexible(
                                  flex: 2,
                                  child: Container(
                                    height: 700.0,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius:
                                          BorderRadius.circular(kBorderRadius),
                                    ),
                                    child: const Text('ระดับผู้ใช้งาน'),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: kSpacing / 2),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          desktopBuilder: (context, constraints) {
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification) {
                  appBarController
                      .setScrollController(_scrollController.offset);
                }
                return true;
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
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
                        Color(0xFF8C52FF),
                        Color(0xFF5CE1E6).withOpacity(0.8),
                        // Color(0xFF8989FF),
                      ],
                    ),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: kSpacing * 2),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: 1440.0,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: kSpacing * 5),
                            buildHeadText(),
                            const SizedBox(height: kSpacing * 2),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Flexible(
                                  flex: 3,
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          height: 300.0,
                                          alignment: Alignment.center,
                                          padding: const EdgeInsets.all(
                                              kSpacing * 2),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(.1),
                                                blurRadius: 1.0,
                                              )
                                            ],
                                            borderRadius: BorderRadius.circular(
                                                kBorderRadius),
                                          ),
                                          child: buildSayHi(),
                                        ),
                                        const SizedBox(height: kSpacing / 2),

                                        /// ย้ายที่
                                        // Row(
                                        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //   children: [
                                        //     Container(
                                        //       height: 520.0,
                                        //       padding: const EdgeInsets.all(kSpacing * 1.5),
                                        //       decoration: BoxDecoration(
                                        //         color: kFontColor,
                                        //         boxShadow: [
                                        //           BoxShadow(
                                        //             color: Colors.black.withOpacity(.1),
                                        //             blurRadius: 1.0,
                                        //           )
                                        //         ],
                                        //         borderRadius: BorderRadius.circular(kBorderRadius),
                                        //       ),
                                        //       child: buildPointReport(),
                                        //     ),
                                        //     Container(
                                        //       height: 520.0,
                                        //       padding: const EdgeInsets.all(kSpacing * 1.5),
                                        //       decoration: BoxDecoration(
                                        //         color: kFontColor,
                                        //         boxShadow: [
                                        //           BoxShadow(
                                        //             color: Colors.black.withOpacity(.1),
                                        //             blurRadius: 1.0,
                                        //           )
                                        //         ],
                                        //         borderRadius: BorderRadius.circular(kBorderRadius),
                                        //       ),
                                        //       child: buildPointReport(),
                                        //     ),
                                        //   ],
                                        // ),
                                        const SizedBox(height: kSpacing / 2),

                                        /// ปิดระดับแคมเปญ
                                        // Container(
                                        //   height: 800.0,
                                        //   decoration: BoxDecoration(
                                        //     color: Colors.white,
                                        //     boxShadow: [
                                        //       BoxShadow(
                                        //         color: Colors.black.withOpacity(.1),
                                        //         blurRadius: 1.0,
                                        //       )
                                        //     ],
                                        //     borderRadius: BorderRadius.circular(kBorderRadius),
                                        //   ),
                                        //   child: Column(
                                        //     crossAxisAlignment: CrossAxisAlignment.start,
                                        //     children: <Widget>[
                                        //       Container(
                                        //         height: 60.0,
                                        //         padding: const EdgeInsets.symmetric(horizontal: kSpacing),
                                        //         child: Row(
                                        //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //           children: <Widget>[
                                        //             const Text(
                                        //               // 'Campaigns budget',
                                        //               'งบประมาณแคมเปญ',
                                        //               style: TextStyle(
                                        //                 fontSize: 18.0,
                                        //                 color: Color(0xFF5271FF),
                                        //                 fontWeight: FontWeight.bold,
                                        //                 letterSpacing: 1.6,
                                        //               ),
                                        //             ),
                                        //             Text(
                                        //               '01/10/23-31/12/23',
                                        //               style: TextStyle(
                                        //                 fontSize: 14.0,
                                        //                 color: Colors.grey[700],
                                        //                 letterSpacing: 1.4,
                                        //               ),
                                        //             ),
                                        //           ],
                                        //         ),
                                        //       ),
                                        //       Expanded(
                                        //         child: SingleChildScrollView(
                                        //           padding: const EdgeInsets.symmetric(horizontal: kSpacing),
                                        //           child: Column(
                                        //             children: <Widget>[
                                        //               for (int i = 0; i < 5; i++)
                                        //                 Container(
                                        //                   margin: const EdgeInsets.symmetric(vertical: kSpacing / 2),
                                        //                   padding: const EdgeInsets.symmetric(
                                        //                     horizontal: kSpacing * 1.5,
                                        //                     vertical: kSpacing,
                                        //                   ),
                                        //                   decoration: BoxDecoration(
                                        //                     color: Colors.grey[200],
                                        //                     borderRadius: BorderRadius.circular(kBorderRadius),
                                        //                   ),
                                        //                   child: Row(
                                        //                     crossAxisAlignment: CrossAxisAlignment.start,
                                        //                     children: <Widget>[
                                        //                       Expanded(
                                        //                         flex: 2,
                                        //                         child: Column(
                                        //                           children: <Widget>[
                                        //                             Row(
                                        //                               children: const <Widget>[
                                        //                                 CircleAvatar(
                                        //                                   radius: 7.0,
                                        //                                   backgroundColor: Color(0xFF5271FF),
                                        //                                 ),
                                        //                                 SizedBox(width: kSpacing / 2),
                                        //                                 Text(
                                        //                                   'กิจกรรมแคมเปญออกรถใหม่ 2023',
                                        //                                   maxLines: 1,
                                        //                                   style: TextStyle(
                                        //                                     fontSize: 16.0,
                                        //                                     color: kFontColor,
                                        //                                     fontWeight: FontWeight.bold,
                                        //                                     letterSpacing: 1.2,
                                        //                                   ),
                                        //                                 ),
                                        //                               ],
                                        //                             ),
                                        //                             const SizedBox(height: 5.0),
                                        //                             const Text(
                                        //                               'A marketing plan is a comprehensive document or blueprint  comprehensive document or blueprint',
                                        //                               maxLines: 3,
                                        //                               style: TextStyle(
                                        //                                 height: 1.4,
                                        //                                 fontSize: 12.0,
                                        //                                 color: kFontColor,
                                        //                                 letterSpacing: 1.2,
                                        //                               ),
                                        //                             )
                                        //                           ],
                                        //                         ),
                                        //                       ),
                                        //                       const SizedBox(width: kSpacing / 2),
                                        //                       Expanded(
                                        //                         flex: 3,
                                        //                         child: Column(
                                        //                           children: <Widget>[
                                        //                             Row(
                                        //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //                               crossAxisAlignment: CrossAxisAlignment.start,
                                        //                               children: <Widget>[
                                        //                                 Column(
                                        //                                   crossAxisAlignment: CrossAxisAlignment.start,
                                        //                                   children: <Widget>[
                                        //                                     Row(
                                        //                                       children: const <Widget>[
                                        //                                         Text(
                                        //                                           '12,345,678',
                                        //                                           style: TextStyle(
                                        //                                             fontSize: 18.0,
                                        //                                             color: Color(0xFF5271FF),
                                        //                                             fontWeight: FontWeight.bold,
                                        //                                             letterSpacing: 1.4,
                                        //                                           ),
                                        //                                         ),
                                        //                                         SizedBox(width: 5.0),
                                        //                                         Text(
                                        //                                           'BU Point',
                                        //                                           style: TextStyle(
                                        //                                             fontSize: 16.0,
                                        //                                             color: Color(0xFF5271FF),
                                        //                                             fontWeight: FontWeight.bold,
                                        //                                             letterSpacing: 1.2,
                                        //                                           ),
                                        //                                         ),
                                        //                                       ],
                                        //                                     ),
                                        //                                     const Text(
                                        //                                       '(100,000 BU Point / ครั้ง)',
                                        //                                       style: TextStyle(
                                        //                                         fontSize: 12.0,
                                        //                                         color: kFontColor,
                                        //                                         fontWeight: FontWeight.bold,
                                        //                                         letterSpacing: .8,
                                        //                                       ),
                                        //                                     ),
                                        //                                   ],
                                        //                                 ),
                                        //                                 const Text(
                                        //                                   'จำนวน 12,345 ครั้ง',
                                        //                                   style: TextStyle(
                                        //                                     fontSize: 16.0,
                                        //                                     color: kFontColor,
                                        //                                     fontWeight: FontWeight.bold,
                                        //                                     letterSpacing: 1.2,
                                        //                                   ),
                                        //                                 ),
                                        //                               ],
                                        //                             ),
                                        //                             const SizedBox(height: kSpacing),
                                        //                             Row(
                                        //                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        //                               children: [
                                        //                                 Container(
                                        //                                   width: 400.0,
                                        //                                   height: 20.0,
                                        //                                   alignment: Alignment.centerLeft,
                                        //                                   decoration: BoxDecoration(
                                        //                                     color: Colors.white,
                                        //                                     border: Border.all(width: 1.2, color: Colors.grey.shade300),
                                        //                                     borderRadius: BorderRadius.circular(kBorderRadius),
                                        //                                   ),
                                        //                                   child: Container(
                                        //                                     width: 200.0,
                                        //                                     decoration: BoxDecoration(
                                        //                                       borderRadius: BorderRadius.circular(kBorderRadius),
                                        //                                       gradient: const LinearGradient(
                                        //                                         begin: Alignment.topCenter,
                                        //                                         end: Alignment.bottomCenter,
                                        //                                         colors: <Color>[
                                        //                                           Color(0xFF5271FF),
                                        //                                           Color(0xFF748DFF),
                                        //                                           Color(0xFF5271FF),
                                        //                                         ],
                                        //                                       ),
                                        //                                     ),
                                        //                                   ),
                                        //                                 ),
                                        //                                 const Text(
                                        //                                   '50%',
                                        //                                   style: TextStyle(
                                        //                                     fontSize: 14.0,
                                        //                                     color: kFontColor,
                                        //                                     fontWeight: FontWeight.bold,
                                        //                                     letterSpacing: 1.2,
                                        //                                   ),
                                        //                                 )
                                        //                               ],
                                        //                             )
                                        //                           ],
                                        //                         ),
                                        //                       ),
                                        //                     ],
                                        //                   ),
                                        //                 )
                                        //             ],
                                        //           ),
                                        //         ),
                                        //       )
                                        //     ],
                                        //   ),
                                        // ),

                                        const SizedBox(height: kSpacing),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: kSpacing / 2),
                                Flexible(
                                  flex: 2,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      /// ปิด ตรงเป็นกล่องว่างกับ สรุป
                                      // Container(
                                      //   height: 180.0,
                                      //   padding: const EdgeInsets.symmetric(horizontal: kSpacing * 1.5),
                                      //   decoration: BoxDecoration(
                                      //     color: kFontColor,
                                      //     boxShadow: [
                                      //       BoxShadow(
                                      //         color: Colors.black.withOpacity(.1),
                                      //         blurRadius: 1.0,
                                      //       )
                                      //     ],
                                      //     borderRadius: BorderRadius.circular(kBorderRadius),
                                      //   ),
                                      //   // child: buildTotalBalance(),
                                      // ),
                                      // const SizedBox(height: kSpacing / 2),
                                      // Container(
                                      //   height: 360.0,
                                      //   alignment: Alignment.center,
                                      //   padding: const EdgeInsets.symmetric(
                                      //     horizontal: kSpacing * 1.5,
                                      //     vertical: kSpacing * 1.5,
                                      //   ),
                                      //   decoration: BoxDecoration(
                                      //     color: Colors.white,
                                      //     boxShadow: [
                                      //       BoxShadow(
                                      //         color: Colors.black.withOpacity(.1),
                                      //         blurRadius: 1.0,
                                      //       )
                                      //     ],
                                      //     borderRadius: BorderRadius.circular(kBorderRadius),
                                      //   ),
                                      //   child: buildBalanceSummary(),
                                      // ),
                                      // const SizedBox(height: kSpacing / 2),
                                      Container(
                                        height: 300.0,
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: kSpacing * 1.5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(.1),
                                              blurRadius: 1.0,
                                            )
                                          ],
                                          borderRadius: BorderRadius.circular(
                                              kBorderRadius),
                                        ),
                                        child: buildLikepointCommunity(),
                                      ),
                                      const SizedBox(height: kSpacing / 2),

                                      ///ย้ายที่เฉยๆ
                                      // Container(
                                      //   height: 800.0,
                                      //   padding: const EdgeInsets.symmetric(horizontal: kSpacing / 2),
                                      //   alignment: Alignment.center,
                                      //   decoration: BoxDecoration(
                                      //     color: Colors.white,
                                      //     boxShadow: [
                                      //       BoxShadow(
                                      //         color: Colors.black.withOpacity(.1),
                                      //         blurRadius: 1.0,
                                      //       )
                                      //     ],
                                      //     borderRadius: BorderRadius.circular(kBorderRadius),
                                      //   ),
                                      //   child: Column(
                                      //     crossAxisAlignment: CrossAxisAlignment.start,
                                      //     children: <Widget>[
                                      //       Container(
                                      //         height: 70.0,
                                      //         padding: const EdgeInsets.symmetric(horizontal: kSpacing / 2),
                                      //         child: Row(
                                      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      //           children: <Widget>[
                                      //             const Text(
                                      //               // 'Top high engagement',
                                      //               'ระดับผู้ใช้งาน',
                                      //               style: TextStyle(
                                      //                 fontSize: 18.0,
                                      //                 color: kFontColor,
                                      //                 fontWeight: FontWeight.bold,
                                      //                 letterSpacing: 1.4,
                                      //               ),
                                      //             ),
                                      //             Text(
                                      //               '01/10/23-31/12/23',
                                      //               style: TextStyle(
                                      //                 fontSize: 14.0,
                                      //                 color: Colors.grey[700],
                                      //                 letterSpacing: 1.4,
                                      //               ),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //       ),
                                      //       Container(
                                      //         height: 60.0,
                                      //         padding: const EdgeInsets.symmetric(horizontal: kSpacing / 2),
                                      //         decoration: BoxDecoration(
                                      //           color: const Color(0xBFDCE2FF),
                                      //           borderRadius: BorderRadius.circular(kBorderRadius / 2),
                                      //         ),
                                      //         child: Row(
                                      //           children: <Widget>[
                                      //             Container(
                                      //               width: 50.0,
                                      //               alignment: Alignment.center,
                                      //               child: const Text(
                                      //                 '#',
                                      //                 style: TextStyle(
                                      //                   fontSize: 16.0,
                                      //                   color: Color(0xFF5271FF),
                                      //                 ),
                                      //               ),
                                      //             ),
                                      //             const SizedBox(width: kSpacing),
                                      //             const Expanded(
                                      //               child: Text(
                                      //                 // 'User',
                                      //                 'ชื่อผู้ใช้งาน',
                                      //                 style: TextStyle(
                                      //                   fontSize: 14.0,
                                      //                   color: Color(0xFF5271FF),
                                      //                   fontWeight: FontWeight.bold,
                                      //                   letterSpacing: 1.4,
                                      //                 ),
                                      //               ),
                                      //             ),
                                      //             const SizedBox(width: kSpacing / 2),
                                      //             Container(
                                      //               width: 180.0,
                                      //               alignment: Alignment.center,
                                      //               child: const Text(
                                      //                 'คะแนนที่เข้าร่วม',
                                      //                 // 'Campaigns',
                                      //                 style: TextStyle(
                                      //                   fontSize: 14.0,
                                      //                   color: Color(0xFF5271FF),
                                      //                   fontWeight: FontWeight.bold,
                                      //                   letterSpacing: 1.6,
                                      //                 ),
                                      //               ),
                                      //             ),
                                      //           ],
                                      //         ),
                                      //       ),
                                      //       Expanded(
                                      //         child: SingleChildScrollView(
                                      //           padding: const EdgeInsets.symmetric(horizontal: kSpacing / 2),
                                      //           child: Column(
                                      //             children: [
                                      //               const SizedBox(height: kSpacing),
                                      //               for (int i = 0; i < 100; i++)
                                      //                 Column(
                                      //                   children: [
                                      //                     Row(
                                      //                       children: <Widget>[
                                      //                         Container(
                                      //                           width: 50.0,
                                      //                           alignment: Alignment.center,
                                      //                           child: Text(
                                      //                             '#${i + 1}',
                                      //                             style: const TextStyle(
                                      //                               fontSize: 16.0,
                                      //                               color: kFontColor,
                                      //                               fontWeight: FontWeight.bold,
                                      //                               letterSpacing: 1.2,
                                      //                             ),
                                      //                           ),
                                      //                         ),
                                      //                         const SizedBox(width: kSpacing),
                                      //                         Expanded(
                                      //                           child: Row(
                                      //                             children: <Widget>[
                                      //                               CircleAvatar(
                                      //                                 radius: 24.0,
                                      //                                 child: SvgPicture.string(
                                      //                                   RandomAvatarString((123 + i).toString()),
                                      //                                 ),
                                      //                                 // backgroundImage:SvgPicture.string(svgCode),
                                      //                               ),
                                      //                               const SizedBox(width: kSpacing),
                                      //                               Text(
                                      //                                 '${firstNames[1]} ${lastNames[1]}',
                                      //                                 style: const TextStyle(
                                      //                                   fontSize: 16.0,
                                      //                                   color: kFontColor,
                                      //                                   letterSpacing: 1.4,
                                      //                                 ),
                                      //                               ),
                                      //                             ],
                                      //                           ),
                                      //                         ),
                                      //                         const SizedBox(width: kSpacing / 2),
                                      //                         Container(
                                      //                           width: 180.0,
                                      //                           alignment: Alignment.centerRight,
                                      //                           child: const Text(
                                      //                             '234,701 BU Point ',
                                      //                             style: TextStyle(
                                      //                               fontSize: 14.0,
                                      //                               color: kFontColor,
                                      //                               fontWeight: FontWeight.bold,
                                      //                               letterSpacing: 1.4,
                                      //                             ),
                                      //                           ),
                                      //                         ),
                                      //                       ],
                                      //                     ),
                                      //                     Divider(
                                      //                       endIndent: kSpacing,
                                      //                       indent: kSpacing,
                                      //                       color: Colors.grey[200],
                                      //                       thickness: 1.0,
                                      //                     ),
                                      //                   ],
                                      //                 ),
                                      //             ],
                                      //           ),
                                      //         ),
                                      //       ),
                                      //     ],
                                      //   ),
                                      // ),
                                      const SizedBox(height: kSpacing),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                              width: Get.width,
                              height: 500.0,
                              // color: Colors.teal,
                              // padding: const EdgeInsets.all(kSpacing * 2),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        height: 195.0,
                                        width: Get.width * 0.45,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: kSpacing * 1.5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(.1),
                                              blurRadius: 1.0,
                                            )
                                          ],
                                          borderRadius: BorderRadius.circular(
                                              kBorderRadius),
                                        ),
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(top: 40.0),
                                              child: Align(
                                                alignment: Alignment.topRight,
                                                child: Container(
                                                  height: 150,
                                                  width: 150,
                                                  // color: Colors.teal,
                                                  child: Image.asset(
                                                    ImageRasterPath.userIcon,
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: Container(
                                                    height: 20,
                                                    width: 20,
                                                    child: FaIcon(
                                                      FontAwesomeIcons
                                                          .arrowsRotate,
                                                      color: Colors.black,
                                                      size: 20,
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  "Today's data",
                                                  style: TextStyle(
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Row(
                                                  // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: const [
                                                        Text(
                                                          'จำนวนผู้ใช้งานระบบ',
                                                          style: TextStyle(
                                                              fontSize: 20.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text('20,000,000 บัญชี')
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Spacer(),
                                                Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Text(
                                                    "Yesterday's data 19,999,999 บัญชี",
                                                    style: TextStyle(
                                                        fontSize: 14.0,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // child: buildTotalBalance(),
                                          ],
                                        ),
                                      ),
                                      Container(
                                          height: 195.0,
                                          width: Get.width * 0.45,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: kSpacing * 1.5),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(.1),
                                                blurRadius: 1.0,
                                              )
                                            ],
                                            borderRadius: BorderRadius.circular(
                                                kBorderRadius),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                // color: Colors.teal,
                                                height: 195.0,
                                                width: 200,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        height: 50,
                                                        width: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Colors
                                                                    .green
                                                                    .withOpacity(
                                                                        0.2)),
                                                        child: Center(
                                                            child: FaIcon(
                                                          FontAwesomeIcons
                                                              .rightToBracket,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ))),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text("Login"),
                                                    Text('500,000')
                                                  ],
                                                ),
                                              ),
                                              VerticalDivider(
                                                color: Colors.black
                                                    .withOpacity(0.5),
                                                indent: 10,
                                                endIndent: 10,
                                              ),
                                              Container(
                                                // color: Colors.yellowAccent,
                                                height: 195.0,
                                                width: 200,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        height: 50,
                                                        width: 50,
                                                        decoration:
                                                            BoxDecoration(
                                                                shape: BoxShape
                                                                    .circle,
                                                                color: Colors
                                                                    .red
                                                                    .withOpacity(
                                                                        0.2)),
                                                        child: Center(
                                                            child: FaIcon(
                                                          FontAwesomeIcons
                                                              .rightFromBracket,
                                                          color: Colors.white,
                                                          size: 20,
                                                        ))),
                                                    SizedBox(
                                                      height: 20,
                                                    ),
                                                    Text("Logout"),
                                                    Text('500,000')
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )),
                                      const SizedBox(height: kSpacing * 1),
                                    ],
                                  ),
                                  Container(
                                    height: 440.0,
                                    width: Get.width * 0.45,
                                    padding:
                                        const EdgeInsets.all(kSpacing * 1.5),
                                    decoration: BoxDecoration(
                                      color: kFontColor,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(.1),
                                          blurRadius: 1.0,
                                        )
                                      ],
                                      borderRadius:
                                          BorderRadius.circular(kBorderRadius),
                                    ),
                                    child: buildPointReport(),
                                  ),
                                ],
                              ),
                            ),
                            // const SizedBox(height: kSpacing * 2),
                            /// ย้ายมาส่วนนี้
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Container(
                                  height: 40,
                                  width: 200,
                                  decoration: BoxDecoration(
                                      color:
                                          Colors.purpleAccent.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                      child: Text(
                                    DateFormat('d MMMM yyyy HH:mm a')
                                        .format(DateTime.now()),
                                  ))),
                            ),
                            const SizedBox(height: kSpacing * 2),
                            Container(
                              height: 800,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: kSpacing / 2),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(.1),
                                    blurRadius: 1.0,
                                  )
                                ],
                                borderRadius:
                                    BorderRadius.circular(kBorderRadius),
                              ),
                              width: Get.width,
                              alignment: Alignment.center,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 70.0,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: kSpacing / 2),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        const Text(
                                          // 'Top high engagement',
                                          'บัญชีผู้ใช้งาน',
                                          style: TextStyle(
                                            fontSize: 18.0,
                                            color: kFontColor,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.4,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Container(
                                          height: 30,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            color:
                                                Colors.black.withOpacity(0.2),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Center(
                                            child: DropdownButton<String>(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              underline: Container(),
                                              value: selectedValue,
                                              isExpanded: false,
                                              onChanged: (String? newValue) {
                                                if (newValue != null) {
                                                  selectedValues.add(newValue);
                                                  options.remove(newValue);
                                                } else {
                                                  selectedValues
                                                      .remove(selectedValue);
                                                }
                                                isFirstTime = false;
                                                setState(() {});
                                              },
                                              items:
                                                  options.map((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                        // Container(
                                        //   height: 40,
                                        //   width: 40,
                                        //   decoration: BoxDecoration(
                                        //       color: Colors.black.withOpacity(0.1),
                                        //      shape: BoxShape.circle
                                        //   ),
                                        //   child: Center(
                                        //     child: FaIcon(
                                        //       FontAwesomeIcons.arrowsRotate,
                                        //       color: Colors.white,
                                        //       size: 20,
                                        //     ),
                                        //   ),
                                        // )
                                        // Text(
                                        //   '01/10/23-31/12/23',
                                        //   style: TextStyle(
                                        //     fontSize: 14.0,
                                        //     color: Colors.grey[700],
                                        //     letterSpacing: 1.4,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                  ),
                                  Divider(
                                    color: Colors.black,
                                    thickness: 0.5,
                                    indent: 0,
                                    endIndent: 0,
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Container(
                                      width: Get.width * 2,
                                      height: Get.height - 100,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              // buildHeadTable('SP', 100.0),
                                              buildHeadTable('Name', 200.0),
                                              buildHeadTable('E-mail', 300.0),
                                              buildHeadTable(
                                                  'Create Time', 200.0),
                                              buildHeadTable('UID', 250.0),
                                              buildHeadTable(
                                                  'Last Time', 200.0),
                                              for (int i = 0;
                                                  i < selectedValues.length;
                                                  i++)
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    GestureDetector(
                                                        onTap: () {
                                                          selectedValues.remove(
                                                              selectedValue);
                                                          options.insert(
                                                              selectedValues
                                                                  .indexOf(
                                                                      selectedValue),
                                                              selectedValue);
                                                          setState(() {
                                                            print("ปิด");
                                                          });
                                                        },
                                                        child: Icon(
                                                          Icons.close,
                                                          size: 15,
                                                        )),
                                                    Text(
                                                      selectedValues[i],
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
                                                    ),
                                                    S.H(10)
                                                    // buildHeadTable(selectedValues[i], 200.0),
                                                  ],
                                                ),
                                            ],
                                          ),
                                          Divider(
                                            color: Colors.black,
                                            thickness: 0.5,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 500,
                                            width: Get.width * 2,
                                            // color: Colors.teal,
                                            child: GetBuilder<UserController>(
                                              init: UserController(),
                                              builder: (userController) {
                                                if (userController
                                                    .dataList.isNotEmpty) {
                                                  return ListView.builder(
                                                    scrollDirection:
                                                        Axis.vertical,
                                                    // itemCount: 20,
                                                    itemCount: userController
                                                        .dataList.length,
                                                    padding: EdgeInsets.all(10),
                                                    itemBuilder:
                                                        (context, index) {
                                                      // Map<String, dynamic> userData = userController.dataList[index]['data'];
                                                      return Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              SizedBox(
                                                                  width: 200,
                                                                  child: Text(
                                                                      userController.dataList[index]['data']
                                                                              [
                                                                              'name'] ??
                                                                          '')),
                                                              SizedBox(
                                                                  width: 300,
                                                                  child: Text(userController
                                                                              .dataList[index]
                                                                          [
                                                                          'data']
                                                                      [
                                                                      'email'])),
                                                              SizedBox(
                                                                width: 200,
                                                                child: Text(
                                                                    userController
                                                                        .dataList[
                                                                            index]
                                                                            [
                                                                            'data']
                                                                            [
                                                                            'create_time']
                                                                        .toString() // หรือข้อความอื่นที่คุณต้องการแสดงเมื่อไม่มีข้อมูล
                                                                    ),
                                                              ),
                                                              SizedBox(
                                                                  width: 250,
                                                                  child: Text(userController
                                                                              .dataList[index]
                                                                          [
                                                                          'data']
                                                                      ['UID'])),
                                                              SizedBox(
                                                                width: 200,
                                                                child: Text(
                                                                    userController
                                                                        .dataList[
                                                                            index]
                                                                            [
                                                                            'data']
                                                                            [
                                                                            'last_time']
                                                                        .toString() // หรือข้อความอื่นที่คุณต้องการแสดงเมื่อไม่มีข้อมูล
                                                                    ),
                                                              )
                                                            ],
                                                          ),
                                                          Divider(
                                                            color: Colors.grey,
                                                            indent: 0,
                                                            endIndent: 0,
                                                          )
                                                        ],
                                                      );
                                                    },
                                                  );
                                                } else {
                                                  return Text(
                                                      'No data available'); // หรือใส่ข้อความที่ต้องการแสดง
                                                }
                                              },
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color:
                                                Colors.black.withOpacity(0.2)),
                                        child: Center(
                                            child: FaIcon(
                                          FontAwesomeIcons.anglesLeft,
                                          size: 15,
                                          color: Colors.white,
                                        )),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                          height: 30,
                                          width: 100,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              color: Colors.black
                                                  .withOpacity(0.2)),
                                          child: Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: Text(
                                              "หน้า ",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          )),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        height: 30,
                                        width: 30,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            color:
                                                Colors.black.withOpacity(0.2)),
                                        child: Center(
                                            child: FaIcon(
                                          FontAwesomeIcons.anglesRight,
                                          size: 15,
                                          color: Colors.white,
                                        )),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  // const SizedBox(height: kSpacing * 2),
                                  // SingleChildScrollView(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       horizontal: kSpacing / 2),
                                  //   child: Column(
                                  //     children: [
                                  //       const SizedBox(height: kSpacing),
                                  //       for (int i = 0; i < 100; i++)
                                  //         Column(
                                  //           children: [
                                  //             Row(
                                  //               children: <Widget>[
                                  //                 Container(
                                  //                   width: 50.0,
                                  //                   alignment:
                                  //                       Alignment.center,
                                  //                   child: Text(
                                  //                     '#${i + 1}',
                                  //                     style: const TextStyle(
                                  //                       fontSize: 16.0,
                                  //                       color: kFontColor,
                                  //                       fontWeight:
                                  //                           FontWeight.bold,
                                  //                       letterSpacing: 1.2,
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //                 const SizedBox(
                                  //                     width: kSpacing),
                                  //                 Expanded(
                                  //                   child: Row(
                                  //                     children: <Widget>[
                                  //                       CircleAvatar(
                                  //                         radius: 24.0,
                                  //                         child: SvgPicture
                                  //                             .string(
                                  //                           RandomAvatarString(
                                  //                               (123 + i)
                                  //                                   .toString()),
                                  //                         ),
                                  //                         // backgroundImage:SvgPicture.string(svgCode),
                                  //                       ),
                                  //                       const SizedBox(
                                  //                           width: kSpacing),
                                  //                       Text(
                                  //                         '${firstNames[1]} ${lastNames[1]}',
                                  //                         style:
                                  //                             const TextStyle(
                                  //                           fontSize: 16.0,
                                  //                           color: kFontColor,
                                  //                           letterSpacing:
                                  //                               1.4,
                                  //                         ),
                                  //                       ),
                                  //                     ],
                                  //                   ),
                                  //                 ),
                                  //                 const SizedBox(
                                  //                     width: kSpacing / 2),
                                  //                 Container(
                                  //                   width: 180.0,
                                  //                   alignment:
                                  //                       Alignment.centerRight,
                                  //                   child: const Text(
                                  //                     '234,701 BU Point ',
                                  //                     style: TextStyle(
                                  //                       fontSize: 14.0,
                                  //                       color: kFontColor,
                                  //                       fontWeight:
                                  //                           FontWeight.bold,
                                  //                       letterSpacing: 1.4,
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //             Divider(
                                  //               endIndent: kSpacing,
                                  //               indent: kSpacing,
                                  //               color: Colors.grey[200],
                                  //               thickness: 1.0,
                                  //             ),
                                  //           ],
                                  //         ),
                                  //     ],
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            const SizedBox(height: kSpacing * 2),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  buildHeadTable(String text, double width) {
    return Container(
        // color: Colors.teal,
        height: 50,
        width: width,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Text(
            text,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ));
  }

  // buildPointReport() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.center,
  //         mainAxisAlignment: MainAxisAlignment.start,
  //         children: [
  //           Center(
  //             child: Container(
  //               width: 200,
  //               height: 200,
  //               // color: Colors.indigo.withOpacity(0.3),
  //               decoration: BoxDecoration(
  //                 shape: BoxShape.circle,
  //                 color: Colors.indigo.withOpacity(0.3),
  //                 image: DecorationImage(
  //                   image: AssetImage('assets/icon/usdt.png'),
  //                   // fit: BoxFit.cover,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           S.H(10),
  //           Text('1 USD ~ 0.9990009990009991',style: TextStyle(color: Colors.white,fontSize: 18),),
  //           S.H(50),
  //           GestureDetector(
  //             onTap: (){
  //               showDialog(
  //                   context: context,
  //                   builder: (context) =>
  //                       Material(
  //                         color: Colors.transparent,
  //                         child: Center(
  //                           child: Container(
  //                             height: 500,
  //                             width: 500,
  //                            decoration: BoxDecoration(
  //                              color: Colors.white,
  //                              borderRadius: BorderRadius.circular(10),
  //                            ),child: Column(
  //                             mainAxisAlignment: MainAxisAlignment.center,
  //                             crossAxisAlignment: CrossAxisAlignment.center,
  //                             children: [
  //                               Padding(
  //                                 padding:  EdgeInsets.only(left: 50,right: 50,),
  //                                 child: Row(
  //                                   crossAxisAlignment: CrossAxisAlignment.center,
  //                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                   children: [
  //                                     Container(
  //                                       height: 100,
  //                                       width: 100,
  //                                       decoration: BoxDecoration(
  //                                         shape: BoxShape.circle,
  //                                         color: Colors.teal,
  //
  //                                       ),
  //                                     ),
  //                                     Container(
  //                                       height: 100,
  //                                       width: 100,
  //                                       decoration: BoxDecoration(
  //                                         shape: BoxShape.circle,
  //                                         color: Colors.purpleAccent.withOpacity(0.2),
  //                                       ),
  //                                     ),
  //                                   ],
  //                                 ),
  //                               ),
  //                               FaIcon(FontAwesomeIcons.arrowRightArrowLeft,),
  //                               Text("1.0000000000000",style: TextStyle(color: Colors.black,fontSize: 16),),
  //                               Text("Fee"),
  //                               Padding(
  //                                 padding: const EdgeInsets.all(10.0),
  //                                 child: TextFormField(
  //                                   decoration: InputDecoration(
  //                                     hintText: "Enter Amount",
  //                                     hintStyle: TextStyle(color: Colors.grey),
  //                                     border: OutlineInputBorder(
  //                                       borderRadius: BorderRadius.circular(10),
  //                                     ),
  //                                   ),
  //                                 ),
  //                               ),
  //                               Row(
  //                                 children: [
  //                                   Container(
  //                                     height: 50,width: 150,color: Colors.redAccent,
  //                                   ),
  //                                   Container(
  //                                     height: 50,width: 150,color: Colors.greenAccent
  //                                   ),
  //                                 ],
  //                               )
  //                             ],
  //                           ),
  //                           ),
  //                         ),
  //                       )
  //               );
  //             },
  //             child: Container(
  //               height: 50,width: 150,
  //             decoration: BoxDecoration(
  //               color: Colors.white.withOpacity(0.5),
  //               borderRadius: BorderRadius.circular(5)
  //             ),child: Center(
  //               child: Text(
  //                 'EDIT',
  //                 style: TextStyle(
  //                   color: Colors.white,
  //                   fontSize: 20,
  //                 ),
  //               ),
  //             ),),
  //           )
  //         ],
  //       ),
  //       Container(
  //         width: 300,
  //         height: 450,
  //         alignment: Alignment.topLeft,
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             rowCoin('ใส่รูปเหรียญ', '12123'),
  //             S.H(10),
  //             rowCoin('ใส่รูปเหรียญ', '33333'),
  //             S.H(10),
  //             rowCoin('ใส่รูปเหรียญ', '1092'),
  //             S.H(10),
  //             rowCoin('ใส่รูปเหรียญ', '7458'),
  //             S.H(10),
  //             rowCoin('ใส่รูปเหรียญ', '12'),
  //             S.H(10),
  //             rowCoin('ใส่รูปเหรียญ', '7934'),
  //             S.H(10),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  buildPointReport() {
    return GetBuilder<SwapSettingController>(
        init: SwapSettingController(),
        builder: (swap) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: Get.height,
                width: 230,
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      // decoration: BoxDecoration(
                      //   color: Colors.white.withOpacity(0.5),
                      //   shape: BoxShape.circle
                      // ),
                      // color: swap.showCoin["code"] == 'BTC' ? Colors.blue :swap.showCoin["code"] == 'ETH' ?Colors.cyan :swap.showCoin["code"] == 'USDT' ?Colors.deepOrange :swap.showCoin["code"] == 'BTC2' ?Colors.green :swap.showCoin["code"] == 'ETH2' ?Colors.indigo :swap.showCoin["code"] == 'USDT2' ?Colors.pink :Colors.purple,
                      child: Image.asset(
                        swap.showCoin["icon"],
                        width: 100,
                        height: 100,
                      ),
                    ),
                    S.H(20),
                    Text(
                      "1 USD ~ XXXXXXXXXXX ${swap.showCoin["code"]}",
                      style: TextStyle(color: Colors.white),
                    ),
                    S.H(20),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) =>
                                showEdit(swap.showCoin["code"]));
                      },
                      child: Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text('EDIT'),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              S.W(50),
              Container(
                width: 300,
                height: 450,
                alignment: Alignment.topLeft,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    swap.swapSetting.length,
                    (index) => InkWell(
                        onTap: () {
                          swap.changeArray(index);
                        },
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 500+ index*100),
                          padding: EdgeInsets.only(left: padding),
                            child: rowCoin(
                                swap.swapSetting[index]["code"],
                                swap.swapSetting[index]["currency"],
                                swap.swapSetting[index]["icon"]
                            ),
                        )
                        // rowCoin(swap.swapSetting[index]["code"], swap.swapSetting[index]["currency"],swap.swapSetting[index]["code"])),
                        ),
                  ),
                ),
              ),
            ],
          );
        });
  }

  /// row for each coin 'ใส่รูปเหรียญ'
  Widget rowCoin(text, textCoin, icon) {
    // print(icon);
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(icon.toString()),
              fit: BoxFit.cover,
            ),
          ),
        ),
        S.W(10),
        Container(
          // width: 40,
          height: 50,
          // alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                text.toString(),
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              Text(
                textCoin.toString(),
                style: TextStyle(fontSize: 12, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget showEdit(textCoin) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          height: 500,
          width: 500,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.purpleAccent.withOpacity(0.2),
                          ),
                        ),
                        S.H(10),
                        Text(
                          textCoin,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ],
                    ),
                    FaIcon(
                      FontAwesomeIcons.arrowRightArrowLeft,
                      color: Colors.black,
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      child: Center(
                        child: Text(
                          "1 USD",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                S.H(10),
                Text('จำนวนเหรียญ'),
                Row(
                  children: [
                    Container(
                      width: 200,
                      child: TextFormField(
                        controller: coinController,
                        decoration: InputDecoration(
                          hintText: "ใส่จำนวนเหรียญ",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            final valueCoin = Get.put(SwapSettingController());
                            valueCoin.coinInsert = int.parse(value);
                            print(valueCoin.coinInsert);
                          });
                        },
                      ),
                    ),
                    S.W(20),
                    Container(
                      child: Text(
                        '/ 1 USD',
                        style: TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    )
                  ],
                ),
                S.H(10),
                Text('Fee'),
                Container(
                  width: 200,
                  child: TextFormField(
                    controller: feeController,
                    decoration: InputDecoration(
                      hintText: "0",
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        final valueCoin = Get.put(SwapSettingController());
                        if(value == '' || value == null){
                          valueCoin.fee = 0;
                        }else{
                          valueCoin.fee = int.parse(value);
                        }
                        print(valueCoin.fee);
                      });
                    },
                  ),
                ),
                S.H(10),
                Divider(color: Colors.black,),
                S.H(25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text('Cancel'),
                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: 100,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.indigoAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text('Save'),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      );


  Widget buildSayHi() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        // Image.asset(
        //   ImageRasterPath.imageBoy,
        //   height: 160.0,
        // ),
        const SizedBox(width: kSpacing * 2),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AnimatedTextKit(
                isRepeatingAnimation: false,
                animatedTexts: <TypewriterAnimatedText>[
                  TypewriterAnimatedText(
                    sayHiFunction(name: 'Sumat'),
                    speed: const Duration(milliseconds: 100),
                    textStyle: const TextStyle(
                      fontSize: 28.0,
                      color: kFontColor,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: kSpacing),
              SizedBox(
                height: 120.0,
                child: AnimatedTextKit(
                  pause: const Duration(milliseconds: 1000),
                  totalRepeatCount: 5,
                  isRepeatingAnimation: false,
                  animatedTexts: <TypewriterAnimatedText>[
                    TypewriterAnimatedText(
                      '',
                      speed: const Duration(milliseconds: 50),
                      textStyle: const TextStyle(
                        fontSize: 16.0,
                        color: kFontColor,
                        letterSpacing: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  String sayHiFunction({required String name}) {
    late final List<String> sayHi = [
      'Hello!', // สวัสดี!
      'Hey!', // เฮ้!
      'Hi!', // สวัสดี!
      'Welcome', // ยินดีต้อนรับ
    ];

    final randomIndex = Random().nextInt(sayHi.length);
    return '${sayHi[randomIndex]} $name';
  }

  Widget buildHeadText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          dashboard.tr.toUpperCase(),
          style: TextStyle(
            fontSize: 28.0,
            color: Colors.white,
            shadows: [
              Shadow(color: Colors.black.withOpacity(.1), blurRadius: 1.0)
            ],
            fontWeight: FontWeight.w700,
            letterSpacing: .6,
          ),
        ),
        Text(
          dashboardSubText.tr,
          style: TextStyle(
            height: 1.4,
            fontSize: 18.0,
            color: Colors.white.withOpacity(.9),
            shadows: [
              Shadow(color: Colors.black.withOpacity(.1), blurRadius: 1.0)
            ],
            letterSpacing: .6,
          ),
        ),
      ],
    );
  }

  Widget buildBalanceSummary() {
    final isMobile = ResponsiveBuilder.isMobile(context);
    final isTablet = ResponsiveBuilder.isTablet(context);
    if (isMobile) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                balanceSummary.tr,
                style: const TextStyle(
                  fontSize: 22.0,
                  color: kFontColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.4,
                ),
              ),
              Text(
                DateFormat('MMM yyyy').format(DateTime.now()),
                style: const TextStyle(
                  shadows: <Shadow>[
                    Shadow(color: Colors.white, blurRadius: 1.0)
                  ],
                  fontSize: 18.0,
                  color: Color(0xFF5271FF),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.4,
                ),
              ),
            ],
          ),
          const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                totalDailyRewards.tr,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: kFontColor,
                  letterSpacing: 1.4,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    '234,701',
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(color: Colors.white, blurRadius: 1.0)
                      ],
                      fontSize: 18.0,
                      color: kFontColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                    ),
                  ),
                  SizedBox(width: kSpacing),
                  Text(
                    'BU Point',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: kFontColor,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                totalRedeemPoint.tr,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: kFontColor,
                  letterSpacing: 1.4,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    '234,701',
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(color: Colors.white, blurRadius: 1.0)
                      ],
                      fontSize: 18.0,
                      color: kFontColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                    ),
                  ),
                  SizedBox(width: kSpacing),
                  Text(
                    'BU Point',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: kFontColor,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                totalGeneratePoint.tr,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: kFontColor,
                  letterSpacing: 1.4,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    '234,701',
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(color: Colors.white, blurRadius: 1.0)
                      ],
                      fontSize: 18.0,
                      color: kFontColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                    ),
                  ),
                  SizedBox(width: kSpacing),
                  Text(
                    'BU Point',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: kFontColor,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            height: 0.0,
            thickness: .4,
            color: kFontColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                activityCampaign.tr,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: kFontColor,
                  letterSpacing: 1.4,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    '234,701',
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(color: Colors.white, blurRadius: 1.0)
                      ],
                      fontSize: 18.0,
                      color: kFontColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                    ),
                  ),
                  SizedBox(width: kSpacing),
                  Text(
                    'BU Point',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: kFontColor,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Burned point',
                style: TextStyle(
                  fontSize: 16.0,
                  color: kFontColor,
                  letterSpacing: 1.4,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    '234,701',
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(color: Colors.white, blurRadius: 1.0)
                      ],
                      fontSize: 18.0,
                      color: kFontColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                    ),
                  ),
                  SizedBox(width: kSpacing),
                  Text(
                    'BU Point',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: kFontColor,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            height: 0.0,
            thickness: .4,
            color: kFontColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 16.0,
                  color: kFontColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    '234,701',
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(color: Colors.white, blurRadius: 1.0)
                      ],
                      fontSize: 18.0,
                      color: kFontColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                    ),
                  ),
                  SizedBox(width: kSpacing),
                  Text(
                    'BU Point',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: kFontColor,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    } else if (isTablet) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Text(
                  balanceSummary.tr,
                  style: const TextStyle(
                    fontSize: 20.0,
                    color: kFontColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
              ),
              const SizedBox(width: kSpacing / 2),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    DateFormat('MMM').format(DateTime.now()),
                    style: const TextStyle(
                      shadows: <Shadow>[
                        Shadow(color: Colors.white, blurRadius: 1.0)
                      ],
                      fontSize: 18.0,
                      color: Color(0xFF5271FF),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                    ),
                  ),
                  Text(
                    DateTime.now().year.toString(),
                    style: const TextStyle(
                      shadows: <Shadow>[
                        Shadow(color: Colors.white, blurRadius: 1.0)
                      ],
                      fontSize: 16.0,
                      color: Color(0xFF5271FF),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                totalDailyRewards.tr,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: kFontColor,
                  letterSpacing: 1.4,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    '234,701',
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(color: Colors.white, blurRadius: 1.0)
                      ],
                      fontSize: 18.0,
                      color: kFontColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                    ),
                  ),
                  Text(
                    'BU Point',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: kFontColor,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                totalRedeemPoint.tr,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: kFontColor,
                  letterSpacing: 1.4,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    '234,701',
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(color: Colors.white, blurRadius: 1.0)
                      ],
                      fontSize: 18.0,
                      color: kFontColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                    ),
                  ),
                  Text(
                    'BU Point',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: kFontColor,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                totalGeneratePoint.tr,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: kFontColor,
                  letterSpacing: 1.4,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    '234,701',
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(color: Colors.white, blurRadius: 1.0)
                      ],
                      fontSize: 18.0,
                      color: kFontColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                    ),
                  ),
                  Text(
                    'BU Point',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: kFontColor,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            height: 0.0,
            thickness: .4,
            color: kFontColor,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                activityCampaign.tr,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: kFontColor,
                  letterSpacing: 1.4,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    '234,701',
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(color: Colors.white, blurRadius: 1.0)
                      ],
                      fontSize: 18.0,
                      color: kFontColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                    ),
                  ),
                  Text(
                    'BU Point',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: kFontColor,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Burned point',
                style: TextStyle(
                  fontSize: 16.0,
                  color: kFontColor,
                  letterSpacing: 1.4,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    '234,701',
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(color: Colors.white, blurRadius: 1.0)
                      ],
                      fontSize: 18.0,
                      color: kFontColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                    ),
                  ),
                  Text(
                    'BU Point',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: kFontColor,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            height: 0.0,
            thickness: .4,
            color: kFontColor,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 16.0,
                  color: kFontColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    '234,701',
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(color: Colors.white, blurRadius: 1.0)
                      ],
                      fontSize: 18.0,
                      color: kFontColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                    ),
                  ),
                  Text(
                    'BU Point',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: kFontColor,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                balanceSummary.tr,
                style: const TextStyle(
                  fontSize: 22.0,
                  color: kFontColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.4,
                ),
              ),
              Text(
                DateFormat('MMM yyyy').format(DateTime.now()),
                style: const TextStyle(
                  shadows: <Shadow>[
                    Shadow(color: Colors.white, blurRadius: 1.0)
                  ],
                  fontSize: 18.0,
                  color: Color(0xFF5271FF),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.4,
                ),
              ),
            ],
          ),
          const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                totalDailyRewards.tr,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: kFontColor,
                  letterSpacing: 1.4,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    '234,701',
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(color: Colors.white, blurRadius: 1.0)
                      ],
                      fontSize: 18.0,
                      color: kFontColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                    ),
                  ),
                  SizedBox(width: kSpacing),
                  Text(
                    'BU Point',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: kFontColor,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                totalRedeemPoint.tr,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: kFontColor,
                  letterSpacing: 1.4,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    '234,701',
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(color: Colors.white, blurRadius: 1.0)
                      ],
                      fontSize: 18.0,
                      color: kFontColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                    ),
                  ),
                  SizedBox(width: kSpacing),
                  Text(
                    'BU Point',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: kFontColor,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                totalGeneratePoint.tr,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: kFontColor,
                  letterSpacing: 1.4,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    '234,701',
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(color: Colors.white, blurRadius: 1.0)
                      ],
                      fontSize: 18.0,
                      color: kFontColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                    ),
                  ),
                  SizedBox(width: kSpacing),
                  Text(
                    'BU Point',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: kFontColor,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            height: 0.0,
            thickness: .4,
            color: kFontColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                activityCampaign.tr,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: kFontColor,
                  letterSpacing: 1.4,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    '234,701',
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(color: Colors.white, blurRadius: 1.0)
                      ],
                      fontSize: 18.0,
                      color: kFontColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                    ),
                  ),
                  SizedBox(width: kSpacing),
                  Text(
                    'BU Point',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: kFontColor,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Burned point',
                style: TextStyle(
                  fontSize: 16.0,
                  color: kFontColor,
                  letterSpacing: 1.4,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    '234,701',
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(color: Colors.white, blurRadius: 1.0)
                      ],
                      fontSize: 18.0,
                      color: kFontColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                    ),
                  ),
                  SizedBox(width: kSpacing),
                  Text(
                    'BU Point',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: kFontColor,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Divider(
            height: 0.0,
            thickness: .4,
            color: kFontColor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Text(
                'Total',
                style: TextStyle(
                  fontSize: 16.0,
                  color: kFontColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const <Widget>[
                  Text(
                    '234,701',
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(color: Colors.white, blurRadius: 1.0)
                      ],
                      fontSize: 18.0,
                      color: kFontColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.4,
                    ),
                  ),
                  SizedBox(width: kSpacing),
                  Text(
                    'BU Point',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: kFontColor,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      );
    }
  }

  Widget buildLikepointCommunity() {
    final isDesktop = ResponsiveBuilder.isDesktop(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        if (isDesktop)
          Image.asset(
            ImageRasterPath.logoTelegram,
            height: 100.0,
          ),
        Row(
          children: <Widget>[
            Text(
              joinOur.tr,
              style: TextStyle(
                fontSize: isDesktop ? 18.0 : 16.0,
                color: kFontColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.4,
              ),
            ),
            const SizedBox()
          ],
        ),
        Text(
          'Merchant community Telegram',
          maxLines: 1,
          style: TextStyle(
            fontSize: isDesktop ? 24.0 : 20.0,
            color: kFontColor,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.4,
          ),
        ),
        const SizedBox(height: kSpacing / 2),
        InkWell(
          onTap: () {},
          child: Container(
            width: 320.0,
            height: 30.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: kSpacing / 2),
            decoration: BoxDecoration(
              color: kFontColor,
              borderRadius: BorderRadius.circular(kBorderRadius),
            ),
            child: const Text(
              'https://t.me/LikepointMerchantCommunity',
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
