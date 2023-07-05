class MeetingsModel {
  String? status;
  String? message;
  List<MeetingData>? data;

  MeetingsModel({this.status, this.message, this.data});

  MeetingsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data!.add(MeetingData.fromJson(v));
      });
    }
  }
}

class MeetingData {
  bool? selected;
  Registered? registered;
  int? id;
  int? limit;
  String? markType;
  String? department;
  List<Course>? course;

  MeetingData({
    this.selected,
    this.registered,
    this.id,
    this.limit,
    this.markType,
    this.department,
    this.course,
  });

  MeetingData.fromJson(Map<String, dynamic> json) {
    selected = json['selected'];
    registered = Registered.fromJson(json['registered']);
    id = json['id'];
    limit = json['limit'];
    markType = json['mark_type'];
    department = json['department'];
    if (json['course'] != null) {
      course = [];
      json['course'].forEach((v) {
        course!.add(Course.fromJson(v));
      });
    }
  }
}

class Registered {
  Lecture? lecture;
  Section? section;

  Registered({this.lecture, this.section});

  Registered.fromJson(Map<String, dynamic> json) {
    lecture = json['lecture'] != null ? Lecture.fromJson(json['lecture']) : null;
    section = json['section'] != null ? Section.fromJson(json['section']) : null;
  }
}

class Lecture {
  int? id;
  String? start;
  String? end;
  String? day;
  String? courseSemId;
  String? type;
  String? locationType;
  String? link;
  String? repetition;
  String? locationId;
  String? date;
  String? quizId;
  String? createdAt;
  String? updatedAt;

  Lecture({
    this.id,
    this.start,
    this.end,
    this.day,
    this.courseSemId,
    this.type,
    this.locationType,
    this.link,
    this.repetition,
    this.locationId,
    this.date,
    this.quizId,
    this.createdAt,
    this.updatedAt,
  });

  Lecture.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    start = json['start'];
    end = json['end'];
    day = json['day'];
    courseSemId = json['course_sem_id'];
    type = json['type'];
    locationType = json['location_type'];
    link = json['link'];
    repetition = json['repetition'];
    locationId = json['location_id'];
    date = json['date'];
    quizId = json['quiz_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Section {
  int? id;
  String? start;
  String? end;
  String? day;
  String? courseSemId;
  String? type;
  String? locationType;
  String? link;
  String? repetition;
  String? locationId;
  String? date;
  String? quizId;
  String? createdAt;
  String? updatedAt;

  Section({
    this.id,
    this.start,
    this.end,
    this.day,
    this.courseSemId,
    this.type,
    this.locationType,
    this.link,
    this.repetition,
    this.locationId,
    this.date,
    this.quizId,
    this.createdAt,
    this.updatedAt,
  });

  Section.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    start = json['start'];
    end = json['end'];
    day = json['day'];
    courseSemId = json['course_sem_id'];
    type = json['type'];
    locationType = json['location_type'];
    link = json['link'];
    repetition = json['repetition'];
    locationId = json['location_id'];
    date = json['date'];
    quizId = json['quiz_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}

class Course {
  int? id;
  String? name;
  String? courseCode;
  String? cat;
  int? minCreditHours;
  int? creditHours;

  Course({
    this.id,
    this.name,
    this.courseCode,
    this.cat,
    this.minCreditHours,
    this.creditHours,
  });

  Course.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    courseCode = json['course_code'];
    cat = json['cat'];
    minCreditHours = json['min_credit_hours'];
    creditHours = json['credit_hours'];
  }
}
