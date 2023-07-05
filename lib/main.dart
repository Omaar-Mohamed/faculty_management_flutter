import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sms_flutter/layout/on_boarding/on_boarding_screen.dart';
// import 'package:sms_flutter/layout/professor_general/professor_general/professor_general.dart';
import 'package:sms_flutter/modules/chat/chat_list.dart';
import 'package:sms_flutter/modules/login/login_screen.dart';
import 'package:sms_flutter/modules/students_modules/courses/course_details_screen.dart';
import 'package:sms_flutter/modules/students_modules/courses/courses_screen.dart';
import 'package:sms_flutter/modules/students_modules/profile/edit_profile_screen.dart';
import 'package:sms_flutter/modules/students_modules/profile/profile_screen.dart';
import 'package:sms_flutter/modules/students_modules/setting/setting_screen.dart';
import 'package:sms_flutter/notify.dart';
import 'package:sms_flutter/shared/constants/constants.dart';
import 'package:sms_flutter/shared/network/local/cache_helper(shared_prefrenceds).dart';
import 'package:sms_flutter/shared/network/remote/dio_helper.dart';
import 'package:sms_flutter/shared/network/remote/pusher.dart';
// import 'package:sms_flutter/test.dart';
// import 'package:sms_flutter/quiez_test.dart';
// import 'package:sms_flutter/test.dart';
// import 'package:sms_flutter/test2.dart';
// import 'package:sms_flutter/test_quiz.dart';


// import 'layout/professor_general/professor_general/professor_general.dart';
import 'layout/student_general/student_general.dart';
import 'modules/chat/chat_screen.dart';
import 'modules/notifications/notifications_screen.dart';
import 'modules/professor_modules/professor_course_module/attendace/attendace_weeks.dart';
import 'modules/professor_modules/professor_course_module/attendace/prof_taking_attendance.dart';
// import 'modules/professor_modules/professor_course_module/attendace/prof_taking_attendance2.dart';


import 'modules/professor_modules/professor_course_module/prof_marks/prof_show_student_marks.dart';
import 'modules/professor_modules/professor_schedule_module/prof_make_online_meeting_screen.dart';
import 'modules/professor_modules/professor_schedule_module/prof_schedule_screen.dart';
import 'modules/students_modules/Community/comment_screen.dart';
import 'modules/students_modules/Community/community_screen.dart';
import 'modules/students_modules/courses/assignment_detail_screen.dart';
import 'modules/students_modules/courses/assignments.dart';
import 'modules/students_modules/courses/attendance_screen.dart';
import 'modules/students_modules/courses/courses_quize_detail_screen.dart';
import 'modules/students_modules/schedules/schedules_screen.dart';
Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  await CacheHelper.init();
  connectPusher();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  NotificationApi.initialize(flutterLocalNotificationsPlugin);

  // Widget widget;
  //  token = CacheHelper.getData(key: 'token');


  runApp(MyApp());
}
class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      // initialRoute: '/screen1',
      // routes: {
      //   '/screen1': (context) => Screen1(),
      //   '/screen2': (context) => Screen2(),
      //   '/screen3': (context) => Screen3(),
      // },
      // home: OnBoardingScreen(),
      home:OnBoardingScreen(),
    );

  }

}

