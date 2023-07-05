class PostOnlineMeetingModel{
  String? status;
  String? message;
  String? data;
  PostOnlineMeetingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];

  }
}