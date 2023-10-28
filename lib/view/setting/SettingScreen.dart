import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:moneymaker/controller/getController/components/appbarControl.dart';
import 'package:moneymaker/controller/getController/localControl/localControl.dart';
import 'package:moneymaker/controller/getController/settingControl/settingController.dart';
import 'package:moneymaker/controller/translation/translation_key.dart';
import 'package:moneymaker/model/theme/app_constants.dart';
import 'package:moneymaker/view/components/admin_drawer.dart';
import 'package:moneymaker/view/components/appbar.dart';
import 'package:moneymaker/view/components/responsive_builder.dart';
import 'package:moneymaker/view/setting/SwapFeeSetting.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scrollController = ScrollController();
  final _settingSelect = TextEditingController();

  int _menuIndex = 0;
  
  final _languageList = [
    {'language': 'ภาษาไทย', 'locale': const Locale('th', 'TH')},
    {'language': 'English', 'locale': const Locale('en', 'US')},
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _settingSelect.text = pointManagement.tr;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      endDrawer: AdminDrawer(),
      body: Stack(
        children: <Widget>[
          buildContent(),
          AppBarAdmin(scaffoldKey: _scaffoldKey),
        ],
      ),
    );
  }

  Widget buildContent() {
    return GetBuilder<AppBarController>(
        init: AppBarController(),
        builder: (appBarController)  =>ResponsiveBuilder(
          mobileBuilder: (BuildContext context, BoxConstraints constraints) {
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification) {
                  appBarController.setScrollController(_scrollController.offset);
                }
                return true;
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Container(
                  width: Get.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageRasterPath.imageBg2),
                      repeat: ImageRepeat.repeat,
                      colorFilter: ColorFilter.mode(
                        Colors.white, // Overlay color
                        BlendMode.modulate, // Adjust blend mode as needed
                      ),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Color(0xFF5271FF),
                        Color(0xFFA2A2FF),
                      ],
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: 1440.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: kSpacing / 2),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: kSpacing * 6),
                            buildHeadText(),
                            const SizedBox(height: kSpacing / 2),
                            IndexedStack(
                              index: _menuIndex,
                              children: [
                                // const PointSettings(),
                                Column(),
                                Column(),
                                buildChangeLanguage(),
                                Column(),
                              ],
                            ),
                            const SizedBox(height: kSpacing),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          tabletBuilder: (BuildContext context, BoxConstraints constraints) {
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification) {
                  appBarController.setScrollController(_scrollController.offset);
                }
                return true;
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Container(
                  width: Get.width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageRasterPath.imageBg2),
                      repeat: ImageRepeat.repeat,
                      colorFilter: ColorFilter.mode(
                        Colors.white, // Overlay color
                        BlendMode.modulate, // Adjust blend mode as needed
                      ),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Color(0xFF5271FF),
                        Color(0xFFA2A2FF),
                      ],
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                      width: 1440.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: kSpacing,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const SizedBox(height: kSpacing * 6),
                            buildHeadText(),
                            const SizedBox(height: kSpacing / 2),
                            IndexedStack(
                              index: _menuIndex,
                              children: [
                                // const PointSettings(),
                                Column(),
                                Column(),
                                buildChangeLanguage(),
                                Column(),
                              ],
                            ),
                            const SizedBox(height: kSpacing),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          desktopBuilder: (BuildContext context, BoxConstraints constraints) {
            return NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollUpdateNotification) {
                  appBarController.setScrollController(_scrollController.offset);
                }
                return true;
              },
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Container(
                  width: Get.width,
                  // height: Get.height,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(ImageRasterPath.imageBg2),
                      repeat: ImageRepeat.repeat,
                      colorFilter: ColorFilter.mode(
                        Colors.white, // Overlay color
                        BlendMode.modulate, // Adjust blend mode as needed
                      ),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Color(0xFF5271FF),
                        Color(0xFFA2A2FF),
                      ],
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      width: 1440.0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: kSpacing * 2,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const SizedBox(height: kSpacing * 5),
                          buildHeadText(),
                          const SizedBox(height: kSpacing / 2),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Flexible(
                                flex: 2,
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: kSpacing * 2,
                                    horizontal: kSpacing * 1.5,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(kBorderRadius),
                                    border: Border.all(width: .4, color: Colors.grey.shade300),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        'การตั้งค่า',
                                        style: const TextStyle(
                                          fontSize: 20.0,
                                          color: kFontColor,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.2,
                                        ),
                                      ),
                                      const SizedBox(height: kSpacing),
                                      buildListMenu(),
                                      Text(_menuIndex.toString()),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: kSpacing / 2),
                              Flexible(
                                flex: 5,
                                child: IndexedStack(
                                  index: _menuIndex,
                                  children: [
                                      SwapFeeSetting(),
                                      Container(),
                                    // const PointSettings(),
                                    Column(),
                                    // const LottoSetting(),
                                    buildChangeLanguage(),
                                    // Column(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: kSpacing),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        )
        );
  }

  Widget buildChangeLanguage() {
    final isMobile = ResponsiveBuilder.isMobile(context);
    return GetBuilder<LocaleController>(
      init: LocaleController(),
      builder: (localeController) {
        return Container(
          width: Get.width,
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? kSpacing : kSpacing * 2,
            vertical: kSpacing * 2,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(width: .4, color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(kBorderRadius),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                language.tr,
                style: const TextStyle(
                  fontSize: 24.0,
                  color: kFontColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: kSpacing),
              Text(
                selectLanguage.tr,
                style: const TextStyle(
                  fontSize: 18.0,
                  color: kFontColor,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: kSpacing),
              Wrap(
                spacing: kSpacing,
                runSpacing: kSpacing,
                children: _languageList.map((languageData) {
                  final String language = languageData['language'].toString();
                  final Locale locale = languageData['locale'] as Locale;
                  final Locale currentLocale = Get.locale!;
                  final bool isSelected = currentLocale == locale;

                  return InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: () {
                      localeController.changeLanguage(
                        newLocale: locale,
                        language: language,
                      );

                      _settingSelect.text = changeLanguage.tr;
                    },
                    child: Container(
                      width: 180.0,
                      height: 60.0,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: kSpacing),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.white : Colors.grey.shade200,
                        border: Border.all(
                          color: isSelected ? const Color(0xFF5271FF) : Colors.transparent,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(kBorderRadius / 2),
                      ),
                      child: Text(
                        language,
                        style: TextStyle(
                          fontSize: 18.0,
                          color: isSelected ? const Color(0xFF5271FF) : kFontColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.4,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              )
            ],
          ),
        );
      },
    );
  }

  Widget buildHeadText() {
    final isMobile = ResponsiveBuilder.isMobile(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          settings.tr.toUpperCase(),
          style: const TextStyle(
            fontSize: 28.0,
            color: kFontColor,
            fontWeight: FontWeight.w700,
            letterSpacing: .6,
          ),
        ),
        // Text(
        //   settingsSubtext.tr,
        //   style: const TextStyle(
        //     height: 1.4,
        //     fontSize: 18.0,
        //     color: kFontColor,
        //     letterSpacing: .6,
        //   ),
        // ),
        SizedBox(height: isMobile ? kSpacing / 2 : kSpacing),
        if (!ResponsiveBuilder.isDesktop(context))
          Column(
            children: <Widget>[
              const SizedBox(height: kSpacing),
              if (ResponsiveBuilder.isMobile(context))
                buildDropdown()
              else
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      flex: 1,
                      child: Row(
                        children: <Widget>[
                          Text(
                            selectMenu.tr,
                            style: const TextStyle(
                              fontSize: 20.0,
                              color: kFontColor,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: kSpacing),
                    Flexible(
                      flex: 2,
                      child: buildDropdown(),
                    ),
                  ],
                ),
              const SizedBox(height: kSpacing / 2),
            ],
          ),
      ],
    );
  }

  Widget buildDropdown() {
    return CustomDropdown.search(
      fillColor: Colors.white,
      excludeSelected: false,
      borderRadius: BorderRadius.circular(kBorderRadius),
      hintText: selectMenu.tr,
      onChanged: (value) {
        setState(() {
          if (value == pointManagement.tr) {
            _menuIndex = 0;
          } else if (value == accountManagement.tr) {
            _menuIndex = 1;
          } else if (value == lottoManagement.tr) {
            _menuIndex = 2;
          } else if (value == changeLanguage.tr) {
            _menuIndex = 3;
          } else if (value == plansBilling.tr) {
            _menuIndex = 4;
          }
        });
      },
      hintStyle: const TextStyle(
        fontSize: 20.0,
        color: Colors.grey,
        letterSpacing: 1.4,
      ),
      selectedStyle: const TextStyle(
        fontSize: 20.0,
        color: Color(0xFF5271FF),
        fontWeight: FontWeight.bold,
        letterSpacing: 1.4,
      ),
      listItemStyle: const TextStyle(
        fontSize: 20.0,
        color: kFontColor,
        letterSpacing: 1.4,
      ),
      items: <String>[
        pointManagement.tr,
        accountManagement.tr,
        lottoManagement.tr,
        changeLanguage.tr,
        plansBilling.tr,
      ],
      controller: _settingSelect,
    );
  }

  Widget buildListMenu() {
    return GetBuilder<SettingsController>(
      init: SettingsController(),
      builder: (settingsController) {
        final index = settingsController.indexSettings.value;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: () => settingsController.setIndexSettings(index: 0),
              child: Row(
                children: <Widget>[
                  Icon(
                    index == 0 ? EvaIcons.star : EvaIcons.starOutline,
                    size: 28.0,
                    color: index == 0 ? const Color(0xFF5271FF) : kFontColor,
                  ),
                  const SizedBox(width: kSpacing),
                  Text(
                    'Swap fee settings',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: index == 0 ? const Color(0xFF5271FF) : kFontColor,
                      fontWeight: index == 0 ? FontWeight.bold : FontWeight.normal,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: kSpacing),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: ()=>settingsController.setIndexSettings(index: 1),
              child: Row(
                children: <Widget>[
                  Icon(
                    index == 1 ? EvaIcons.people : EvaIcons.peopleOutline,
                    size: 28.0,
                    color: index == 1 ? const Color(0xFF5271FF) : kFontColor,
                  ),
                  const SizedBox(width: kSpacing),
                  Text(
                    accountManagement.tr,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: index == 1 ? const Color(0xFF5271FF) : kFontColor,
                      fontWeight: index == 1 ? FontWeight.bold : FontWeight.normal,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: kSpacing),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: ()=>settingsController.setIndexSettings(index: 2),
              child: Row(
                children: <Widget>[
                  Icon(
                    EvaIcons.globe,
                    size: 28.0,
                    color: index == 2 ? const Color(0xFF5271FF) : kFontColor,
                  ),
                  const SizedBox(width: kSpacing),
                  Text(
                    changeLanguage.tr,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: index == 2 ? const Color(0xFF5271FF) : kFontColor,
                      fontWeight: index == 2 ? FontWeight.bold : FontWeight.normal,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: kSpacing),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: ()=>settingsController.setIndexSettings(index: 3),
              child: Row(
                children: <Widget>[
                  Icon(
                    index == 3 ? EvaIcons.award : EvaIcons.awardOutline,
                    size: 28.0,
                    color: index == 3 ? const Color(0xFF5271FF) : kFontColor,
                  ),
                  const SizedBox(width: kSpacing),
                  Text(
                    lottoManagement.tr,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: index == 3 ? const Color(0xFF5271FF) : kFontColor,
                      fontWeight: index == 3 ? FontWeight.bold : FontWeight.normal,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: kSpacing),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: ()=>settingsController.setIndexSettings(index: 4),
              child: Row(
                children: <Widget>[
                  Icon(
                    index == 4 ? EvaIcons.fileText : EvaIcons.fileTextOutline,
                    size: 28.0,
                    color: index == 4 ? const Color(0xFF5271FF) : kFontColor,
                  ),
                  const SizedBox(width: kSpacing),
                  Text(
                    plansBilling.tr,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: index == 4 ? const Color(0xFF5271FF) : kFontColor,
                      fontWeight: index == 4 ? FontWeight.bold : FontWeight.normal,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: kSpacing),
            InkWell(
              splashColor: Colors.transparent,
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onTap: ()=>settingsController.setIndexSettings(index: 5),
              child: Row(
                children: <Widget>[
                  Icon(
                    index == 5 ? EvaIcons.cornerDownRight : EvaIcons.cornerDownRightOutline,
                    size: 28.0,
                    color: index == 5 ? const Color(0xFF5271FF) : kFontColor,
                  ),
                  const SizedBox(width: kSpacing),
                  Text(
                    signOut.tr,
                    style: TextStyle(
                      fontSize: 18.0,
                      color: index == 5 ? const Color(0xFF5271FF) : kFontColor,
                      fontWeight: index == 5 ? FontWeight.bold : FontWeight.normal,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
