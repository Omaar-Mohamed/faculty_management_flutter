import 'package:flutter/material.dart';
import 'package:sms_flutter/layout/professor_general/professor_general.dart';
import 'package:sms_flutter/layout/student_general/student_general.dart';
import 'package:sms_flutter/modules/professor_modules/professor_course_module/attendace/attendace_weeks.dart';
import 'package:sms_flutter/modules/students_modules/Community/community_screen.dart';
import 'package:sms_flutter/modules/students_modules/courses/course_material_folder_screen.dart';
import 'package:sms_flutter/shared/components/components.dart';

import '../../professor_modules/professor_course_module/prof_marks/prof_search_mark_screen.dart';
import '../../professor_modules/professor_course_module/prof_marks/quiz_list_screen.dart';
import 'assignments.dart';
import 'attendance_screen.dart';
import 'community_course_screen.dart';
import 'student_courses_marks.dart';
import 'courses_quiz_screen.dart';
import 'lecorsec_screen.dart';

class CourseDetailScreen extends StatelessWidget {

  final String? type;
  final String? id;
  final String? courseName;
  CourseDetailScreen({Key? key, this.type,this.id,required this.courseName }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: projectAppBar(context),
      drawer: type=="student"? StudentGeneral():ProfessorGeneral(),
      body:  SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                  children: [
                    courseDetailsItem(name:'Material',image:'assets/images/material.png',context: context,widget: LecOrSecScreen(type:type,id:id)),
                    SizedBox(
                      width: 20,
                    ),
                    courseDetailsItem(name:'Marks',image:'assets/images/marks.png',context: context,widget:type=='student'?CourseMarksScreen(type: type,courseName: courseName,) :QuizListScreen(type: type,courseName: courseName,)),
                  ]
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                  children: [
                    courseDetailsItem(name:'Assignment',image:'assets/images/assignments.png',context: context,widget: AssignmentsScreen(type:type,id:id)),
                    SizedBox(
                      width: 20,
                    ),
                    courseDetailsItem(name:'Quiz',image:'assets/images/quiz.png',context: context,widget: CourseQuiziesScreen()),
                  ]
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                  children: [
                    courseDetailsItem(name:'Attendence',image:'assets/images/attendance.png',context: context,widget: type=='student'? AttendanceScreen(type: type,):WeeksScreen(type: type,)),
                    SizedBox(
                      width: 20,
                    ),
                    courseDetailsItem(name:'Community',image:'assets/images/community.png',context: context,widget: CommunityScreen(type: type,from: 'courses',)),
                  ]
              ),
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
