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
  RxList<Map<String, dynamic>> rawData = <Map<String, dynamic>>[].obs;

  Future<void> getDataUser(email) async {
    try {

      Map dataReq = {
        'email':"jitrawadee.wanichphon.pkg@gmail.com"
      };
      print(dataReq);
      // var response = await HttpService.post('http://172.16.0.160:8000/getdata', dataReq);
      var response = [
        {
          "name": "Jitrawadee",
          "email": "jitrawadee.wanichphon.pkg@gmail.com",
          "create_time": "2021-08-02T09:00:00.000Z",
          "uid":'huyfitifoirlyuyroohjfi',
          "last_time":'2021-08-02T09:10:00.000Z'
        },
        {
          "name": "Pang",
          "email": "pang@gmail.com",
          "create_time": "2021-08-02T09:00:00.000Z",
          "uid":'eiptuwpegtrjrjrtshrtjtrj',
          "last_time":'2021-08-02T09:10:00.000Z'
        },
        {
          "name": "App",
          "email": "app07@gmail.com",
          "create_time": "2021-08-02T09:00:00.000Z",
          "uid":'sre;otire[phtrjytjeythtrhtj',
          "last_time":'2021-08-02T09:10:00.000Z'
        },
        {
          "name": "Test",
          "email": "test@gmail.com",
          "create_time": "2021-08-02T09:00:00.000Z",
          "uid":'ipsguprgrhrthtrjykdnh',
          "last_time":'2021-08-02T09:10:00.000Z'
        },
        {
          "name": "TTTTTTT",
          "email": "T1@gmail.com",
          "create_time": "2021-08-02T09:00:00.000Z",
          "uid":'osiprghpsgjsgbshtrshh',
          "last_time":'2021-08-02T09:10:00.000Z'
        },
        {
          "name": "PPPPPYYYYY",
          "email": "PY@gmail.com",
          "create_time": "2021-08-02T09:00:00.000Z",
          "uid":'jflasforhgsergoshgnprb',
          "last_time":'2021-08-02T09:10:00.000Z'
        },
      ];
      print({response});

      if (response != null && response is List) {
        // แปลงประเภทข้อมูลเป็น List<Map<String, dynamic>>
        List<Map<String, dynamic>> dataAsList = List<Map<String, dynamic>>.from(response);
        // กำหนดค่าให้กับ dataList
        dataList.assignAll(dataAsList);
        rawData.assignAll(dataAsList);
        print(dataList.length);
        print('dataList: $dataList');
        // print('dataList[0]: ${dataList[0]['data']['name']}');
      } else {
        print('Response is null or not a List.');
      }
    } catch (e) {
      print(e);
    }
  }

  void searchUser(String value, bool reverse) {
    List<Map<String, dynamic>> filteredData;
    // กรองข้อมูลใน dataList โดยใช้คำสั่ง where
    // โดยจะเปรียบเทียบค่าใน key 'name' กับค่า value ที่รับเข้ามา
    // ถ้ามีค่าใดมีค่าตรงกันก็จะถูกเก็บไว้ในตัวแปร filteredData

    if (reverse) {
      // find as array output with false
      print("reverse");
      filteredData = rawData
          .where((data) => !data['data']['name']
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
      print(filteredData);

      if (filteredData.length == rawData.length) {
        filteredData = rawData
            .where((data) => !data['data']['email'].toString().contains(value))
            .toList();
      }
      if (filteredData.length == rawData.length) {
        filteredData = rawData
            .where((data) => !data['data']['phone'].toString().contains(value))
            .toList();
      }
      if (filteredData.length == rawData.length) {
        filteredData = rawData
            .where((data) => !data['data']['UID'].toString().contains(value))
            .toList();
      }
      if (value.length == 0) {
        filteredData = rawData;
      }
    } else {
      // find as array output
      filteredData = rawData
          .where((data) => data['data']['name']
              .toString()
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
      if (filteredData.length == 0) {
        filteredData = rawData
            .where((data) => data['data']['email'].toString().contains(value))
            .toList();
      }
      if (filteredData.length == 0) {
        filteredData = rawData
            .where((data) => data['data']['phone'].toString().contains(value))
            .toList();
      }
      if (filteredData.length == 0) {
        filteredData = rawData
            .where((data) => data['data']['UID'].toString().contains(value))
            .toList();
      }
    }

    print(filteredData);
    // กำหนดค่าให้กับ dataList
    dataList.assignAll(filteredData);
    update();
  }
}
