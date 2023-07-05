class SchedulesModel {
  final String? status;
  final String? message;
  final List<Schedule>? data;

  SchedulesModel({
    this.status,
    this.message,
    this.data,
  });

  factory SchedulesModel.fromJson(Map<String, dynamic> json) {
    return SchedulesModel(
      status: json['status'],
      message: json['message'],
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => Schedule.fromJson(item))
          .toList(),
    );
  }
}

class Schedule {
  final String? locationName;
  final String? seatLimit;
  final String? seatsLeft;
  final String? link;
  final bool? registered;
  final int? id;
  final String? start;
  final String? end;
  final int? day;
  final String? dayName;
  final String? locationType;
  final int? seatsReserved;
  final String? type;
  final int? duration;
  final bool? enabled;
  final String? repetition;
  final int? week;
  final String? weekRepetition;
  final List<CourseSemester>? courseSemester;

  Schedule({
    this.locationName,
    this.seatLimit,
    this.seatsLeft,
    this.link,
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
    this.week,
    this.weekRepetition,
    this.courseSemester,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      locationName: json['location_name'],
      seatLimit: json['seat_limit'],
      seatsLeft: json['seats_left'],
      link: json['link'],
      registered: json['registered'],
      id: json['id'],
      start: json['start'],
      end: json['end'],
      day: json['day'],
      dayName: json['day_name'],
      locationType: json['location_type'],
      seatsReserved: json['seats_reserved'],
      type: json['type'],
      duration: json['duration'],
      enabled: json['enabled'],
      repetition: json['repetition'],
      week: json['week'],
      weekRepetition: json['week_repetition'],
      courseSemester: (json['course_semester'] as List<dynamic>?)
          ?.map((item) => CourseSemester.fromJson(item))
          .toList(),
    );
  }
}

class CourseSemester {
  final bool? selected;
  final Registered? registered;
  final int? id;
  final int? limit;
  final String? markType;
  final String? department;
  final List<Course>? course;

  CourseSemester({
    this.selected,
    this.registered,
    this.id,
    this.limit,
    this.markType,
    this.department,
    this.course,
  });

  factory CourseSemester.fromJson(Map<String, dynamic> json) {
    return CourseSemester(
      selected: json['selected'],
      registered: Registered.fromJson(json['registered']),
      id: json['id'],
      limit: json['limit'],
      markType: json['mark_type'],
      department: json['department'],
      course: (json['course'] as List<dynamic>?)
          ?.map((item) => Course.fromJson(item))
          .toList(),
    );
  }
}

class Registered {
  final dynamic lecture;
  final dynamic section;

  Registered({
    this.lecture,
    this.section,
  });

  factory Registered.fromJson(Map<String, dynamic> json) {
    return Registered(
      lecture: json['lecture'],
      section: json['section'],
    );
  }
}

class Course {
  final int? id;
  final String? name;
  final String? courseCode;
  final String? cat;
  final int? minCreditHours;
  final int? creditHours;

  Course({
    this.id,
    this.name,
    this.courseCode,
    this.cat,
    this.minCreditHours,
    this.creditHours,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      courseCode: json['course_code'],
      cat: json['cat'],
      minCreditHours: json['min_credit_hours'],
      creditHours: json['credit_hours'],
    );
  }
}
