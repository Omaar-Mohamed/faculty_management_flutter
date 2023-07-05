import 'package:flutter/material.dart';
import 'package:sms_flutter/layout/student_general/student_general.dart';
import 'package:sms_flutter/shared/components/components.dart';

import '../../../layout/professor_general/professor_general.dart';
import 'course_material_folder_screen.dart';
import 'course_material_lecture_screen.dart';

class FolderModel {
  final String name;
  final IconData icon;
  final String date;

  FolderModel({required this.name, required this.icon, required this.date});
}

class LecOrSecScreen extends StatelessWidget {
  final String? type;
  final String? id;
  LecOrSecScreen({Key? key, this.type,this.id}) : super(key: key);

  final List<FolderModel> folders = [
    FolderModel(
        name: 'lecture material', icon: Icons.folder, date: '12/12/2021'),
    FolderModel(
        name: 'section material', icon: Icons.folder, date: '10/12/2021'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: projectAppBar(context),
      drawer: type == "student" ? StudentGeneral() : ProfessorGeneral(),
      body: ListView.builder(
        itemCount: folders.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if (folders[index].name == 'lecture material')
                navigateTo(context, CourseMaterialScreen(type: type,id:id,materialType: 'lecture',));
              else if (folders[index].name == 'section material')
              navigateTo(context, CourseMaterialScreen(type: type,id: id,  materialType: 'section',));
            },
            child: Container(
              height: 60,
              padding: EdgeInsets.all(9),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          folders[index].icon,
                          color: Colors.amber,
                        ),
                        SizedBox(width: 16),
                        Text(folders[index].name),
                      ],
                    ),
                  ),
                  Text(
                    folders[index].date,
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        },
      ),

    );
  }
}
