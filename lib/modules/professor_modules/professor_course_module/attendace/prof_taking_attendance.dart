import 'package:flutter/material.dart';

class Student {
  final int id;
  final String name;
  bool isPresent;

  Student({required this.id, required this.name, this.isPresent = false});
}

class ProfTakingAttendanceScreen extends StatefulWidget {
  @override
  _ProfTakingAttendanceScreenState createState() => _ProfTakingAttendanceScreenState();
}

class _ProfTakingAttendanceScreenState extends State<ProfTakingAttendanceScreen> {
  List<Student> _students = [    Student(id: 1, name: 'John Doe'),    Student(id: 2, name: 'Omar Mohamed Ali Mohamed'),    Student(id: 3, name: 'Hady hassan saleh'),    Student(id: 4, name: 'Sally Lee'),    Student(id: 5, name: 'Mike Chen'),  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.0),
            Center(
              child: Text(
                '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            DataTable(
              columnSpacing: 16.0,
              columns: [
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Attendance')),
              ],
              rows: _students
                  .map(
                    (student) => DataRow(
                  cells: [
                    DataCell(Text(student.id.toString())),
                    DataCell(Text(student.name)),
                    DataCell(
                      Row(
                        children: [
                          AttendanceButton(
                            color: Colors.green,
                            text: 'Present',
                            isSelected: student.isPresent,
                            onPressed: () {
                              setState(() {
                                student.isPresent = true;
                              });
                            },
                          ),
                          SizedBox(width: 8.0),
                          AttendanceButton(
                            color: Colors.red,
                            text: 'Absent',
                            isSelected: !student.isPresent,
                            onPressed: () {
                              setState(() {
                                student.isPresent = false;
                              });
                            },
                          ),
                        ],
                      ),
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
    );
  }
}

class AttendanceButton extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  AttendanceButton({
    required this.color,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          isSelected ? color.withOpacity(0.4) : color,
        ),
      ),
      child: Text(text),
    );
  }
}