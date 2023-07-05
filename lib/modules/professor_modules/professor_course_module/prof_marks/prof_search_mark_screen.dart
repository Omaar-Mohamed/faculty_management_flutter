import 'package:flutter/material.dart';

import '../../../../layout/professor_general/professor_general.dart';
import '../../../../layout/student_general/student_general.dart';
import '../../../../shared/components/components.dart';
import '../../../students_modules/courses/student_courses_marks.dart';

class ProfSearchMarkScreen extends StatelessWidget {
  final String? type;
  final String? courseName;
   ProfSearchMarkScreen({Key? key,this.type,required this.courseName}) : super(key: key);

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: projectAppBar(context),
      drawer: type=="student"? StudentGeneral():ProfessorGeneral(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Search for Student Marks',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 350.0,
                      child: TextFormField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          labelText: 'Student Name',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Student Name';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Container(
                      width: 350.0,
                      child: TextFormField(
                        controller: _lastNameController,
                        keyboardType: TextInputType.number,
                        // inputFormatters: [
                        //   FilteringTextInputFormatter.digitsOnly,
                        // ],
                        decoration: InputDecoration(
                          labelText: 'Student ID',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a value';
                          }
                          final n = int.tryParse(value);
                          if (n == null) {
                            return 'Please enter a valid ID';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Form is valid, submit it
                          // TODO: Implement submit logic
                          navigateTo(context,CourseMarksScreen(type: type,courseName: courseName,name: _firstNameController.text,));
                        }
                      },
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

