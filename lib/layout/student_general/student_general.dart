import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_flutter/layout/my_header_drawer/my_header_drawer.dart';
import 'package:sms_flutter/layout/student_general/student_cubit/student_cubit.dart';
import 'package:sms_flutter/layout/student_general/student_cubit/student_states.dart';
import 'package:sms_flutter/modules/students_modules/Community/community_screen.dart';
import 'package:sms_flutter/modules/students_modules/courses_register/courses_register_screen.dart';
import 'package:sms_flutter/modules/students_modules/payment/payment_screen.dart';
import 'package:sms_flutter/modules/students_modules/reports/reports.dart';
import 'package:sms_flutter/modules/students_modules/schedules/schedules_screen.dart';
import 'package:sms_flutter/shared/components/components.dart';

import '../../models/student_drawer_sections/student_drawer_section.dart';
import '../../modules/logout/logout.dart';
import '../../modules/students_modules/courses/courses_screen.dart';
import '../../modules/students_modules/setting/setting_screen.dart';
import '../login/login_cubit/login_cubit.dart';
import '../login/login_cubit/login_states.dart';

class StudentGeneral extends StatelessWidget {
  // var currentPage = DrawerSections.Schedules;
  // var container;
  @override
  Widget build(BuildContext context) {
    // if (currentPage == DrawerSections.Schedules) {
    //   container = SchedulesScreen();
    // } else if (currentPage == DrawerSections.Courses) {
    //   container = CoursesScreen();
    // } else if (currentPage == DrawerSections.Community) {
    //   container = CommunityScreen();
    // } else if (currentPage == DrawerSections.Reports) {
    //   container = ReportsScreen();
    // } else if (currentPage == DrawerSections.Courses_Register) {
    //   container = CoursesRegisterScreen();
    // } else if (currentPage == DrawerSections.Section_Register) {
    //   container = SectionRegisterScreen();
    // } else if (currentPage == DrawerSections.Payment) {
    //   container = PaymentScreen();
    // }else if (currentPage == DrawerSections.Settings) {
    //   container = settingScreen();
    // }else if (currentPage == DrawerSections.Logout) {
    //   container = LogOutScreen();
    // }

    return BlocProvider(
      create: (BuildContext context)=>LoginCubit(),
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context,state)
        {
          return Drawer(
            child: SingleChildScrollView(
              child: Container(
                child: Column(
                  children: [
                    MyHeaderDrawer(type: 'student',),
                    LoginCubit().StudentDrawerList(context),
                  ],
                ),
              ),
            ),
          );
        },

      ),
    ) ;


  }



}





