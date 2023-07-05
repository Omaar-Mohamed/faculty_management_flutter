class TicketMessageModel {
  final String status;
  final String? message;
  final List<TicketMessageData>? data;

  TicketMessageModel({
    required this.status,
    this.message,
    this.data,
  });

  factory TicketMessageModel.fromJson(Map<String, dynamic> json) {
    return TicketMessageModel(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => TicketMessageData.fromJson(item))
          .toList(),
    );
  }
}

class TicketMessageData {
  final int id;
  final String title;
  final String description;
  final String category;
  final String status;
  final String createdAt;
  final String updatedAt;
  final dynamic assignedTo;

  TicketMessageData({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.assignedTo,
  });

  factory TicketMessageData.fromJson(Map<String, dynamic> json) {
    return TicketMessageData(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      assignedTo: json['assigned_to'],
    );
  }
}
