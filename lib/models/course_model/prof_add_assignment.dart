class ProfAddAssignment {
  String? status;
  String? message;
  List<ProfAddAssignmentData>? data;

  ProfAddAssignment({this.status, this.message, this.data});

  ProfAddAssignment.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = List<ProfAddAssignmentData>.from(
          json['data'].map((x) => ProfAddAssignmentData.fromJson(x)));
    }
  }
}

class ProfAddAssignmentData {
  int? id;
  String? name;
  String? description;
  int? points;
  String? createdAt;
  String? status;
  String? dueDate;
  String? publisher;
  List<dynamic>? attachments;
  List<ProfAddAssignmentCourseSemester>? courseSemester;

  ProfAddAssignmentData({
    this.id,
    this.name,
    this.description,
    this.points,
    this.createdAt,
    this.status,
    this.dueDate,
    this.publisher,
    this.attachments,
    this.courseSemester,
  });

  ProfAddAssignmentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    points = json['points'];
    createdAt = json['created_at'];
    status = json['status'];
    dueDate = json['due_date'];
    publisher = json['publisher'];
    attachments = json['attachments'];
    if (json['course_semester'] != null) {
      courseSemester = List<ProfAddAssignmentCourseSemester>.from(
          json['course_semester'].map((x) => ProfAddAssignmentCourseSemester.fromJson(x)));
    }
  }
}

class ProfAddAssignmentCourseSemester {
  bool? selected;
  ProfAddAssignmentRegistered? registered;
  int? id;
  int? limit;
  String? markType;
  String? department;
  List<ProfAddAssignmentCourse>? course;

  ProfAddAssignmentCourseSemester({
    this.selected,
    this.registered,
    this.id,
    this.limit,
    this.markType,
    this.department,
    this.course,
  });

  ProfAddAssignmentCourseSemester.fromJson(Map<String, dynamic> json) {
    selected = json['selected'];
    registered = json['registered'] != null
        ? ProfAddAssignmentRegistered.fromJson(json['registered'])
        : null;
    id = json['id'];
    limit = json['limit'];
    markType = json['mark_type'];
    department = json['department'];
    if (json['course'] != null) {
      course =
      List<ProfAddAssignmentCourse>.from(json['course'].map((x) => ProfAddAssignmentCourse.fromJson(x)));
    }
  }
}

class ProfAddAssignmentRegistered {
  dynamic lecture;
  dynamic section;

  ProfAddAssignmentRegistered({this.lecture, this.section});

  ProfAddAssignmentRegistered.fromJson(Map<String, dynamic> json) {
    lecture = json['lecture'];
    section = json['section'];
  }
}

class ProfAddAssignmentCourse {
  int? id;
  String? name;
  String? courseCode;
  String? cat;
  int? minCreditHours;
  int? creditHours;

  ProfAddAssignmentCourse({
    this.id,
    this.name,
    this.courseCode,
    this.cat,
    this.minCreditHours,
    this.creditHours,
  });

  ProfAddAssignmentCourse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    courseCode = json['course_code'];
    cat = json['cat'];
    minCreditHours = json['min_credit_hours'];
    creditHours = json['credit_hours'];
  }
}