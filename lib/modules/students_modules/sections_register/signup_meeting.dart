import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms_flutter/layout/student_general/student_general.dart';
import 'package:sms_flutter/modules/students_modules/sections_register/meeting_cubit/meeting_cubit.dart';
import 'package:sms_flutter/modules/students_modules/sections_register/meeting_cubit/meeting_status.dart';
import 'package:sms_flutter/modules/students_modules/sections_register/meetings_register.dart';
import 'package:sms_flutter/shared/components/components.dart';

const List<String> list = <String>[
  '6 : 8 monday lab B',
  '6 : 8 monday lab B',
  '6 : 8 monday lab B',
  '6 : 8 monday lab B'
];

class SignupMeetingScreen extends StatefulWidget {
  // final String coursename;
  final int courseid;
  final String name;

  const SignupMeetingScreen({Key? key, required this.courseid,required this.name})
      : super(key: key);

  @override
  State<SignupMeetingScreen> createState() => _SignupMeetingScreenState();
}

class _SignupMeetingScreenState extends State<SignupMeetingScreen> {
  @override

  String? selectedRadioValue = '';

  String? userMeeting;
  String? selectedType;
  // List<dynamic?> lectureTypes = [];
  // List<dynamic?> sectionTypes = [];
  String? selectedLectureType;
  String? selectedSectionType;

  setSelectedRadio(String? value) {
    setState(() {
      selectedRadioValue = value;
    });
  }

  Widget build(BuildContext context) {




    return BlocProvider(
      create: (BuildContext context) =>
          MeetingsCubit()..signUpMeeting(widget.courseid),
      child: BlocConsumer<MeetingsCubit, MeetingsStates>(

        listener: (BuildContext context, Object? state) {
          if (state is PostMeetingsSuccessState) {
            navigateTo(context, MeetingsRegister(type: 'student',));
            Fluttertoast.showToast(
                msg: 'Meeting signed up successfully',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green[400],
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (state is PostMeetingsErrorState) {
            Fluttertoast.showToast(
                msg: 'error sign up meeting',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red[400],
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (BuildContext context, state) {
          var signmeetingCubit = MeetingsCubit.get(context);
         var lectureTypes= MeetingsCubit.get(context).signmeetingModel?.data?.where((element) =>
          element.type=="lecture").toList();
          List<String?> lectureList = lectureTypes
              ?.where((element) => element.type=="lecture")
              .map((element) => element.id.toString())               .toList() ?? [];
          var selectedMap = MeetingsCubit.get(context)
              .signmeetingModel?.data
              ?.fold<Map<String, dynamic>>(
            {},
                (Map<String, dynamic> map, element) {
              if (element.type == "lecture") {
                map[element.id.toString()] = {
                  "start":element.start,
                  "end":element.end,
                  'locationName':element.locationName,
                  'day_name':element.dayName,
                  'id':element.id,
                  'registered':element.registered,

                };
              }
              return map;
            },

          );
         var sectionTypes= MeetingsCubit.get(context).signmeetingModel?.data?.where((element) =>
          element.type=="section").toList();
          List<String?> sectionList = sectionTypes
              ?.where((element) => element.type=="section")
              .map((element) => element.id.toString())               .toList() ?? [];
          var selectedMap2 = MeetingsCubit.get(context)
              .signmeetingModel?.data
              ?.fold<Map<String, dynamic>>(
            {},
                (Map<String, dynamic> map, element) {
              if (element.type == "section") {
                map[element.id.toString()] = {
                  "start":element.start,
                  "end":element.end,
                  'locationName':element.locationName,
                  'day_name':element.dayName,
                  'id':element.id,
                  'registered':element.registered,

                };
              }
              return map;
            },

          );
          return Scaffold(
            appBar: projectAppBar(context),
            drawer: StudentGeneral(),
            body: ConditionalBuilder(
              condition:
                  MeetingsCubit.get(context).signmeetingModel?.data != null,
              builder: (BuildContext context) => Column(

                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                child:    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Course Name: ' + widget.name!,

                        style:TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ) ,
                          maxLines: 2,

                      ),
                    ),

                  ),

                  SizedBox(
                    height: 15,
                  ),
                  // Expanded(
                  //   child: Column(
                  //     children: [
                  //       ListView.builder(
                  //         shrinkWrap: true, // Add this line
                  //         itemCount:
                  //             signmeetingCubit.signmeetingModel!.data!.length,
                  //
                  //         itemBuilder: (BuildContext context, int index) {
                  //           signmeetingCubit.signmeetingModel!.data![index]
                  //               .toString();
                  //           return ListTile(
                  //             title: Text(signmeetingCubit.signmeetingModel!
                  //                     .data![0].registered!.lecture!.date!
                  //                     .toString() +
                  //                 '(' +
                  //                 signmeetingCubit.signmeetingModel!.data![0]
                  //                     .registered!.lecture!.start!
                  //                     .toString() +
                  //                 '-' +
                  //                 signmeetingCubit.signmeetingModel!.data![0]
                  //                     .registered!.lecture!.end!
                  //                     .toString() +
                  //                 ')' +
                  //                 signmeetingCubit.signmeetingModel!.data![0]
                  //                     .registered!.lecture!.locationType!
                  //                     .toString()),
                  //             subtitle: Text(
                  //               'Type' +
                  //                   signmeetingCubit.signmeetingModel!.data![0]
                  //                       .registered!.lecture!.type
                  //                       .toString() +
                  //                   'seat limit : ' +
                  //                   signmeetingCubit.signmeetingModel!.data![0]
                  //                       .registered!.lecture!
                  //                       .toString() +
                  //                   '/' +
                  //                   signmeetingCubit.signmeetingModel!.data![0]
                  //                       .registered!.lecture!
                  //                       .toString(),
                  //             ),
                  //             leading: Radio(
                  //               value: signmeetingCubit
                  //                   .signmeetingModel!.data![0]
                  //                   .toString(),
                  //               groupValue: selectedRadioValue,
                  //               onChanged: (value) {
                  //                 setState(() {
                  //                   // selectedRadioValue = value as String?;
                  //                 });
                  //               },
                  //             ),
                  //           );
                  //         },
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // DropdownButtonHideUnderline(
                  //   child: DropdownButton(
                  //     isExpanded: true,
                  //     hint: const Padding(
                  //       padding: EdgeInsets.all(8.0),
                  //       child: Text('Select Lecture Meeting'),
                  //     ),
                  //     value: userMeeting,
                  //     items:
                  //         signmeetingCubit.signmeetingModel?.data!.map((item) {
                  //       return DropdownMenuItem(
                  //         child: Text("From" +
                  //             " " +
                  //             "(" +
                  //             " " +
                  //             signmeetingCubit.signmeetingModel!.data![0].start!
                  //                 .toString()+' ' +
                  //             'To'+
                  //         " " +
                  //         "" +
                  //             "" ),
                  //         value: 'meeting',
                  //       );
                  //     }).toList(),
                  //     onChanged: (String? newValue) {
                  //       setState(() {
                  //         userMeeting = newValue;
                  //         print(userMeeting);
                  //       });
                  //     },
                  //   ),
                  // ),
    Text('Available Lectures : ',style: TextStyle(fontWeight: FontWeight.bold),),
    ListView.builder(
    shrinkWrap: true,
    itemCount: selectedMap?.length,
    itemBuilder: (context, index) {
      final entry = selectedMap?.entries.elementAt(index);     final key = entry?.key;     final value = entry?.value;

      final type = lectureList?[index];
    return Row(
    children: [
    Radio<String>(
    value: type!,
    groupValue: selectedLectureType,
    onChanged: (value) {
    setState(() {
      selectedLectureType= value;
    });
    },
    ),
      // Text(  signmeetingCubit.signmeetingModel!.data![0].dayName!
      //     .toString() +" "+"From" +
      //     " " +
      //     "(" +
      //     " " +
      //     signmeetingCubit.signmeetingModel!.data![0].start!
      //         .toString()+' ' +
      //     'To'+
      //     " " +
      //     signmeetingCubit.signmeetingModel!.data![0].end!
      //         .toString()+
      //     "" +
      //     ")"+" "+ signmeetingCubit.signmeetingModel!.data![0].locationName!
      //     .toString() ),
      Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Row(
          children: [
            Expanded(
              child: Text(
                (value?['day_name'] ?? '') +
                    " " +
                    "From" +
                    " " +
                    "(" +
                    " " +
                    (value?["start"] ?? '') +
                    ' ' +
                    'To' +
                    " " +
                    (value?["end"] ?? '') +
                    "" +
                    ")" +
                    " " +
                    (value?["locationName"] ?? ''),
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.028,
                ),
                // overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
            Icon(
              value?["registered"] == true
                  ? Icons.check_circle
                  : Icons.check_circle_outline,
              color: value?["registered"] == true ? Colors.green : Colors.grey,
            ),
          ],
        ),
      ),

    ],
    );
    },
    ),
    SizedBox(height: 16),
    Text('Available Sections :',style: TextStyle(fontWeight: FontWeight.bold),),
    ListView.builder(
    shrinkWrap: true,
    itemCount: selectedMap2?.length,
    itemBuilder: (context, index) {
    final type = sectionList?[index];
    final entry = selectedMap2?.entries.elementAt(index);     final key = entry?.key;     final value = entry?.value;

    return Row(
    children: [
    Radio<String>(
    value: type!,
    groupValue:  selectedSectionType,
    onChanged: (value) {
    setState(() {
    selectedSectionType = value;
    });
    },
    ),
      Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: Row(
          children: [
            Expanded(
              child: Text(
                (value?['day_name'] ?? '') +
                    " " +
                    "From" +
                    " " +
                    "(" +
                    " " +
                    (value?["start"] ?? '') +
                    ' ' +
                    'To' +
                    " " +
                    (value?["end"] ?? '') +
                    "" +
                    ")" +
                    " " +
                    (value?["locationName"] ?? ''),
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width * 0.028,
                ),
                // overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.01),
            Icon(
              value?["registered"] == true
                  ? Icons.check_circle
                  : Icons.check_circle_outline,
              color: value?["registered"] == true ? Colors.green : Colors.grey,
            ),
          ],
        ),
      ),
          ],
          );
          },
    ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 120),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 200,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Text(
                                    'Submit',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                onPressed: () {
                                  // if (_formKey.currentState?.validate() ?? false) {
                                  //   Navigator.push(context, MaterialPageRoute(builder: (context)=> RedirectSucc()));
signmeetingCubit.userPostMeeting(
  courseid:widget.courseid! ,
lecture: int.parse(selectedLectureType!),
section: int.parse(selectedSectionType!));
                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             MeetingsRegister()));
                                }),
                          ),
                        ],
                      ),
                    ),

              ),
                ],
              ),
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),
          );
        },
      ),
    );
  }
}
