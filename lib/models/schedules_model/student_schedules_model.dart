class StudentSchedulesModel {
  String? status;
  String? message;
  List<Data>? data;

  StudentSchedulesModel({this.status, this.message, this.data});

  StudentSchedulesModel.fromJson(Map<String, dynamic> json) {
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
  int? locationId;
  String? locationName;
  int? seatLimit;
  int? seatsLeft;
  bool? registered;
  int? id;
  String? start;
  String? end;
  int? day;
  String? dayName;
  String? locationType;
  int? seatsReserved;
  String? type;
  int? duration;
  bool? enabled;
  String? repetition;
  List<CourseSemester>? courseSemester;

  Data(
      {this.locationId,
        this.locationName,
        this.seatLimit,
        this.seatsLeft,
        this.registered,
        this.id,
        this.start,
        this.end,
        this.day,
        this.dayName,
        this.locationType,
        this.seatsReserved,
        this.type,
        this.duration,
        this.enabled,
        this.repetition,
        this.courseSemester});

  Data.fromJson(Map<String, dynamic> json) {
    locationId = json['location_id'];
    locationName = json['location_name'];
    // seatLimit = json['seat_limit'];
    // seatsLeft = json['seats_left'];
    registered = json['registered'];
    id = json['id'];
    start = json['start'];
    end = json['end'];
    day = json['day'];
    dayName = json['day_name'];
    locationType = json['location_type'];
    seatsReserved = json['seats_reserved'];
    type = json['type'];
    duration = json['duration'];
    enabled = json['enabled'];
    repetition = json['repetition'];
    if (json['course_semester'] != null) {
      courseSemester = <CourseSemester>[];
      json['course_semester'].forEach((v) {
        courseSemester!.add(new CourseSemester.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['location_id'] = this.locationId;
    data['location_name'] = this.locationName;
    data['seat_limit'] = this.seatLimit;
    data['seats_left'] = this.seatsLeft;
    data['registered'] = this.registered;
    data['id'] = this.id;
    data['start'] = this.start;
    data['end'] = this.end;
    data['day'] = this.day;
    data['day_name'] = this.dayName;
    data['location_type'] = this.locationType;
    data['seats_reserved'] = this.seatsReserved;
    data['type'] = this.type;
    data['duration'] = this.duration;
    data['enabled'] = this.enabled;
    data['repetition'] = this.repetition;
    if (this.courseSemester != null) {
      data['course_semester'] =
          this.courseSemester!.map((v) => v.toJson()).toList();
    }
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
