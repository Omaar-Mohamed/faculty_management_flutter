class ChannelModel {
  String? status;
  String? message;
  Data? data;

  ChannelModel({this.status, this.message, this.data});

  ChannelModel.fromJson(Map<String, dynamic> json) {
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
  List<String>? courses;
  String? general;
  String? department;
  String? user;

  Data({this.courses, this.general, this.department, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    courses = json['courses'].cast<String>();
    general = json['general'];
    department = json['department'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courses'] = this.courses;
    data['general'] = this.general;
    data['department'] = this.department;
    data['user'] = this.user;
    return data;
  }
}