import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_flutter/layout/login/login_cubit/login_cubit.dart';
import 'package:sms_flutter/layout/login/login_cubit/login_states.dart';
import 'package:sms_flutter/layout/professor_general/professor_general.dart';
import 'package:sms_flutter/layout/student_general/student_general.dart';
import 'package:sms_flutter/models/course_model/course_model.dart';
import 'package:sms_flutter/modules/students_modules/courses/course_cubit/course_cubit.dart';
import 'package:sms_flutter/modules/students_modules/courses/course_details_screen.dart';
import 'package:sms_flutter/shared/components/components.dart';

import '../../../models/student_drawer_sections/student_drawer_section.dart';
import '../../../shared/constants/constants.dart';
import '../../professor_modules/professor_course_module/prof_course_screen.dart';
import 'course_cubit/course_states.dart';

class CoursesScreen extends StatelessWidget {
  final String? type;
  CoursesScreen({Key? key, this.type }) : super(key: key);
  // final List<Map<String, String>> courses = [
  //   {'name': 'Course 1', 'image': 'assets/images/oop.png'},
  //   {'name': 'Course 2', 'image': 'assets/images/oop.png'},
  //   {'name': 'Course 3', 'image': 'assets/images/oop.png'},
  //   {'name': 'Course 4', 'image': 'assets/images/oop.png'},
  // ];
  @override
  Widget build(BuildContext context) {
    // currentPage = DrawerSections.Courses;
    return BlocProvider(
      create: (BuildContext context)=>CourseCubit()..getStudentCourses(),
      child: BlocConsumer<CourseCubit,CourseStates>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {
          var courseCubit=CourseCubit.get(context);
          return Scaffold(
            appBar: projectAppBar(context),
            drawer: type=="student"? StudentGeneral():ProfessorGeneral(),
            body: type =='student'? ConditionalBuilder(
                condition: CourseCubit.get(context).courseModel!.data !=null,
                builder: (context)=> ListView.builder(
                  itemCount: courseCubit.courseModel!.data!.length,
                  itemBuilder: (context, index) {

                    return InkWell(
                      onTap: ()
                      {
                        if(type=="student"){
                          navigateTo(context, CourseDetailScreen(type: type,id: courseCubit.courseModel!.data![index].id.toString(),courseName: courseCubit.courseModel!.data![index].course![0].name,));
                          courseId=courseCubit.courseModel!.data![index].id;
                        }else{
                          navigateTo(context, CourseDetailScreen(type: type,id: courseCubit.courseModel!.data![index].id.toString(),courseName: courseCubit.courseModel!.data![index].course![0].name));
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.all(16.0),
                        height: 200.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16.0),
                                topRight: Radius.circular(16.0),
                              ),
                              child: Image.asset(
                                'assets/images/oop.png',
                                height: 120.0,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Text(
                                courseCubit.courseModel!.data![index].course![0].name.toString(),
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
                fallback: (context)=>Center(child: CircularProgressIndicator()),
            ):ConditionalBuilder(
              condition: CourseCubit.get(context).profCourseModel?.data! !=null,
              builder: (context)=> ListView.builder(
                itemCount: courseCubit.profCourseModel!.data!.length,
                itemBuilder: (context, index) {

                  return InkWell(
                    onTap: ()
                    {
                      if(type=="student"){
                        navigateTo(context, CourseDetailScreen(
                          type: type,
                          id: courseCubit.courseModel!.data![index].id.toString(),
                          courseName: courseCubit.courseModel!.data![index].course![0].name,
                        ));
                      }else{
                        navigateTo(context, CourseDetailScreen(
                            type: type,
                            id: courseCubit.profCourseModel!.data![index].id.toString(),
                            courseName: courseCubit.profCourseModel!.data![index].course![0].name
                        ));
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.all(16.0),
                      height: 200.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16.0),
                              topRight: Radius.circular(16.0),
                            ),
                            child: Image.asset(
                              'assets/images/oop.png',
                              height: 120.0,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Text(
                              courseCubit.profCourseModel!.data![index].course![0].name.toString(),
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator()),
            ),




          );
        },

      ),
    );
  }
  // Widget courseBuilder(context,CourseModel courseModel)=>
  //
  //
  //    courseModel.data.course InkWell(
  //   onTap: ()
  //   {
  //     if(type=="student"){
  //       navigateTo(context, CourseDetailScreen(type: type,));
  //     }else{
  //       navigateTo(context, CourseDetailScreen(type: type,));
  //     }
  //   },
  //   child: Container(
  //     margin: EdgeInsets.all(16.0),
  //     height: 200.0,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(16.0),
  //       boxShadow: [
  //         BoxShadow(
  //           color: Colors.grey.withOpacity(0.3),
  //           offset: Offset(0, 3),
  //         ),
  //       ],
  //     ),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         ClipRRect(
  //           borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(16.0),
  //             topRight: Radius.circular(16.0),
  //           ),
  //           child: Image.asset(
  //             courses[index]['image']!,
  //             height: 120.0,
  //             width: double.infinity,
  //             fit: BoxFit.cover,
  //           ),
  //         ),
  //         Padding(
  //           padding: EdgeInsets.all(16.0),
  //           child: Text(
  //             courses[index]['name']!,
  //             style: TextStyle(
  //               fontSize: 20.0,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   ),
  // );
}
