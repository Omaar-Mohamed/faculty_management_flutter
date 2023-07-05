import 'package:flutter/material.dart';

import '../../../../shared/components/components.dart';

class CourseRegisterModel {
late final String image;
late final String name;
late final String creaditHours;
late final String docName;

CourseRegisterModel({required this.image, required this.name,required this.creaditHours,required this.docName});
}

class CourseRegisterAvailableScreen extends StatelessWidget {

  final List<CourseRegisterModel> coursesRegister = [
    CourseRegisterModel(
        image: 'assets/images/oop.png',
        name: 'course Name',
        creaditHours: 'Credit Hours:5',
        docName: 'dr/Rasha montaser'

    ),
    CourseRegisterModel(
        image: 'assets/images/oop.png',
        name: 'course Name',
        creaditHours: 'Credit Hours:5',
        docName: 'dr/Rasha montaser'

    ),
    CourseRegisterModel(
        image: 'assets/images/oop.png',
        name: 'course Name',
        creaditHours: 'Credit Hours:5',
        docName: 'dr/Rasha montaser'

    ),
    CourseRegisterModel(
        image: 'assets/images/oop.png',
        name: 'course Name',
        creaditHours: 'Credit Hours:5',
        docName: 'dr/Rasha montaser'

    ),
    CourseRegisterModel(
        image: 'assets/images/oop.png',
        name: 'course Name',
        creaditHours: 'Credit Hours:5',
        docName: 'dr/Rasha montaser'

    ),
    CourseRegisterModel(
        image: 'assets/images/oop.png',
        name: 'course Name',
        creaditHours: 'Credit Hours:5',
        docName: 'dr/Rasha montaser'

    ),


  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.75,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,


      ),
      itemCount: coursesRegister.length,
      itemBuilder:(context,index){
        final coursesResgister = coursesRegister[index];
        return CourseRegisterItem(name: coursesResgister.name,image: coursesResgister.image, creditHours: coursesResgister.creaditHours , docName: coursesResgister.docName ,selected: false ,context: context);
      } ,

    );
  }
}
