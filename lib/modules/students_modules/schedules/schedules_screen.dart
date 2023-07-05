import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:sms_flutter/layout/professor_general/professor_general.dart';
import 'package:sms_flutter/layout/student_general/student_general.dart';
import 'package:sms_flutter/modules/students_modules/schedules/shedules_cubit/schedules_cubit.dart';
import 'package:sms_flutter/modules/students_modules/schedules/shedules_cubit/schedules_states.dart';
import 'package:sms_flutter/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_flutter/shared/constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../models/student_drawer_sections/student_drawer_section.dart';
import '../../professor_modules/professor_schedule_module/prof_make_online_meeting_screen.dart';

class SchedulesScreen extends StatefulWidget {
  final String type;
  var currentPage;

  SchedulesScreen({Key? key, this.currentPage, required this.type})
      : super(key: key);

  @override
  State<SchedulesScreen> createState() => _SchedulesScreenState();
}

class _SchedulesScreenState extends State<SchedulesScreen> {
  // List<Map<String, dynamic>> weekDaysList = [
  //   {'dayName': 'Sa', 'dayNumber': 0},
  //   {'dayName': 'Su', 'dayNumber': 1},
  //   {'dayName': 'Mo', 'dayNumber': 2},
  //   {'dayName': 'Tu', 'dayNumber': 3},
  //   {'dayName': 'We', 'dayNumber': 4},
  //   {'dayName': 'Th', 'dayNumber': 5},
  //   {'dayName': 'Fr', 'dayNumber': 6},
  //
  // ];

  String getDayt1(String? day) {
    if (day != null && day.length == 6) {
      return day.substring(0, 3);
  } else if ( day != null && day.length == 7) {
      return day.substring(0, 3);
    } else if (day != null && day.length == 9) {
      return day.substring(0, 3);
    } else if (day != null && day.length == 8) {
      return day.substring(0, 3);
    } else {
      return '';
    }
  }

  // String getDayt2(String? day) {
  //   if (day != null && day.length == 6) {
  //     return day.substring( 4);
  //   } else if ( day != null && day.length == 7) {
  //     return day.substring( 4);
  //   } else if (day != null && day.length == 9) {
  //     return day.substring(6);
  //   } else if (day != null && day.length == 8) {
  //     return day.substring(5);
  //   } else {
  //     return '';
  //   }
  // }




  @override
  Widget build(BuildContext context) {
    int? index ;
    currentPage = DrawerSections.Schedules;
    return BlocProvider(
      create: (BuildContext context) => SchedulesCubit()..getMeetings(),
      child: BlocConsumer<SchedulesCubit, SchedulesStates>(
        listener: (BuildContext context, Object? state) {},
        builder: (BuildContext context, state) {
          var schedulesCubit = SchedulesCubit.get(context);
          bool hasCourse = schedulesCubit.courses.isNotEmpty;

          return Scaffold(
            appBar: projectAppBar(context),
            drawer: widget.type == 'student' ? StudentGeneral() : ProfessorGeneral(),
            body: widget.type == 'student'
                ? ConditionalBuilder(
                    condition: SchedulesCubit.get(context)
                            .studentSchedulesModel
                            ?.data! !=
                        null,
                    builder: (BuildContext context) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: SizedBox(
                            height: 50,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  schedulesCubit.days.length,
                                      (index) => GestureDetector(
                                    onTap: () {
                                      schedulesCubit.scroll(index);
                                      schedulesCubit.filterCoursesForDay(
                                        schedulesCubit.days[index]  ,);
                                    },
                                    child: Container(
                                      width: 45,
                                      height: 100,
                                      margin: EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: schedulesCubit.selectedIndex == index
                                            ? Colors.blueGrey[900]
                                            : Colors.white,
                                        border: Border.all(
                                          color: schedulesCubit.selectedIndex == index
                                              ? Colors.white
                                              : Colors.black,
                                          width: 1.0,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Center(
                                              child: Text(
                                                getDayt1(schedulesCubit.days[index]) ,
                                                style: TextStyle(
                                                  color: schedulesCubit.selectedIndex == index
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // Text(
                        //   schedulesCubit.schedulesModel!.data![0].dayName
                        //       .toString(),
                        //   style: TextStyle(fontSize: 20),
                        // ),
                        Expanded(
                          child:
                          hasCourse
                          ? ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount:
                            schedulesCubit.courses.length,
                            itemBuilder: (BuildContext context, int index) {
                              // final item = _items[_selectedIndex][index];
                              return Card(
                                // color: Colors.grey,
                                elevation: 10,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      // Expanded(child: ClipRRect(
                                      //   // child: Image(
                                      //   //   image: NetworkImage(element["thumbnailUrl"]),
                                      //   //   fit: BoxFit.cover,
                                      //   // ) ,
                                      //   borderRadius: BorderRadius.all(Radius.circular(5)),
                                      // )),
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Text(
                                                  // schedulesCubit
                                                  //     .schedulesModel!
                                                  //     .data![index]
                                                  //     .courseSemester![0]
                                                  //     .course![0]
                                                  //     .name!
                                                  //     .toString(),
                                                  schedulesCubit
                                                      .courses[index]
                                                  ['course_semester'][0]
                                                  ['course'][0]['name']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                  maxLines: 2,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .watch_later_outlined,
                                                      color: Colors.grey,
                                                      size: 16,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      child: Text(
                                                        'From'+ ' ' +
                                                            schedulesCubit.courses[index]
                                                            ['start']

                                                            +' ' +
                                                            'To' +' ' +
                                                            schedulesCubit.courses[index]
                                                            ['end'],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.calendar_today,
                                                      color: Colors.grey,
                                                      size: 16,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      child: Text(
                                                        schedulesCubit.courses[index]
                                                        ['day_name']
                                                        ,
                                                        // ${element['']}
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.link,
                                                      color: Colors.grey,
                                                      size: 16,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          if (schedulesCubit.courses[index]['link'] != null) {
                                                            launchUrl(schedulesCubit.courses[index]['link']!);
                                                          }
                                                        },
                                                        child: Text('Link: ${schedulesCubit.courses[index]['link'] ?? 'No links'}'),
                                                      ),

                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.location_on_sharp,
                                                      color: Colors.grey,
                                                      size: 16,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      child: Text(
                                                        schedulesCubit.courses[index]
                                                        ['location_name']
                                                        ,
                                                        // ${element['']}
                                                      ),
                                                      // ${element['']}
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .account_circle_sharp,
                                                      color: Colors.grey,
                                                      size: 16,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      child: Text('Number of students : '+
                                                          schedulesCubit.courses[index]
                                                          ['seats_reserved'].toString()
                                                        ,
                                                        // ${element['']}
                                                      ),
                                                      // ${element['']}
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.book,
                                                      color: Colors.grey,
                                                      size: 16,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      child: Text(
                                                          schedulesCubit.courses[index]
                                                          ['type']
                                                      ),
                                                      // ${element['']}
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .repeat_on,
                                                      color: Colors.grey,
                                                      size: 16,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      child: Text('Repetition : '+
                                                          schedulesCubit.courses[index]
                                                          ['repetition'].toString()
                                                        ,
                                                        // ${element['']}
                                                      ),
                                                      // ${element['']}
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                              : Center(
                            child: Text('No Meetings in this day'),
                          ),
                        ),
                      ],
                    ),
                    fallback: (context) =>
                        Center(child: CircularProgressIndicator()),
                  )
                : ConditionalBuilder(
                    condition:
                        SchedulesCubit.get(context).schedulesModel?.data! !=
                            null,
                    builder: (BuildContext context) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: SizedBox(
                            height: 50,
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  schedulesCubit.days.length,
                                      (index) => GestureDetector(
                                    onTap: () {
                                      schedulesCubit.scroll(index);
                                      schedulesCubit.filterCoursesForDay(
                                        schedulesCubit.days[index]  ,);
                                    },
                                    child: Container(
                                      width: 45,
                                      height: 100,
                                      margin: EdgeInsets.symmetric(horizontal: 10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: schedulesCubit.selectedIndex == index
                                            ? Colors.blueGrey[900]
                                            : Colors.white,
                                        border: Border.all(
                                          color: schedulesCubit.selectedIndex == index
                                              ? Colors.white
                                              : Colors.black,
                                          width: 1.0,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Center(
                                              child: Text(
                                                getDayt1(schedulesCubit.days[index]) ,
                                                style: TextStyle(
                                                  color: schedulesCubit.selectedIndex == index
                                                      ? Colors.white
                                                      : Colors.black,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        // Text(
                        //   schedulesCubit.schedulesModel!.data![0].dayName
                        //       .toString(),
                        //   style: TextStyle(fontSize: 20),
                        // ),
                        Expanded(
                          child:
                          hasCourse
                              ? ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount:
                            schedulesCubit.courses.length,
                            itemBuilder: (BuildContext context, int index) {
                              // final item = _items[_selectedIndex][index];
                              return Card(
                                // color: Colors.grey,
                                elevation: 10,
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      // Expanded(child: ClipRRect(
                                      //   // child: Image(
                                      //   //   image: NetworkImage(element["thumbnailUrl"]),
                                      //   //   fit: BoxFit.cover,
                                      //   // ) ,
                                      //   borderRadius: BorderRadius.all(Radius.circular(5)),
                                      // )),
                                      Expanded(
                                        flex: 5,
                                        child: Container(
                                          padding: EdgeInsets.only(bottom: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.center,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10, right: 10),
                                                child: Text(
                                                  // schedulesCubit
                                                  //     .schedulesModel!
                                                  //     .data![index]
                                                  //     .courseSemester![0]
                                                  //     .course![0]
                                                  //     .name!
                                                  //     .toString(),
                                                  schedulesCubit
                                                      .courses[index]
                                                  ['course_semester'][0]
                                                  ['course'][0]['name']
                                                      .toString(),
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                      FontWeight.bold),
                                                  maxLines: 2,
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .watch_later_outlined,
                                                      color: Colors.grey,
                                                      size: 16,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      child: Text(
                                                        'From'+ ' ' +
                                                            schedulesCubit.courses[index]
                                                            ['start']

                                                            +' ' +
                                                            'To' +' ' +
                                                            schedulesCubit.courses[index]
                                                            ['end'],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.calendar_today,
                                                      color: Colors.grey,
                                                      size: 16,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      child: Text(
                                                        schedulesCubit.courses[index]
                                                        ['day_name']
                                                        ,
                                                        // ${element['']}
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.link,
                                                      color: Colors.grey,
                                                      size: 16,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          if (schedulesCubit.courses[index]['link'] != null) {
                                                            launchUrl(schedulesCubit.courses[index]['link']!);
                                                          }
                                                        },
                                                        child: Text('Link: ${schedulesCubit.courses[index]['link'] ?? 'No links'}'),
                                                      ),

                                                    )
                                                  ],
                                                ),
                                              ),
                                              // Padding(
                                              //   padding: EdgeInsets.only(
                                              //       left: 10,
                                              //       right: 10,
                                              //       top: 5),
                                              //   child: Row(
                                              //     mainAxisSize:
                                              //     MainAxisSize.max,
                                              //     mainAxisAlignment:
                                              //     MainAxisAlignment.start,
                                              //     children: [
                                              //       Icon(
                                              //         Icons.location_on_sharp,
                                              //         color: Colors.grey,
                                              //         size: 16,
                                              //       ),
                                              //       Container(
                                              //         margin: EdgeInsets.only(
                                              //             left: 10),
                                              //         child: Text(
                                              //           schedulesCubit.courses[index]
                                              //           ['location_type']
                                              //           ,
                                              //           // ${element['']}
                                              //         ),
                                              //         // ${element['']}
                                              //       ),
                                              //     ],
                                              //   ),
                                              // ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.location_on_sharp,
                                                      color: Colors.grey,
                                                      size: 16,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      child: Text(
                                                        schedulesCubit.courses[index]
                                                        ['location_name']
                                                        ,
                                                        // ${element['']}
                                                      ),
                                                      // ${element['']}
                                                    ),
                                                  ],
                                                ),
                                              ),

                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .account_circle_sharp,
                                                      color: Colors.grey,
                                                      size: 16,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      child: Text('Number of students '+
                                                          schedulesCubit.courses[index]
                                                          ['seats_reserved'].toString()
                                                        ,
                                                        // ${element['']}
                                                      ),
                                                      // ${element['']}
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons.book,
                                                      color: Colors.grey,
                                                      size: 16,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      child: Text(
                                                          schedulesCubit.courses[index]
                                                          ['type']
                                                      ),
                                                      // ${element['']}
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .repeat_on,
                                                      color: Colors.grey,
                                                      size: 16,
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10),
                                                      child: Text('Repetition : '+
                                                          schedulesCubit.courses[index]
                                                          ['repetition'].toString()
                                                        ,
                                                        // ${element['']}
                                                      ),
                                                      // ${element['']}
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                              : Center(
                            child: Text('No Meetings in this day'),
                          ),
                        ),
                      ],
                    ),
                    fallback: (context) =>
                        Center(child: CircularProgressIndicator()),
                  ),
            floatingActionButton: widget.type == 'professor'
                ? FloatingActionButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfMakeOnlineMeeting()));
                    },
                    child: const Icon(Icons.add),
                  )
                : null,
          );
        },
      ),
    );
  }
}
