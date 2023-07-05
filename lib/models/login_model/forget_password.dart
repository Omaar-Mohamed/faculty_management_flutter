class ForgetPasswordModel{
  String? status;
  String? message;
  String? data;
  ForgetPasswordModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];

  }
}