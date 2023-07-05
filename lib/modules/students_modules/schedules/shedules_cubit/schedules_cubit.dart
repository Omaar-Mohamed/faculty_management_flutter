import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sms_flutter/models/course_model/prof_course_model.dart';
import 'package:sms_flutter/models/schedules_model/prof_post_online_meeting.dart';
import 'package:sms_flutter/models/schedules_model/schedules_model.dart';
import 'package:sms_flutter/models/schedules_model/student_schedules_model.dart';
import 'package:sms_flutter/shared/constants/constants.dart';
import 'package:sms_flutter/shared/network/end_points.dart';
import 'package:sms_flutter/shared/network/remote/dio_helper.dart';
import 'schedules_states.dart';
class SchedulesCubit extends Cubit<SchedulesStates>{

  SchedulesCubit() : super(ShedulesInitialState());
  static SchedulesCubit get(context) => BlocProvider.of(context);
  late String _chosenValue;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late String valueChoose;

  String dropdownvalue = 'choose your course';

  var items =  ['choose your course','oop','data structure','math2','game programming','computer graphics',];
  var currentPage;
  int selectedIndex = 0;


  List<List<Map<String,dynamic>>> item = [
    [ {
      "date":"sunday 15/9",
      "title": "Math 2",
      "day": "Sunday",
      "time": "From 8 to 9",
      "location":"Hall 10",
      "teacher":"Dr.Rasha Montaser",
      "type":"lecture"
    },
      {
        "date":"sunday 15/2",
        "title": "oop",
        "day": "Sunday",
        "time": "From 8 to 9",
        "location":"Hall 10",
        "teacher":"Dr.Rasha Montaser"
        // "type":"lecture"

      },
    ],
    [{

      "date":"sunday 15/10",
      "title": "algorithm",
      "day": "Sunday",
      "time": "From 8 to 9",
      "location":"Hall 1",
      "teacher":"Dr.Ahmed youness"
      // "type":"lecture"

    }],
    [],
    [],
    [],
    [],
    [],
    [],
    []

  ];
  List<Map<String, dynamic>> weekDaysList = [
    {'dayName': 'Saturday', 'dayNumber': 0},
    {'dayName': 'Sunday', 'dayNumber': 1},
    {'dayName': 'Monday', 'dayNumber': 2},
    {'dayName': 'Tuesday', 'dayNumber': 3},
    {'dayName': 'Wednesday', 'dayNumber': 4},
    {'dayName': 'Thursday', 'dayNumber': 5},
    {'dayName': 'Friday', 'dayNumber': 6},

  ];

  // Accessing data from the weekDaysList
  // weekDaysList.forEach((dayMap) {
  // String dayName = dayMap['dayName'];
  // int dayNumber = dayMap['dayNumber'];
  //
  // print('Day Name: $dayName, Day Number: $dayNumber');
  // });


void scroll(int index) {
  selectedIndex = index;
    emit(ShedulesChangeState());

}
void dropdown(String value){
  dropdownvalue = value;
}
  SchedulesModel? schedulesModel;
StudentSchedulesModel? studentSchedulesModel;

  List<dynamic> scheduleData = [];// List to store the schedule data from API
  List<String> days = ['Saturday','Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday' ];
  List<dynamic> courses = []; // List to store the filtered courses for the selected day
  String selectedDay = 'Saturday';

  void getMeetings() {
    print(token);
    emit(ShedulesLoadingState());
    if (role == 'professor') {
      DioHelper.getData(url: GETMEETINGS,
        token: token,
      ).then((value) {
        print(value?.data.toString());
        scheduleData = value?.data['data'];
        schedulesModel = SchedulesModel.fromJson(value?.data);
        emit(ShedulesSuccessState(schedulesModel));
        filterCoursesForDay(selectedDay);
      }).catchError((error) {
        print(error.toString());
        if (error.response != null && error.response.data != null) {
          // print('Errors: ${error.response.data}');
          if (error.response.data['errors'] != null) {
            // Handle multiple errors
            List<String> errors = List<String>.from(
                error.response.data['errors']);
            // print('Errors: $errors');
            emit(ShedulesErrorState(errors.join(", ")));
          } else if (error.response.data['message'] != null) {
            // Handle single error message
            String errorMessage = error.response.data['message'];
            // print('Error: $errorMessage');
            emit(ShedulesErrorState(errorMessage));
          } else {
            // print('Some thing went wrong , please try again');
            emit(
                ShedulesErrorState('Some thing went wrong , please try again'));
          }
        } else {
          // print(''Some thing went wrong , please try again' ');
          emit(ShedulesErrorState('Some thing went wrong , please try again'));
        }
      });
    }
    else if (role == 'student') {
      emit(ShedulesLoadingState());
      DioHelper.getData(url: GETSTUDENTMEETINGS,
        token: token,
      ).then((value) {
        print(value?.data.toString());
        scheduleData = value?.data['data'];
        studentSchedulesModel = StudentSchedulesModel.fromJson(value?.data);
        emit(StudentScheduleSuccessState(studentSchedulesModel));
        filterCoursesForDay(selectedDay);
      }).catchError((error) {
        print(error.toString());
        debugPrint('error is ${error.toString()}');
        if (error.response != null && error.response.data != null) {
          // print('Errors: ${error.response.data}');
          if (error.response.data['errors'] != null) {
            // Handle multiple errors
            List<String> errors = List<String>.from(
                error.response.data['errors']);
            // print('Errors: $errors');
            emit(StudentScheduleErrorState(errors.join(", ")));
          } else if (error.response.data['message'] != null) {
            // Handle single error message
            String errorMessage = error.response.data['message'];
            // print('Error: $errorMessage');
            emit(StudentScheduleErrorState(errorMessage));
          } else {
            // print('Some thing went wrong , please try again');
            emit(
                StudentScheduleErrorState('Some thing went wrong , please try again'));
          }
        } else {
          // print(''Some thing went wrong , please try again' ');
          emit(StudentScheduleErrorState('Some thing went wrong , please try again'));
        }
      });
    }
  }


  void filterCoursesForDay(String day) {
    selectedDay = day;
    courses = scheduleData
        .where((schedule) => schedule['day_name'] == selectedDay)
        .toList();
    emit(ShedulesChangeState());
    if (courses.isEmpty) {
      // Display "No schedule" message or handle it as desired
      print('No schedule in this day');
    } else {
      // Do something with the courses data
      emit(ShedulesChangeState());
      print(courses);
    }
    print(courses);
  }

  PostOnlineMeetingModel? postOnlineMeetingModel;

  void PostOnlineMeeting(
      int? course_sem_id,
      String? link,
      // int? day,

      DateTime? start,
      DateTime? end,
      DateTime? date,
      ) async {
    emit(PostMeetingLoadingState());

    try {
      String formattedDate = DateFormat('yyyy-MM-dd').format(date!);
      String formattedStartTime = DateFormat('HH:mm').format(start!);
      String formattedEndTime = DateFormat('HH:mm').format(end!);
// print('start =$start'+'end =$end');
      FormData formData = FormData.fromMap({

        'course_sem_id': course_sem_id,
        'link': link,
        // 'day': day,
        'start': formattedStartTime,
        'end': formattedEndTime,
        'date': formattedDate,
      });

      Response? response = await DioHelper.postFile(
        url: 'professor/meetings/addonline',
        data: formData,
        token: token,
      );

      if (response != null) {
        print(response.data.toString());
        postOnlineMeetingModel = PostOnlineMeetingModel.fromJson(response.data);
        emit(PostMeetingSuccessState(postOnlineMeetingModel!));
      } else {
        emit(PostMeetingErrorState('Something went wrong, please try again'));
      }
    } catch (error) {
      print(error.toString());
      emit(PostMeetingErrorState('Something went wrong, please try again'));
    }
  }
  ProfCourseModel? profCourseModel;

  void getCoursesProf() {
    print(token);
    emit(GetProfCoursesLoadingState());

      DioHelper.getData(url: 'professor/courses',
        token: token,
      ).then((value) {
        print(value?.data.toString());
        profCourseModel = ProfCourseModel.fromJson(value?.data);
        emit(GetProfCoursesSuccessState(profCourseModel!));
      }).catchError((error) {
        print(error.toString());
        if (error.response != null && error.response.data != null) {
          // print('Errors: ${error.response.data}');
          if (error.response.data['errors'] != null) {
            // Handle multiple errors
            List<String> errors = List<String>.from(
                error.response.data['errors']);
            // print('Errors: $errors');
            emit(GetProfCoursesErrorState(errors.join(", ")));
          } else if (error.response.data['message'] != null) {
            // Handle single error message
            String errorMessage = error.response.data['message'];
            // print('Error: $errorMessage');
            emit(GetProfCoursesErrorState(errorMessage));
          } else {
            // print('Some thing went wrong , please try again');
            emit(
                GetProfCoursesErrorState('Some thing went wrong , please try again'));
          }
        } else {
          // print(''Some thing went wrong , please try again' ');
          emit(GetProfCoursesErrorState('Some thing went wrong , please try again'));
        }
      });
    }

  }

