import 'package:flutter/material.dart';
import 'package:sms_flutter/layout/professor_general/professor_general.dart';
import 'package:sms_flutter/layout/student_general/student_general.dart';
import 'package:sms_flutter/shared/components/components.dart';

import '../../../shared/constants/constants.dart';
import 'course_material_lecture_screen.dart';

class Marks {
  final String title;
  final String mark;

  Marks({required this.title,required this.mark});
}

class CourseMarksScreen extends StatelessWidget {
  final String? type;
  final String? courseName;
  String? name;
  CourseMarksScreen({Key? key, this.type,required this.courseName,this.name }) : super(key: key);
  final List<Marks> marks = [
    Marks(
      title: 'ََQuiz 1',
      mark:'5/10'
    ),
    Marks(
      title: 'ََQuiz 3',
        mark:'5/10'
    ),
    Marks(
      title: 'ََMidterm',
        mark:'5/20'
    ),
    Marks(
      title: 'ََFinal',
        mark:'5/60'
    ),
    Marks(
        title: 'َGrade',
        mark:'F'
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: projectAppBar(context),
      drawer: type=="student"? StudentGeneral():ProfessorGeneral(),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                type == 'professor'?'Student Name: $name':'Student Name: $fname $lname',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              // Text(
              //   'Student ID: 203009',
              //   style: TextStyle(fontWeight: FontWeight.bold),
              // ),
              Text(
                'Course Name: $courseName',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        myDivider(),
        Expanded(
          child: ListView.separated(
              itemCount: marks.length,
              itemBuilder: (context, index) {
                return InkWell(
                  child: Container(
                    height: 40,
                    padding: EdgeInsets.all(9),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(marks[index].title),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Text(marks[index].mark),
                        ),
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                // Build your separator widget here
                return Divider(
                  color: Colors.black54,
                );
              }),
        ),
      ]),
    );
  }
}
