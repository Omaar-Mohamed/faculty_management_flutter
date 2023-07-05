class ReportChatModel {
  String? status;
  String? message;
  Data? data;

  ReportChatModel({this.status, this.message, this.data});

  ReportChatModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}
class Data{
  String? token;
  User? user;

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}

class User{
  int? id;
  String? message;

  String? fname;
  String? sname;
  String? tname;
  String? lname;
  String? email;
  String? username;
  String? phone;
  String? gender;
  String? avatar;
  String? image;
  String? national_id;
  String? address;
  String? role;
  String? lang_code;

  User.fromJson(Map<String, dynamic> json) {
    message=json['message'];
    id = json['id'];
    fname = json['fname'];
    sname = json['sname'];
    tname = json['tname'];
    lname = json['lname'];
    email = json['email'];
    username = json['username'];
    phone = json['phone'];
    gender = json['gender'];
    avatar = json['avatar'];
    image = json['image'];
    national_id = json['national_id'];
    address = json['address'];
    role = json['role'];
    lang_code = json['lang_code'];
  }
}
