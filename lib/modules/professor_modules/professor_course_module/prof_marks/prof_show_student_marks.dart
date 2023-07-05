import 'package:flutter/material.dart';
import 'package:sms_flutter/modules/professor_modules/professor_course_module/prof_marks/prof_search_mark_screen.dart';
import 'package:sms_flutter/shared/components/components.dart';

import '../../../../layout/professor_general/professor_general.dart';

class StudentMark {
  final String name;
  final String id;
  final double mark;

  StudentMark({required this.name, required this.id, required this.mark});
}

class StudentMarksTableScreen extends StatelessWidget {
  final String? type;
  final String? courseName;
  StudentMarksTableScreen({Key? key, this.type,required this.courseName}) : super(key: key);
  final List<StudentMark> studentMarks = [
    StudentMark(name: 'Omar Mohamed ali Mohamed Ali', id: '10012144555', mark: 10000),
    StudentMark(name: 'Yahya Mahmoud Mohamed Seleman Awad', id: '1001', mark: 20),
    StudentMark(name: 'John Doe', id: '1002', mark: 92.5),
    StudentMark(name: 'Hady Hassan Saleh', id: '1003', mark: 78.0),
    StudentMark(name: 'Ahmed mohamed attia', id: '1004', mark: 40),
    StudentMark(name: 'Omar elwazery (wezza)', id: '1004', mark: 10),
  ];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: projectAppBar(context),
      drawer: ProfessorGeneral(),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Text(
              'Course Name: Software Engineering',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Midterm Exam',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.0),
            DataTable(
              checkboxHorizontalMargin: 16.0,
              columnSpacing: 16.0,
              columns: [
                DataColumn(
                    label: Text('ID'),
                    numeric: false,
                ),
                DataColumn(

                    label: Text('Name',
                    ),
                    numeric: false
                ),
                DataColumn(
                    label: Text('Mark'),
                    numeric: false
                ),
              ],
              rows: studentMarks
                  .map(
                    (student) => DataRow(
                  cells: [
                    DataCell(Text(student.id)),
                    DataCell(Text(student.name)),
                    DataCell(
                      Text(
                        student.mark.toString(),
                        style: TextStyle(
                          color: Mark(student.mark.toInt()),
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ),

                  ],
                ),
              )
                  .toList(),
            ),
            SizedBox(height: 16.0),
          ],
        ),
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
Color Mark(int mark){
  if(mark>=50){
    return Colors.green;
  }
  else{
    return Colors.red;
  }
}