import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_flutter/modules/students_modules/courses_register/course_register_cubit/course_register_cubit.dart';
import 'package:sms_flutter/shared/components/components.dart';

import '../../../layout/student_general/student_general.dart';
import 'course_register_cubit/course_register_states.dart';

class CoursesRegisterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>CourseRegisterCubit()..getStudentCoursesRegister(),
      child: BlocConsumer<CourseRegisterCubit,CourseRegesterStates>(
        listener: (BuildContext context, Object? state) {  },
        builder: (BuildContext context, state) {
          var courseRegisterCubit=CourseRegisterCubit.get(context);
          // var selectedList= CourseRegisterCubit.get(context).courseRegisterModel?.data?.where((element) => element.selected==true).toList();
          // List<int?> idList = selectedList
          //     ?.where((element) => element.selected == true)
          //     .map((element) => element.id)
          //     .toList() ?? [];


          return Scaffold(
            appBar: projectAppBar(context),
            drawer: StudentGeneral(),
            body: courseRegisterCubit.Screens[courseRegisterCubit.currentIndex],

            bottomNavigationBar: BottomNavigationBar(
              items:courseRegisterCubit.bottomItems,
              currentIndex: courseRegisterCubit.currentIndex,
              onTap: (index)
              {
                courseRegisterCubit.changeBottomNavBar(index);
              }
              ,

            ),
          );
        },

      ),
    );
  }
}
