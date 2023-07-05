class ChangeProfileModel {
  String? status;
  String? message;
  Data? data;

  ChangeProfileModel({this.status, this.message, this.data});

  ChangeProfileModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? fname;
  String? sname;
  String? tname;
  String? lname;
  String? email;
  String? username;
  String? phone;
  String? gender;
  String? avatar;
  String? nationalId;
  String? address;
  String? langCode;
  String? role;

  User(
      {this.id,
        this.fname,
        this.sname,
        this.tname,
        this.lname,
        this.email,
        this.username,
        this.phone,
        this.gender,
        this.avatar,
        this.nationalId,
        this.address,
        this.langCode,
        this.role});

  User.fromJson(Map<String, dynamic> json) {
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
    nationalId = json['national_id'];
    address = json['address'];
    langCode = json['lang_code'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fname'] = this.fname;
    data['sname'] = this.sname;
    data['tname'] = this.tname;
    data['lname'] = this.lname;
    data['email'] = this.email;
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['avatar'] = this.avatar;
    data['national_id'] = this.nationalId;
    data['address'] = this.address;
    data['lang_code'] = this.langCode;
    data['role'] = this.role;
    return data;
  }
}
