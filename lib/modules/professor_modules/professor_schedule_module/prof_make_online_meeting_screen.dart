import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:sms_flutter/layout/professor_general/professor_general.dart';
import 'package:sms_flutter/layout/student_general/student_general.dart';
import 'package:sms_flutter/modules/professor_modules/professor_schedule_module/prof_schedule_screen.dart';
import 'package:flutter/services.dart';
import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:sms_flutter/modules/students_modules/schedules/schedules_screen.dart';
import 'package:sms_flutter/modules/students_modules/schedules/shedules_cubit/schedules_cubit.dart';
import 'package:sms_flutter/modules/students_modules/schedules/shedules_cubit/schedules_states.dart';
import 'package:sms_flutter/modules/students_modules/sections_register/signup_meeting.dart';
import 'package:sms_flutter/shared/components/components.dart';
import 'package:dropdown_button2/dropdown_button2.dart';



class ProfMakeOnlineMeeting extends StatefulWidget {
  const ProfMakeOnlineMeeting({Key? key}) : super(key: key);

  @override
  State<ProfMakeOnlineMeeting> createState() => _ProfMakeOnlineMeetingState();
}

class _ProfMakeOnlineMeetingState extends State<ProfMakeOnlineMeeting> {
  @override
  Widget build(BuildContext context) {

    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
        appBar: projectAppBar(context),
        drawer: ProfessorGeneral(),
        body: SingleChildScrollView(
          child: Center(
              child: isSmallScreen
                  ? Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // _Logo(),
                  FormContent(),
                ],
              )
                  : Container(
                padding: const EdgeInsets.all(32.0),
                constraints: const BoxConstraints(maxWidth: 800),
                child: Row(
                  children: const [
                    Expanded(child: _Logo()),
                    Expanded(
                      child: Center(child: FormContent()),
                    ),
                  ],
                ),
              )),
        ));
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FlutterLogo(size: isSmallScreen ? 100 : 200),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Make Online Meeting",
            textAlign: TextAlign.center,
            style: isSmallScreen
                ? Theme.of(context).textTheme.headline5
                : Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: Colors.black),
          ),
        )
      ],
    );
  }
}

class FormContent extends StatefulWidget {

  const FormContent({Key? key}) : super(key: key);

  @override
  State<FormContent> createState() => _FormContentState();
}

class _FormContentState extends State<FormContent> {
  String? userId;
  int? weeksDay;



  final TextEditingController dayController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  final TextEditingController course_sem_idController = TextEditingController();
  DateTime? dueDate;
DateTime? start;
DateTime? end;
  List<Map<String, dynamic>> weekDaysList = [
    {'dayName': 'Saturday', 'dayNumber': 0},
    {'dayName': 'Sunday', 'dayNumber': 1},
    {'dayName': 'Monday', 'dayNumber': 2},
    {'dayName': 'Tuesday', 'dayNumber': 3},
    {'dayName': 'Wednesday', 'dayNumber': 4},
    {'dayName': 'Thursday', 'dayNumber': 5},
    {'dayName': 'Friday', 'dayNumber': 6},

  ];

  @override
  Widget build(BuildContext context) {
    String dropdownvalue = 'choose your course';

    return BlocProvider(
      create: (BuildContext context)=>SchedulesCubit()..getCoursesProf(),
      child: BlocConsumer<SchedulesCubit,SchedulesStates>(
        listener: (BuildContext context, Object? state) {
          if (state is PostMeetingSuccessState) {
            navigateTo(context, SchedulesScreen(type: 'professor',));
            Fluttertoast.showToast(
                msg: state.postOnlineMeetingModel!.message!,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green[400],
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (state is PostMeetingErrorState) {
            Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red[400],
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (BuildContext context , state){
          var onlineCubit=SchedulesCubit.get(context);

          return Container(
            constraints: const BoxConstraints(maxWidth: 300),
            child: ConditionalBuilder(
              condition: SchedulesCubit.get(context).profCourseModel?.data !=null,
              fallback: (context)=>Center(child: CircularProgressIndicator()),
              builder: (context)=>     Form(
                key: onlineCubit.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _gap(),
//                   Container(
// // width: 80.0,
// // height: 20.0,
//                     child:     DropdownButtonHideUnderline(
//                       child: DropdownButton(
//                         isExpanded: true,
//                         hint: const Padding(
//                           padding: EdgeInsets.all(8.0),
//                           child: Text('Select Item'),
//                         ),
//                         value: userId,
//                         items: reportCubit.catModel!.data!.map((item) {
//                           return DropdownMenuItem(
//                             child: Text(item.name.toString()),
//                             value: item.id.toString(),
//                           );
//                         }).toList(),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             userId = newValue;
//                             print(userId);
//                           });
//                         },
//                       ),
//                     ),
//                   ),

                    _gap(),
                    TextFormField(
                      controller: linkController,
                      validator: (value) {
// add email validation
                        if (value == null || value.isEmpty) {
                          return 'Please enter zoom link';
                        }


                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Zoom Link',
                        hintText: 'Enter Zoom Link',
                        prefixIcon: Icon(Icons.link),
                        border: OutlineInputBorder(),
                      ),
                    ),

                    _gap(),
//                     TextFormField(
//                       controller: dayController,
//                       validator: (value) {
// // add email validation
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter day';
//                         }
//
//
//                         return null;
//                       },
//                       decoration: const InputDecoration(
//                         labelText: 'Day',
//                         hintText: 'Enter day',
//                         prefixIcon: Icon(Icons.calendar_view_day),
//                         border: OutlineInputBorder(),
//                       ),
//                     ),
//
//                     _gap(),
//                   TextFormField(
//                     controller: course_sem_idController,
//                     validator: (value) {
// // add email validation
//                       if (value == null || value.isEmpty) {
//                         return 'Please enter course semester id';
//                       }
//
//
//                       return null;
//                     },
//                     decoration: const InputDecoration(
//                       labelText: 'course',
//                       hintText: 'Enter course semester id',
//                       prefixIcon: Icon(Icons.file_copy),
//                       border: OutlineInputBorder(),
//                     ),
//                   ),

                  // DropdownButtonHideUnderline(
                  //   child: DropdownButton<int>(
                  //     isExpanded: true,
                  //     hint: const Padding(
                  //       padding: EdgeInsets.all(8.0),
                  //       child: Text('Select Day'),
                  //     ),
                  //     value: weeksDay,
                  //     items: weekDaysList.map((item) {
                  //       String dayName = item['dayName'];
                  //       int dayNumber = item['dayNumber'];
                  //
                  //       return DropdownMenuItem<int>(
                  //         child: Text('$dayName '),
                  //         value: dayNumber,
                  //       );
                  //     }).toList(),
                  //     onChanged: (int? newValue) {
                  //       setState(() {
                  //         weeksDay = newValue;
                  //         print('Selected day: $weeksDay');
                  //       });
                  //     },
                  //   ),
                  // ),


                  _gap(),
                    DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isExpanded: true,
                        hint: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Select Course'),
                        ),
                        value: userId,
                        items: onlineCubit.profCourseModel?.data!.map((item) {
                          return DropdownMenuItem(
                            child: Text(item.course![0].name!.toString()),
                            value: item.id!.toString(),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            userId = newValue;
                            print(userId);
                          });
                        },
                      ),
                    ),
                    _gap(),
                    DateTimeFormField(
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.red),
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.event_note),
                        labelText: 'from',
                      ),
                      mode: DateTimeFieldPickerMode.time,
                      autovalidateMode: AutovalidateMode.always,
                      validator: (e) => (e?.day ?? 0) == 0 ? 'Please choose time' : null,
                      onDateSelected: (DateTime value) {
                        print(value);
                        start=value;
                      },
                    ),


                    _gap(),
                    DateTimeFormField(
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.red),
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.event_note),
                        labelText: 'to',
                      ),
                      mode: DateTimeFieldPickerMode.time,
                      autovalidateMode: AutovalidateMode.always,
                      validator: (e) => (e?.day ?? 0) == 0 ? 'Please choose time' : null,
                      onDateSelected: (DateTime value) {
                        print(value);
                        end=value;
                      },
                    ),

                    _gap(),
                    DateTimeFormField(
                      decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.black45),
                        errorStyle: TextStyle(color: Colors.red),
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.event_note),
                        labelText: 'date',
                      ),
                      mode: DateTimeFieldPickerMode.date,
                      autovalidateMode: AutovalidateMode.always,
                      validator: (e) =>
                      (e?.day ?? 0) == 0 ? 'Please choose date' : null,
                      onDateSelected: (DateTime value) {
                        print(value);
                        dueDate = value;
                      },
                    ),


                    _gap(),

                    _gap(),
                    SizedBox(
                      width: double.infinity,
                      child: ConditionalBuilder(
                        condition: state is! PostMeetingLoadingState,
                        builder: (BuildContext context) {
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                'Submit',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                            onPressed: () async {
                              if (await onlineCubit.formKey.currentState
                                  ?.validate() ??
                                  false)
                                // Navigator.pop(context);
                                print('start =$start'+'end =$end');
                              onlineCubit.PostOnlineMeeting(
                                int.parse(userId!) ,
                                // int.parse(course_sem_idController.text),
                                linkController.text,
                               // weeksDay!,
                                start,
                                end,
                                dueDate,
                              );
                            },
                          );
                        },
                        fallback: (BuildContext context) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

            ),
          );

        },
      ),
    );

  }

  Widget _gap() => const SizedBox(height: 16);
}
