// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sms_flutter/layout/student_general/student_cubit/student_states.dart';
// import 'package:sms_flutter/modules/students_modules/courses/courses_screen.dart';
// import 'package:sms_flutter/modules/students_modules/sections_register/meetings_register.dart';
// import 'package:sms_flutter/shared/components/components.dart';
//
// import '../../../models/student_drawer_sections/student_drawer_section.dart';
// import '../../../modules/logout/logout.dart';
// import '../../../modules/students_modules/Community/community_screen.dart';
// import '../../../modules/students_modules/courses_register/courses_register_screen.dart';
// import '../../../modules/students_modules/payment/payment_screen.dart';
// import '../../../modules/students_modules/reports/reports.dart';
// import '../../../modules/students_modules/schedules/schedules_screen.dart';
// import '../../../modules/students_modules/setting/setting_screen.dart';
//
// class StudentCubit extends Cubit<StudentStates> {
//   StudentCubit() : super(StudentInitialState());
//
//   static StudentCubit get(context) => BlocProvider.of(context);
//
//   var currentPage = DrawerSections.Courses;
//   // late var currentPage;
// // var C=Color(Colors.grey[300]);
//
//   Widget menuItem(int id, String title, IconData icon, bool selected,
//       BuildContext context) {
//     return Material(
//       child: InkWell(
//         onTap: () {
//           Navigator.pop(context);
//           if (id == 1) {
//             currentPage = DrawerSections.Schedules;
//             emit(ChangeDrawerSection());
//             navigateTo(context, SchedulesScreen());
//             emit(StudentInSchedualeState());
//           } else if (id == 2) {
//             currentPage = DrawerSections.Courses;
//             emit(ChangeDrawerSection());
//             navigateTo(context, CoursesScreen());
//             emit(StudentInCoursesState());
//           } else if (id == 3) {
//             currentPage = DrawerSections.Community;
//             emit(ChangeDrawerSection());
//             navigateTo(context, CommunityScreen());
//             emit(StudentInCommunityState());
//           } else if (id == 4) {
//             currentPage = DrawerSections.Reports;
//             emit(ChangeDrawerSection());
//             navigateTo(context, ReportsScreen());
//             emit(StudentInReportState());
//           } else if (id == 5) {
//             currentPage = DrawerSections.Courses_Register;
//             emit(ChangeDrawerSection());
//             navigateTo(context, CoursesRegisterScreen());
//             emit(StudentInCourseRegisterState());
//           } else if (id == 6) {
//             currentPage = DrawerSections.Section_Register;
//             emit(ChangeDrawerSection());
//             navigateTo(context, MeetingsRegister());
//             emit(StudentInMeetingsRegisterState());
//           } else if (id == 7) {
//             currentPage = DrawerSections.Payment;
//             emit(ChangeDrawerSection());
//             navigateTo(context, PaymentScreen());
//             emit(StudentInPaymentState());
//           } else if (id == 8) {
//             currentPage = DrawerSections.Settings;
//             emit(ChangeDrawerSection());
//             navigateTo(context, settingScreen());
//             emit(StudentInSettingsState());
//           } else if (id == 9) {
//             currentPage = DrawerSections.Logout;
//             emit(ChangeDrawerSection());
//             navigateTo(context, LogOutScreen());
//             emit(StudentInLogOutState());
//           }
//         },
//         child: Padding(
//           padding: EdgeInsets.all(15.0),
//           child: Container(
//             child: Row(
//               children: [
//                 Expanded(
//                   child: Icon(
//                     icon,
//                     size: 20,
//                     color: Colors.black,
//                   ),
//                 ),
//                 Expanded(
//                   flex: 3,
//                   child: Text(
//                     title,
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 16,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//       color: selected ? Colors.grey[300] : Colors.transparent,
//     );
//   }
//   // void changeDrawerSection(DrawerSections section,int id) {
//   //   emit(StudentChangeDrawerSectionState(section: DrawerSections.Schedules, currentPage: id));
//   // }
//   // Widget menuItem(int id, String title, IconData icon, bool selected, BuildContext context) {
//   //   return BlocBuilder<StudentCubit, StudentStates>(
//   //     builder: (context, state) {
//   //       return Material(
//   //         child: InkWell(
//   //           onTap: () {
//   //             Navigator.pop(context);
//   //             if (id == 1) {
//   //               context.read<StudentCubit>().changeDrawerSection(DrawerSections.Schedules,1);
//   //               navigateTo(context, SchedulesScreen());
//   //             } else if (id == 2) {
//   //               context.read<StudentCubit>().changeDrawerSection(DrawerSections.Courses,2);
//   //               navigateTo(context, CoursesScreen());
//   //             } else if (id == 3) {
//   //               context.read<StudentCubit>().changeDrawerSection(DrawerSections.Community,3);
//   //               navigateTo(context, CommunityScreen());
//   //             } else if (id == 4) {
//   //               context.read<StudentCubit>().changeDrawerSection(DrawerSections.Reports,4);
//   //               navigateTo(context, ReportsScreen());
//   //             } else if (id == 5) {
//   //               context.read<StudentCubit>().changeDrawerSection(DrawerSections.Courses_Register,5);
//   //               navigateTo(context, CoursesRegisterScreen());
//   //             } else if (id == 6) {
//   //               context.read<StudentCubit>().changeDrawerSection(DrawerSections.Section_Register,6);
//   //               navigateTo(context, MeetingsRegister());
//   //             } else if (id == 7) {
//   //               context.read<StudentCubit>().changeDrawerSection(DrawerSections.Payment,7);
//   //               navigateTo(context, PaymentScreen());
//   //             } else if (id == 8) {
//   //               context.read<StudentCubit>().changeDrawerSection(DrawerSections.Settings,8);
//   //               navigateTo(context, settingScreen());
//   //             } else if (id == 9) {
//   //               context.read<StudentCubit>().changeDrawerSection(DrawerSections.Logout,9);
//   //               navigateTo(context, LogOutScreen());
//   //             }
//   //           },
//   //           child: Padding(
//   //             padding: EdgeInsets.all(15.0),
//   //             child: Container(
//   //               // color: state is StudentChangeDrawerSectionState && state.currentPage == id ? Colors.grey[300] : Colors.transparent,
//   //               child: Row(
//   //                 children: [
//   //                   Expanded(
//   //                     child: Icon(
//   //                       icon,
//   //                       size: 20,
//   //                       color: Colors.black,
//   //                     ),
//   //                   ),
//   //                   Expanded(
//   //                     flex: 3,
//   //                     child: Text(
//   //                       title,
//   //                       style: TextStyle(
//   //                         color: Colors.black,
//   //                         fontSize: 16,
//   //                       ),
//   //                     ),
//   //                   ),
//   //                 ],
//   //               ),
//   //             ),
//   //           ),
//   //         ),
//   //         color: state is StudentChangeDrawerSectionState && state.currentPage == id ? Colors.grey[300] : Colors.transparent,
//   //
//   //       );
//   //     },
//   //   );
//   // }
//
//
//
//
// // Widget changeColor(currentPage,Color color) {
// //   if (currentPage == DrawerSections.Schedules) {
// //     color = Colors.grey[300]!;
// //     emit(ChangeDrawerColor());
// //   }
// //   return Container(color: color,);
// // }
//
//   Widget MyDrawerList(BuildContext context){
//     return Container(
//       padding: EdgeInsets.only(top: 15,),
//       child: Column(
//         children: [
//           menuItem(1, "Schedules", Icons.schedule,
//               currentPage == DrawerSections.Schedules ,context),
//           menuItem(2, "Courses", Icons.book_rounded,
//               currentPage == DrawerSections.Courses ,context),
//           menuItem(3, "Community", Icons.comment,
//               currentPage == DrawerSections.Community ,context),
//           menuItem(4, "Reports", Icons.report,
//               currentPage == DrawerSections.Reports ,context),
//           menuItem(5, "Courses Register", Icons.book_outlined,
//               currentPage == DrawerSections.Courses_Register,context),
//           menuItem(6, "Meetings Register", Icons.book_rounded,
//               currentPage == DrawerSections.Section_Register ,context),
//           menuItem(7, "Payment", Icons.monetization_on_outlined,
//               currentPage == DrawerSections.Payment ,context),
//           myDivider(),
//           menuItem(8, "Settings", Icons.settings,
//               currentPage == DrawerSections.Settings ,context),
//           menuItem(9, "Logout", Icons.logout,
//               currentPage == DrawerSections.Logout ,context),
//
//         ],
//       ),
//     );
//   }
//
//
//
// }
