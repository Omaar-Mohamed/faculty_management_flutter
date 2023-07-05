import 'package:sms_flutter/models/course_model/prof_course_model.dart';
import 'package:sms_flutter/models/schedules_model/prof_post_online_meeting.dart';
import 'package:sms_flutter/models/schedules_model/schedules_model.dart';
import 'package:sms_flutter/models/schedules_model/student_schedules_model.dart';

abstract class SchedulesStates{}
class ShedulesInitialState extends SchedulesStates{}
class ShedulesChangeState extends SchedulesStates{}
class  ShedulesLoadingState extends SchedulesStates{}

class ShedulesSuccessState extends SchedulesStates{
  late final SchedulesModel? schedulesModel;
  ShedulesSuccessState(this.schedulesModel);
}

class   ShedulesErrorState extends SchedulesStates{
  final String error;
  ShedulesErrorState(this.error);
}

class StudentScheduleSuccessState extends SchedulesStates{
  late final StudentSchedulesModel? schedulesModel;
  StudentScheduleSuccessState(this.schedulesModel);
}
class StudentScheduleErrorState extends SchedulesStates{
  final String error;
  StudentScheduleErrorState(this.error);
}
class StudentScheduleLoadingState extends SchedulesStates{}
class PostMeetingLoadingState extends SchedulesStates{}
class PostMeetingSuccessState extends SchedulesStates
{
  late final PostOnlineMeetingModel postOnlineMeetingModel;
  PostMeetingSuccessState(this.postOnlineMeetingModel);
}
class  PostMeetingErrorState extends SchedulesStates
{
  final String error;
  PostMeetingErrorState(this.error);
}
class GetProfCoursesLoadingState extends SchedulesStates{}
class GetProfCoursesSuccessState extends SchedulesStates
{
  late final ProfCourseModel profCourseModel;
  GetProfCoursesSuccessState(this.profCourseModel);
}
class  GetProfCoursesErrorState extends SchedulesStates
{
  final String error;
  GetProfCoursesErrorState(this.error);
}

class ChangeScheduleState extends SchedulesStates{}