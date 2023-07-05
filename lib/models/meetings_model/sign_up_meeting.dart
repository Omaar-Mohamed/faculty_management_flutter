class SignUpMeetingModel {

  String? status;
  String? message;
  List<ScheduleData>? data;

  SignUpMeetingModel({this.status, this.message, this.data});

  SignUpMeetingModel.fromJson(Map<String, dynamic> json) {
  status = json['status'];
  message = json['message'];
  if (json['data'] != null) {
  data = [];
  json['data'].forEach((v) {
  data!.add(ScheduleData.fromJson(v));
  });
  }
  }
  }

  class ScheduleData {
  int? locationId;
  String? locationName;
  dynamic seatLimit;
  dynamic seatsLeft;
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

  ScheduleData({
  this.locationId,
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
  this.courseSemester,
  });

  ScheduleData.fromJson(Map<String, dynamic> json) {
  locationId = json['location_id'];
  locationName = json['location_name'];
  seatLimit = json['seat_limit'];
  seatsLeft = json['seats_left'];
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
  courseSemester = [];
  json['course_semester'].forEach((v) {
  courseSemester!.add(CourseSemester.fromJson(v));
  });
  }
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

  CourseSemester({
  this.selected,
  this.registered,
  this.id,
  this.limit,
  this.markType,
  this.department,
  this.course,
  });

  CourseSemester.fromJson(Map<String, dynamic> json) {
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

  Registered({this.lecture});

  Registered.fromJson(Map<String, dynamic> json) {
  lecture =
  json['lecture'] != null ? Lecture.fromJson(json['lecture']) : null;
  }
  }

  class Lecture {
  String? date;
  String? start;
  String? end;
  String? locationType;

  Lecture({this.date, this.start, this.end, this.locationType});

  Lecture.fromJson(Map<String, dynamic> json) {
  date = json['date'];
  start = json['start'];
  end = json['end'];
  locationType = json['location_type'];
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
