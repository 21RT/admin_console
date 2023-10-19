
class RegisterModel {
  String? username;
  String? uid;
  String? email;
  String? create_time;
  String? last_time;


  RegisterModel({
    required this.username,
    required this.uid,
    required this.email,
    required this.create_time,
    required this.last_time,
  });



  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
    username: json["username"],
    uid: json["uid"],
    email: json["email"],
    create_time: json["create_time"],
    last_time: json["last_time"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "uid": uid,
    "email": email,
    "create_time": create_time,
    "last_time": last_time,
  };
}







