class NotificationModel {
  String? status;
  String? message;
  List<Data>? data;
  Pagination? pagination;

  NotificationModel({this.status, this.message, this.data, this.pagination});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];

    // Filter and add valid data objects to the list
    data = (json['data'] as List)
        .where((item) => item is Map<String, dynamic>)
        .map((item) => Data.fromJson(item))
        .toList();

    pagination = json['pagination'] != null
        ? Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? title;
  String? event;
  String? description;
  int? publisherId;
  String? publisherName;
  String? createdAt;
  bool? read;
  String? type;
  int? courseId;

  Data({
    this.id,
    this.title,
    this.event,
    this.description,
    this.publisherId,
    this.publisherName,
    this.createdAt,
    this.read,
    this.type,
    this.courseId,
  });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    event = json['event'];
    description = json['description'];
    publisherId = json['publisher_id'];
    publisherName = json['publisher_name'];
    createdAt = json['created_at'];
    read = json['read'];
    type = json['type'];
    courseId = json['course_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['event'] = this.event;
    data['description'] = this.description;
    data['publisher_id'] = this.publisherId;
    data['publisher_name'] = this.publisherName;
    data['created_at'] = this.createdAt;
    data['read'] = this.read;
    data['type'] = this.type;
    data['course_id'] = this.courseId;
    return data;
  }
}

class Pagination {
  int? total;
  int? perPage;
  int? currentPage;
  String? nextPageUrl;
  String? lastPageUrl;
  int? from;
  int? to;

  Pagination({
    this.total,
    this.perPage,
    this.currentPage,
    this.nextPageUrl,
    this.lastPageUrl,
    this.from,
    this.to,
  });

  Pagination.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    perPage = json['per_page'];
    currentPage = json['current_page'];
    nextPageUrl = json['next_page_url'];
    lastPageUrl = json['last_page_url'];
    from = json['from'];
    to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    data['per_page'] = this.perPage;
    data['current_page'] = this.currentPage;
    data['next_page_url'] = this.nextPageUrl;
    data['last_page_url'] = this.lastPageUrl;
    data['from'] = this.from;
    data['to'] = this.to;
    return data;
  }
}






