import 'package:flutter/material.dart';
import 'package:sms_flutter/modules/professor_modules/professor_course_module/attendace/prof_taking_attendance.dart';
import 'package:sms_flutter/shared/components/components.dart';
import 'package:sms_flutter/shared/network/local/cache_helper(shared_prefrenceds).dart';

import '../../../students_modules/courses/attendance_screen.dart';

class WeeksScreen extends StatelessWidget {
  var otp=CacheHelper.getData(key: 'otp');

  final String? type;
  WeeksScreen({Key? key, this.type }) : super(key: key);
  final List<String> weeks = [    'Week 1',    'Week 2',    'Week 3',    'Week 4',    'Week 5',    'Week 6',    'Week 7',    'Week 8',    'Week 9',    'Week 10',  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Weeks'),
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: weeks.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: (){
                navigateTo(context, ProfTakingAttendanceScreen());
              },
              child: Container(
                color:Colors.white,
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                child: Text(
                  weeks[index],
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
