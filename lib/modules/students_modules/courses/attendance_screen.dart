import 'package:flutter/material.dart';
import 'package:sms_flutter/shared/components/components.dart';

import '../../../layout/student_general/student_general.dart';

class Attendance {
  final String week;
  final String present;

  Attendance({required this.week, required this.present});
}

class AttendanceScreen extends StatelessWidget {
  final String? type;
   AttendanceScreen({Key? key, this.type}) : super(key: key);
  final List<Attendance> attendanceList = [
    Attendance(week: 'Week 1', present: 'Present'),
    Attendance(week: 'Week 2', present: 'Absent'),
    Attendance(week: 'Week 3', present: 'Present'),
    Attendance(week: 'Week 4', present: 'Present'),
    Attendance(week: 'Week 5', present: 'Absent'),
    Attendance(week: 'Week 6', present: 'Present'),
    Attendance(week: 'Week 7', present: 'Absent'),
    Attendance(week: 'Week 8', present: 'Dayoff'),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: projectAppBar(context),
      drawer: StudentGeneral(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
      Padding(
      padding: const EdgeInsets.all(11.5),
       child: Center(
         child: Text(
            "Your Attendance",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
       ),
      ),
          Expanded(
            child: ListView.builder(
              itemCount: attendanceList.length,
              itemBuilder: (BuildContext context, int index) {
                final attendance = attendanceList[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.grey[200],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 16.0),
                        Expanded(
                          child: Text(
                            attendance.week,
                            style: TextStyle(fontSize: 18.0),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                            color: attendance.present == 'Present'
                                ? Colors.green
                                : attendance.present == 'Absent'
                                    ? Colors.red
                                    :attendance.present == 'Dayoff'?
                                    Colors.grey:Colors.yellow,
                          ),
                          child: Text(
                            attendance.present,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(width: 16.0),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
