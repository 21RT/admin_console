import 'package:get/get.dart';
import 'package:moneymaker/model/theme/app_constants.dart';

class SwapSettingController extends GetxController {
  var swapSetting = [].obs;
  var showCoin = {}.obs;
  bool breakLoading = true;

  int coinInsert = 0;
  int fee = 0;

  @override
  void onInit() {
    prepareInfo();
    super.onInit();
  }

  void prepareInfo(){
    /// run only one time
    if(breakLoading){

      // mockup data
      var swapSettingList = [
        {
          "code": "BTC",
          "currency": 0,
          "decimalPoint": 6,
          'icon': IconPath.iconBCT,
        },
        {
          "code": "ETH",
          "currency": 60,
          "decimalPoint": 6,
          'icon': IconPath.iconETH,
        },
        {
          "code": "USDT",
          "currency": 60,
          "decimalPoint": 6,
          'icon': IconPath.iconUSDT,
        },
        {
          "code": "USDC",
          "currency": 0,
          "decimalPoint": 6,
          'icon': IconPath.iconUSDC,
        },
        {
          "code": "EUROC",
          "currency": 60,
          "decimalPoint": 6,
          'icon': IconPath.iconEuro,
        },
        {
          "code": "PAXG",
          "currency": 60,
          "decimalPoint": 6,
          'icon': IconPath.iconPaxGold,
        },
        {
          "code": "BUSD",
          "currency": 60,
          "decimalPoint": 6,
          'icon': IconPath.iconBUSD,
        }
      ];

      showCoin.value = swapSettingList[0];

      for(int i = 1; i < swapSettingList.length; i++)
        swapSetting.add(swapSettingList[i]);

      breakLoading = false;
      print(swapSetting);
    }
    update();
  }

  void changeArray(int index){
    swapSetting.insert(swapSetting.length, showCoin.value);
    showCoin.value = swapSetting[index];
    swapSetting.removeAt(index);

    update();
  }
}