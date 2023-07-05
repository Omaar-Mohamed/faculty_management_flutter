class CodeModel{
  String? status;
  String? message;
  String? data;
  CodeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];

  }
}