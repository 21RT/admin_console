import 'package:get/get.dart';
import 'package:moneymaker/view/DashboardScreen.dart';
import 'package:moneymaker/view/SignInScreen.dart';
import 'app_routes.dart';

class AppPages {
  static const initial = Routes.signIn;

  static final routes = [
    GetPage(
      name: Paths.signIn,
      transition: Transition.topLevel,
      page: () => const SignInScreen(),
    ),
    GetPage(
      name: Paths.content,
      transition: Transition.noTransition,
      page: () => const DashboardScreen(),
    ),
    // GetPage(
    //   name: Paths.activity,
    //   transition: Transition.noTransition,
    //   binding: ActivityBinding(),
    //   page: () => const ActivityScreen(),
    // ),
    // GetPage(
    //   name: Paths.pocket,
    //   transition: Transition.noTransition,
    //   binding: PocketBinding(),
    //   page: () => const PocketScreen(),
    // ),
    // // GetPage(
    // //   name: Paths.pocketInfo,
    // //   transition: Transition.noTransition,
    // //   binding: InfoPocketBinding(),
    // //   page: () => const InfoPocketScreen(),
    // // ),
    // GetPage(
    //   name: Paths.pricing,
    //   transition: Transition.noTransition,
    //   page: () => const PricingScreen(),
    // ),
    // // GetPage(
    // //   name: Paths.myShop,
    // //   transition: Transition.noTransition,
    // //   page: () => const MyShopScreen(),
    // // ),
    //
    // // GetPage(
    // //   name: Paths.infoPocket,
    // //   transition: Transition.noTransition,
    // //   binding: InfoPocketBinding(),
    // //   page: () => const InfoPocketScreen(),
    // // ),
    //
    // GetPage(
    //   name: Paths.verify,
    //   transition: Transition.topLevel,
    //   page: () => const VerifyScreen(),
    // ),
    // GetPage(
    //   name: Paths.reset,
    //   transition: Transition.topLevel,
    //   page: () => const ResetPasswordScreen(),
    // ),
    // GetPage(
    //   name: Paths.create,
    //   transition: Transition.topLevel,
    //   page: () => const CreateNewPasswordScreen(),
    // ),
    // GetPage(
    //   name: Paths.campaign,
    //   transition: Transition.topLevel,
    //   binding: CampaignBinding(),
    //   page: () => const CreateCampaign(),
    // ),
    // GetPage(
    //   name: Paths.redeem,
    //   transition: Transition.topLevel,
    //   binding: CampaignBinding(),
    //   page: () => const CreateRedeem(),
    // ),
    // GetPage(
    //   name: Paths.settings,
    //   transition: Transition.noTransition,
    //   // page: () => const SettingScreen(),
    // ),
  ];
}
