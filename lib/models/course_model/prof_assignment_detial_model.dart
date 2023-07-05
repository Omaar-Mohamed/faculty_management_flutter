class ProfGetAssignmentDetail {
  String? status;
  Null? message;
  List<Data>? data;

  ProfGetAssignmentDetail({this.status, this.message, this.data});

  ProfGetAssignmentDetail.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
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
  bool? selected;
  Registered? registered;
  int? id;
  int? limit;
  String? markType;
  String? department;
  List<Course>? course;

  CourseSemester(
      {this.selected,
        this.registered,
        this.id,
        this.limit,
        this.markType,
        this.department,
        this.course});

  CourseSemester.fromJson(Map<String, dynamic> json) {
    selected = json['selected'];
    registered = json['registered'] != null
        ? new Registered.fromJson(json['registered'])
        : null;
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
    data['selected'] = this.selected;
    if (this.registered != null) {
      data['registered'] = this.registered!.toJson();
    }
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

class Registered {
  Null? lecture;
  Null? section;

  Registered({this.lecture, this.section});

  Registered.fromJson(Map<String, dynamic> json) {
    lecture = json['lecture'];
    section = json['section'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lecture'] = this.lecture;
    data['section'] = this.section;
    return data;
  }
}

class Course {
  int? id;
  String? name;
  String? courseCode;
  String? cat;
  int? minCreditHours;
  int? creditHours;

  Course(
      {this.id,
        this.name,
        this.courseCode,
        this.cat,
        this.minCreditHours,
        this.creditHours});

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    courseCode = json['course_code'];
    cat = json['cat'];
    minCreditHours = json['min_credit_hours'];
    creditHours = json['credit_hours'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['course_code'] = this.courseCode;
    data['cat'] = this.cat;
    data['min_credit_hours'] = this.minCreditHours;
    data['credit_hours'] = this.creditHours;
    return data;
  }
}