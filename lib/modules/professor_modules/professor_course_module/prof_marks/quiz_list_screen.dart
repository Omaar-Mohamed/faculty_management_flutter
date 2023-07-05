import 'package:flutter/material.dart';
import 'package:sms_flutter/modules/professor_modules/professor_course_module/prof_marks/prof_search_mark_screen.dart';
import 'package:sms_flutter/modules/professor_modules/professor_course_module/prof_marks/prof_show_student_marks.dart';

import '../../../../layout/professor_general/professor_general.dart';
import '../../../../layout/student_general/student_general.dart';
import '../../../../shared/components/components.dart';

class QuizListScreen extends StatelessWidget {
  final String? type;
  final String? courseName;
  QuizListScreen({Key? key, this.type,required this.courseName }) : super(key: key);
  final List<String> _quizzes = ['Quiz 1', 'Midterm', 'Final'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: projectAppBar(context),
      drawer: type=="student"? StudentGeneral():ProfessorGeneral(),
      body: ListView.builder(
        itemCount: _quizzes.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(
                _quizzes[index],
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
              onTap: () {
                // TODO: Navigate to quiz details screen
                navigateTo(context, StudentMarksTableScreen(type: type,courseName: courseName,));
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfSearchMarkScreen(courseName: courseName,type: type,),
            ),
          );
        },
      ),
    );
  }
}