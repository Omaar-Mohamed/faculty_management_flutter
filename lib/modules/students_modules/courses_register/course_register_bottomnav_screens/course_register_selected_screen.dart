import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_flutter/modules/students_modules/courses_register/course_register_cubit/course_register_cubit.dart';
import 'package:sms_flutter/modules/students_modules/courses_register/course_register_cubit/course_register_states.dart';

import '../../../../shared/components/components.dart';

class CourseRegisterModel {
  late final String image;
  late final String name;
  late final String creaditHours;
  late final String docName;

  CourseRegisterModel({required this.image, required this.name,required this.creaditHours,required this.docName});
}

class CourseRegisterSelectedScreen extends StatelessWidget {

  final List<CourseRegisterModel> coursesRegister = [
    CourseRegisterModel(
        image: 'assets/images/oop.png',
        name: 'course Name',
        creaditHours: 'Credit Hours:5',
        docName: 'dr/Rasha montaser'

    ),


  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) { return CourseRegisterCubit()..getStudentCoursesRegister(); },
      child: BlocConsumer<CourseRegisterCubit,CourseRegesterStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {
          var selectedList= CourseRegisterCubit.get(context).courseRegisterModel?.data?.where((element) => element.selected==true).toList();
          List<int?> idList = selectedList
              ?.where((element) => element.selected == true)
              .map((element) => element.id)
              .toList() ?? [];
          return ConditionalBuilder(
            condition: selectedList!=null,
            builder: (BuildContext context){
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,


                ),
                itemCount: selectedList?.length,
                itemBuilder:(context,index){
                  // final coursesResgister = coursesRegister[index];
                  return CourseRegisterItem(
                      name: selectedList![index].course![0].name,
                      image: 'assets/images/oop.png',
                      creditHours: selectedList[index].course![0].creditHours.toString(),
                      docName: selectedList[index].course![0].cat,
                      selected: true,
                      courseID: selectedList[index].id,
                      selectedList: idList,
                      context: context
                  );
                } ,

              );
            },
            fallback: (BuildContext context) => Center(child: CircularProgressIndicator()),

          );
        },

      ),
    );
  }
}
