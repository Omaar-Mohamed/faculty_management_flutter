class ResetModel{
  String? status;
  String? message;
  String? data;
  ResetModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];

  }
}