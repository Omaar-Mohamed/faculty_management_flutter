class CreateTicketModel {
  String? status;
  String? message;
  String? data;
  CreateTicketModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'];

  }
}
