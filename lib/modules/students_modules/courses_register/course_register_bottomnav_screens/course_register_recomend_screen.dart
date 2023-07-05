import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_flutter/modules/students_modules/courses/course_cubit/course_states.dart';
import 'package:sms_flutter/modules/students_modules/courses_register/course_register_cubit/course_register_cubit.dart';
import 'package:sms_flutter/modules/students_modules/courses_register/course_register_cubit/course_register_states.dart';

import '../../../../shared/components/components.dart';




class CourseRegisterRecomendScreen extends StatefulWidget {

  @override
  State<CourseRegisterRecomendScreen> createState() => _CourseRegisterRecomendScreenState();
}

class _CourseRegisterRecomendScreenState extends State<CourseRegisterRecomendScreen> {
  // void tapped()
  // {
  //   setState(() {
  //     isTapped=!isTapped;
  //   });
  // }

  void dispose() {
    // CourseRegisterCubit.get(context).submitCourseRegester(CourseRegisterCubit.get(context).selectedCourses);
    showMenu(
      context: context,
      position: RelativeRect.fill,
      items: [
        PopupMenuItem(
          child: Text('Item 1'),
          value: 'Item 1',
        ),
        PopupMenuItem(
          child: Text('Item 2'),
          value: 'Item 2',
        ),
        PopupMenuItem(
          child: Text('Item 3'),
          value: 'Item 3',
        ),
      ],
      elevation: 8.0,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) { return CourseRegisterCubit()..getStudentCoursesRegister(); },
      child: BlocConsumer<CourseRegisterCubit,CourseRegesterStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {
          var list= CourseRegisterCubit.get(context);
          var selectedList= CourseRegisterCubit.get(context).courseRegisterModel?.data?.where((element) => element.selected==true).toList();
          List<int?> idList = selectedList
              ?.where((element) => element.selected == true)
              .map((element) => element.id)
              .toList() ?? [];
          return ConditionalBuilder(
            condition: CourseRegisterCubit.get(context).courseRegisterModel?.data!=null,
            builder: (BuildContext context) => GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,


              ),
              itemCount: CourseRegisterCubit.get(context).courseRegisterModel?.data!.length,
              itemBuilder:(context,index){
                // final coursesResgister = coursesRegister[index];
                return CourseRegisterItem(
                    name: list.courseRegisterModel?.data![index].course![0].name ,
                    image: 'assets/images/oop.png', creditHours: list.courseRegisterModel?.data![index].course![0].creditHours.toString() ,
                    docName: list.courseRegisterModel?.data![index].course![0].cat,
                    selected: false,
                    context: context
                    ,courseID:list.courseRegisterModel?.data![index].id,
                  selectedList: idList,

                );
              } ,

            ),
            fallback: (BuildContext context) => Center(child: CircularProgressIndicator()),

          );
        },
      ),
    );
  }
}
