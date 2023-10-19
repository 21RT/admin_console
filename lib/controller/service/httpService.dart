import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class HttpService {
  static get(String url) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.getUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    return json.decode(reply);
  }

  static Future<dynamic> post(String url, data) async {
    if (kIsWeb) {
      try {
        var urlApi = Uri.parse(url);
        final body = jsonEncode(data);
        // var envKeyTokenUrl = dotenv.env['API_KEY_BASE_URL'].toString();
        Map<String, String> requestHeaders = {
          'content-type': 'application/json',
          'Accept': 'application/json',
          // 'x-api-key': envKeyTokenUrl,
          // 'Authorization': ''
        };
        var response =
            await http.post(urlApi, body: body, headers: requestHeaders);

        var res = json.decode(response.body);
        return res;
      } catch (e) {
// // print('Error!!');
        debugPrint(e.toString());
      }
    } else {
      try {
// // print("url: " + url);

        HttpClient _client = HttpClient(context: await globalContext);

        _client.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
// final _ioClient = IOClient(_client);
        var urlApi = Uri.parse(url);
        final body = jsonEncode(data);
        // var envKeyBaseUrl = dotenv.env['API_KEY_BASE_URL'];

        Map<String, String> requestHeaders = {
          'content-type': 'application/json',
          'Accept': 'application/json',
          // 'x-api-key': envKeyBaseUrl!
        };

        var response = await http.post(urlApi, body: body, headers: requestHeaders);

// var response = await _ioClient
//     .post(urlApi, body: body, headers: requestHeaders)
//     .timeout(const Duration(seconds: 20));

// // print(response.body);
        var res = json.decode(response.body);
// // print('response from apiPostBaseUrl -> ${response}');
// // print('res from apiPostBaseUrl -> ${res}');
        return res;
      } catch (e) {
        Fluttertoast.showToast(
            msg: "TypeError:Request failed. Please Try Again Later.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 14.0);
// // print('Request failed : ${e.toString()}');
      }
    }
  }

  static Future<SecurityContext> get globalContext async {
    // Note: Not allowed to load the same certificate
    final sslCert1 = await rootBundle.load('assets/cert/certificate.pem');
    // final sslCert2 = await rootBundle.load('assets/cert/certificate2.pem');

    SecurityContext sc = new SecurityContext(withTrustedRoots: false);
    sc.setTrustedCertificatesBytes(sslCert1.buffer.asInt8List());
    // sc.setTrustedCertificatesBytes(sslCert2.buffer.asInt8List());
    return sc;
  }
}
