import 'package:get/get.dart';
import 'package:moneymaker/controller/service/httpService.dart';

class UserController extends GetxController {

  @override
  void onInit() {
    super.onInit();
    // getDataUser();
  }
// ภายใน YourController
  RxList<Map<String, dynamic>> dataList = <Map<String, dynamic>>[].obs;

  Future<void> getDataUser(String email) async {
    try {
      Map dataReq = {
        'email':email
      };
      print(dataReq);
      var response = await HttpService.post('http://172.16.0.172:8080/getdata', dataReq);
      print({response});
      if (response != null && response is List) {
        // แปลงประเภทข้อมูลเป็น List<Map<String, dynamic>>
        List<Map<String, dynamic>> dataAsList = List<Map<String, dynamic>>.from(response);
        // กำหนดค่าให้กับ dataList
        dataList.assignAll(dataAsList);
        print(dataList.length);
        // print('dataList: $dataList');
        // print('dataList[0]: ${dataList[0]['data']['name']}');
      } else {
        print('Response is null or not a List.');
      }
    } catch (e) {
      print(e);
    }
  }
}
