import 'package:flutter/material.dart';
import 'package:sms_flutter/layout/student_general/student_general.dart';
import 'package:sms_flutter/shared/components/components.dart';

import 'course_material_lecture_screen.dart';
import 'courses_quize_detail_screen.dart';

class Quizies {
  final String title;

  Quizies({required this.title});
}

class CourseQuiziesScreen extends StatelessWidget {
  final List<Quizies> quiez = [
    Quizies(
        title: 'ََQuiz 1',

    ),
    Quizies(
        title: 'ََQuiz 2',

    ),
    Quizies(
        title: 'ََMidterm',

    ),
    Quizies(
        title: 'ََFinal',

    ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: projectAppBar(context),
      drawer: StudentGeneral(),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Text(
                    'Quizies',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),

                ],
              ),
            ),
            Expanded(
              child: ListView.separated(
                  itemCount: quiez.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: ()
                      {
                        navigateTo(context, QuizScreen());
                      },
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.all(9),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                  quiez[index].title,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                              ),
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
