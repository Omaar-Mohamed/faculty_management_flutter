import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sms_flutter/layout/professor_general/professor_general.dart';
import 'package:sms_flutter/layout/student_general/student_general.dart';
import 'package:sms_flutter/modules/students_modules/courses/course_cubit/course_cubit.dart';
import 'package:sms_flutter/modules/students_modules/courses/course_cubit/course_states.dart';
import 'package:sms_flutter/modules/students_modules/courses/course_details_screen.dart';
import 'package:sms_flutter/shared/components/components.dart';

import '../../professor_modules/professor_course_module/prof_assignments/make_assignment_screen.dart';
import 'assignment_detail_screen.dart';

class AssignmentsScreen extends StatefulWidget {
  final String? type;
  String? id;
  AssignmentsScreen({Key? key, this.type, this.id}) : super(key: key);

  @override
  State<AssignmentsScreen> createState() => _AssignmentsScreenState();
}

class _AssignmentsScreenState extends State<AssignmentsScreen> {
  final List<Map<String, String>> assignments = [
    {'name': 'Assignment 1', 'Due': 'Due Tomorrow'},
    {'name': 'Assignment 2', 'Due': 'Due Tomorrow'},
    {'name': 'Assignment 3', 'Due': 'Due Tomorrow'},
    {'name': 'Assignment 4', 'Due': 'Due Tomorrow'},
  ];
  Future<void> _refreshPage() async {
    // Simulate a delay for reloading the page
    await Future.delayed(Duration(seconds: 2));
navigateAndReplace(context, AssignmentsScreen(type: widget.type, id: widget.id));
    // setState(() {
    //   // Generate new data for the page
    //   items = List.generate(10, (index) => 'Item $index (Reloaded)');
    // });
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
          CourseCubit()..getStudentAssignmentsCourses(widget.id),
      child: BlocConsumer<CourseCubit, CourseStates>(
        listener: (BuildContext context, state) {
          if(state is ProfDeleteAssignmentSuccess){
            navigateAndReplace(context, AssignmentsScreen(type: widget.type, id: widget.id));
            Fluttertoast.showToast(msg: state.deleteAssignment!.data.toString(),toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.BOTTOM,backgroundColor: Colors.green,textColor: Colors.white,);
          }else if(state is ProfDeleteAssignmentError){
            Fluttertoast.showToast(msg: state.error!.toString(),toastLength: Toast.LENGTH_LONG,gravity: ToastGravity.BOTTOM,backgroundColor: Colors.red,textColor: Colors.white,);
          }

        },
        builder: (BuildContext context, Object? state) {
          var courseCubit = CourseCubit.get(context);
          return Scaffold(
              appBar: projectAppBar(context),
              drawer: widget.type == "student" ? StudentGeneral() : ProfessorGeneral(),
              body: RefreshIndicator(
                onRefresh: () { return _refreshPage(); },
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        'Assignments',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: widget.type == 'student'? ConditionalBuilder(
                        condition:
                            CourseCubit.get(context).assignmentsModel?.data !=
                                null,
                        builder: (BuildContext context) => ListView.builder(
                          itemCount: courseCubit
                              .assignmentsModel!.data!.length,
                          itemBuilder: (context, index) {
                            return SingleChildScrollView(
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16.0),
                                        topRight: Radius.circular(16.0),
                                      ),
                                      // child: Image.asset(
                                      //   assignments[index]['image']!,
                                      //   height: 120.0,
                                      //   width: double.infinity,
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      courseCubit
                                          .assignmentsModel!.data![index].name!,
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width * 0.05, // Adjust the multiplier as needed
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(courseCubit
                                          .assignmentsModel!.data![index].dueDate!),
                                      ),
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                navigateTo(
                                                    context,
                                                    AssignmentDetailsScreen(
                                                      type: widget.type,
                                                      id:widget.id,
                                                      assignmentId: courseCubit
                                                          .assignmentsModel!
                                                          .data![index].id.toString(),
                                                    ));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.blue,
                                              ),
                                              child: Text(
                                                'view Assignment',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                            ),
                                            widget.type == 'Professor'
                                                ? ElevatedButton(
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                            context) {
                                                          return AlertDialog(
                                                            title: Text(
                                                                'Delete File'),
                                                            content: Text(
                                                                'Are you sure you want to delete this file?'),
                                                            actions: [
                                                              TextButton(
                                                                onPressed: () {
                                                                  // Perform the delete operation
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(true);
                                                                },
                                                                child:
                                                                    Text('Yes'),
                                                              ),
                                                              TextButton(
                                                                onPressed: () {
                                                                  // Dismiss the dialog
                                                                  Navigator.of(
                                                                          context)
                                                                      .pop(false);
                                                                },
                                                                child: Text('No'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                      // navigateTo(context, AssignmentDetailsScreen());
                                                    },
                                                    style:
                                                        ElevatedButton.styleFrom(
                                                      primary: Colors.red,
                                                    ),
                                                    child: Text(
                                                      'Delete Assignment',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 18.0,
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        fallback: (BuildContext context) =>
                            Center(child: CircularProgressIndicator()),
                      )
                          :
                      ConditionalBuilder(
                        condition:
                        CourseCubit.get(context).profGetAssignment?.data !=
                            null,
                        builder: (BuildContext context) => ListView.builder(
                          itemCount: courseCubit
                              .profGetAssignment!.data!.length,
                          itemBuilder: (context, index) {
                            return SingleChildScrollView(
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16.0),
                                        topRight: Radius.circular(16.0),
                                      ),
                                      // child: Image.asset(
                                      //   assignments[index]['image']!,
                                      //   height: 120.0,
                                      //   width: double.infinity,
                                      //   fit: BoxFit.cover,
                                      // ),
                                    ),
                                    SizedBox(height: 10.0),
                                    Text(
                                      courseCubit
                                          .profGetAssignment!.data![index].name!,
                                      style: TextStyle(
                                        fontSize: MediaQuery.of(context).size.width * 0.05, // Adjust the multiplier as needed
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Text(
                                      DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(courseCubit
                                          .profGetAssignment!.data![index].dueDate!),
                                      ),
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                    SizedBox(height: 8.0),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            ElevatedButton(
                                              onPressed: () {
                                                navigateTo(
                                                    context,
                                                    AssignmentDetailsScreen(
                                                      type: widget.type,
                                                      id:widget.id,
                                                      assignmentId: courseCubit
                                                          .profGetAssignment!
                                                          .data![index].id.toString(),
                                                    ));
                                              },
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.blue,
                                              ),
                                              child: Text(
                                                'view Assignment',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                            ),
                                            widget.type == 'Professor'
                                                ? ElevatedButton(
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (BuildContext
                                                  context) {
                                                    return AlertDialog(
                                                      title: Text(
                                                          'Delete File'),
                                                      content: Text(
                                                          'Are you sure you want to delete this file?'),
                                                      actions: [
                                                        TextButton(
                                                          onPressed: () {
                                                            // Perform the delete operation
                                                            courseCubit.deleteAssignment(
                                                                widget.id,
                                                              courseCubit
                                                                  .profGetAssignment!
                                                                  .data![index]
                                                                  .id
                                                                  .toString(),
                                                            );
                                                            // Navigator.of(
                                                            //     context)
                                                            //     .pop(true);
                                                            navigateTo(context, AssignmentsScreen(id: widget.id,type: widget.type,));
                                                          },
                                                          child:
                                                          Text('Yes'),
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            // Dismiss the dialog
                                                            Navigator.of(
                                                                context)
                                                                .pop(false);
                                                          },
                                                          child: Text('No'),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                                // navigateTo(context, AssignmentDetailsScreen());
                                              },
                                              style:
                                              ElevatedButton.styleFrom(
                                                primary: Colors.red,
                                              ),
                                              child: Text(
                                                'Delete Assignment',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                            )
                                                : SizedBox(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                        fallback: (BuildContext context) =>
                            Center(child: CircularProgressIndicator()),
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: widget.type == 'Professor'
                  ? FloatingActionButton(
                      onPressed: () {
                        navigateTo(
                            context,
                            MakeAssignmentScreen(
                              type: widget.type,
                              courseId: widget.id,
                            ));
                      },
                      child: Icon(Icons.add),
                    )
                  : null);
        },
      ),
    );
  }
}
