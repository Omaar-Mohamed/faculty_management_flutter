class PostMeetingModel{
  String? status;
  String? message;
  String? data;
  PostMeetingModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];

  }
}