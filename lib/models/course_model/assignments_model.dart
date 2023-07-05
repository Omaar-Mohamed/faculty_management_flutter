class AssignmentsModel {
  String? status;
  String? message;
  List<Data>? data;
  Pagination? pagination;

  AssignmentsModel({this.status, this.message, this.data, this.pagination});

  AssignmentsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
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
  int? id;
  String? name;
  String? description;
  int? points;
  String? createdAt;
  String? status;
  String? dueDate;
  String? publisher;
  bool? turnedIn;
  int? returnedPoints;
  List<Attachments>? attachments;
  List<CourseSemester>? courseSemester;

  Data(
      {this.id,
        this.name,
        this.description,
        this.points,
        this.createdAt,
        this.status,
        this.dueDate,
        this.publisher,
        this.turnedIn,
        this.returnedPoints,
        this.attachments,
        this.courseSemester});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    points = json['points'];
    createdAt = json['created_at'];
    status = json['status'];
    dueDate = json['due_date'];
    publisher = json['publisher'];
    turnedIn = json['turned_in'];
    returnedPoints = json['returned_points'];
    if (json['attachments'] != null) {
      attachments = <Attachments>[];
      json['attachments'].forEach((v) {
        attachments!.add(new Attachments.fromJson(v));
      });
    }
    if (json['course_semester'] != null) {
      courseSemester = <CourseSemester>[];
      json['course_semester'].forEach((v) {
        courseSemester!.add(new CourseSemester.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['points'] = this.points;
    data['created_at'] = this.createdAt;
    data['status'] = this.status;
    data['due_date'] = this.dueDate;
    data['publisher'] = this.publisher;
    data['turned_in'] = this.turnedIn;
    data['returned_points'] = this.returnedPoints;
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.map((v) => v.toJson()).toList();
    }
    if (this.courseSemester != null) {
      data['course_semester'] =
          this.courseSemester!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attachments {
  int? id;
  String? name;
  String? type;
  String? url;

  Attachments({this.id, this.name, this.type, this.url});

  Attachments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    type = json['type'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['type'] = this.type;
    data['url'] = this.url;
    return data;
  }
}

class CourseSemester {
  int? id;
  int? limit;
  String? markType;
  String? department;
  List<Course>? course;

  CourseSemester(
      {this.id, this.limit, this.markType, this.department, this.course});

  CourseSemester.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    limit = json['limit'];
    markType = json['mark_type'];
    department = json['department'];
    if (json['course'] != null) {
      course = <Course>[];
      json['course'].forEach((v) {
        course!.add(new Course.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['limit'] = this.limit;
    data['mark_type'] = this.markType;
    data['department'] = this.department;
    if (this.course != null) {
      data['course'] = this.course!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Course {
  int? id;
  String? name;
  String? courseCode;
  String? cat;

  Course({this.id, this.name, this.courseCode, this.cat});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    courseCode = json['course_code'];
    cat = json['cat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['course_code'] = this.courseCode;
    data['cat'] = this.cat;
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

  Pagination(
      {this.total,
        this.perPage,
        this.currentPage,
        this.nextPageUrl,
        this.lastPageUrl,
        this.from,
        this.to});

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