class NewPasswordModel{
  String? status;
  String? message;
  String? data;
  NewPasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];

  }
}