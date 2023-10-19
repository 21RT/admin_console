part of app_constants;

class ApiClient {
  final http.Client _client = http.Client();

  final String _url =
      "https://likeapi-dev-2cvcjlddla-el.a.run.app/user-merchant/login";

  Future<void> login(email, password) async {
    try {
      final Uri uri = Uri.parse(_url);
      final Map<String, String> headers = {"Content-Type": "application/json"};
      final Map<String, String> data = {"email": email, "password": password};

      // final http.Response response = await _client.post(uri,headers: )



    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
