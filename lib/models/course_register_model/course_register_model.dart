class CourseRegister {
  String? status;
  String? message;
  List<Data>? data;

  CourseRegister({this.status, this.message, this.data});

  CourseRegister.fromJson(Map<String, dynamic> json) {
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
  bool? selected;
  Registered? registered;
  int? id;
  int? limit;
  String? markType;
  String? department;
  List<Course>? course;

  Data(
      {this.selected,
        this.registered,
        this.id,
        this.limit,
        this.markType,
        this.department,
        this.course});

  Data.fromJson(Map<String, dynamic> json) {
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
