class LogoutModel{
  String? status;
  String? message;
  dynamic data;

  // LogoutModel({this.message, this.status});

  LogoutModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'];
  }
}