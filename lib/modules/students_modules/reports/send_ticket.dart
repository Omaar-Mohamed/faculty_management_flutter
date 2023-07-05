import 'dart:developer';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms_flutter/layout/student_general/student_general.dart';
import 'package:sms_flutter/models/course_model/assignment_detail_model.dart';
import 'package:sms_flutter/modules/login/code_screen.dart';
import 'package:sms_flutter/modules/students_modules/reports/redirect_succ.dart';
import 'package:sms_flutter/modules/students_modules/reports/report_cubit/report_cubit.dart';
import 'package:sms_flutter/modules/students_modules/reports/report_cubit/report_states.dart';
import 'package:sms_flutter/modules/students_modules/reports/reports.dart';
import 'package:sms_flutter/shared/components/components.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import 'package:confirm_dialog/confirm_dialog.dart';

class SendTicketScreen extends StatefulWidget {
 final  String? type ;
 const  SendTicketScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<SendTicketScreen> createState() => _SendTicketScreen();
}

class _SendTicketScreen extends State<SendTicketScreen> {
  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;
    // String dropdownValue = list.first;

    return Scaffold(
        appBar: projectAppBar(context),
        // drawer: StudentGeneral(),
        body: SingleChildScrollView(
          child: Center(
              child: isSmallScreen
                  ? Column(
                children:  [
                  Image(
                    image: AssetImage('assets/images/report.png'),
                    height: 100.0,
                    width: 100.0,
                  ),
                  Text(
                    'General Report',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  FormContent(type: widget.type),
                ],
              )
                  : Container(
                padding: const EdgeInsets.all(32.0),
                constraints: const BoxConstraints(maxWidth: 800),
                child: Row(
                  children: [
                    Expanded(child: _Logo()),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Center(child: FormContent(type: widget.type)),
                      ),
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
        // FlutterLogo(size: isSmallScreen ? 100 : 200),
        Padding(
          padding: const EdgeInsets.all(16.0),
        )
      ],
    );
  }
}

class FormContent extends StatefulWidget {
 final String? type ;

  const FormContent({Key? key,required this.type}) : super(key: key);

  @override
  State<FormContent> createState() => _FormContentState();
}

class _FormContentState extends State<FormContent> {
  var va1;
  String? userId;

  @override
  Widget build(BuildContext context) {
    // String dropdownvalue = 'choose your report type';
    // String? selectedValue = 'Option 1';
    String? selecteditem='Select Item';


    return BlocProvider(
      create: (BuildContext context) => ReportCubit()..getTicketCat(),
      child: BlocConsumer<ReportCubit, ReportStates>(
        listener: (BuildContext context, Object? state) {
          if(state is CreateTicketSuccessState){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ReportsScreen(type: widget.type,)));
            Fluttertoast.showToast(
                msg: 'CreateTicket ${state.createModel!.status.toString()}',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
          else if (state is CreateTicketErrorState) {
            // showToast(text: state.error, state: ToastStates.ERROR);
          //   Fluttertoast.showToast(
          //       msg: 'w',
          //       toastLength: Toast.LENGTH_SHORT,
          //       gravity: ToastGravity.BOTTOM,
          //       timeInSecForIosWeb: 5,
          //       backgroundColor: Colors.red,
          //       textColor: Colors.white,
          //       fontSize: 16.0
          //   );
          // }
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ReportsScreen(type: widget.type,)));
            Fluttertoast.showToast(
                msg: 'Create Ticket Success',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }

        },
        builder: (BuildContext context, state) {
          var reportCubit = ReportCubit.get(context);

          return ConditionalBuilder(
            condition: ReportCubit.get(context).catModel!.data !=null,

            builder: (BuildContext context) =>   Container(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Form(
                key: reportCubit.formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: reportCubit.titleController,
                        autocorrect: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter title ';
                          }

// bool IdValid = RegExp(
//     r"^[0-9]")
//     .hasMatch(value);
// if (!IdValid) {
//   return 'Please enter a valid Id';
// }

                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Title',
                          hintText: 'Enter your ticket title',
// prefixIcon: Icon(Icons.account_circl),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    _gap(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: reportCubit.descriptionController,
                        autocorrect: true,
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your problem';
                          }

// bool IdValid = RegExp(
//     r"^[0-9]")
//     .hasMatch(value);
// if (!IdValid) {
//   return 'Please enter a valid Id';
// }

                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Problem',
                          hintText: 'Enter your problem',
// prefixIcon: Icon(Icons.account_circl),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    _gap(),
//           Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             child:             DropdownButtonHideUnderline(
//               child: DropdownButton(
//                 isExpanded: true,
//                 hint: const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Text('Select Item'),
//                 ),
//                 value: userId,
//                 items:reportCubit.catModel!.data!.map((item) {
//                   return DropdownMenuItem(
//                     child: Text(item.name.toString()),
//                     value: item.id.toString(),
//                   );
//                 }).toList(),
//                 onChanged: (String? newValue) {
//                   setState(() {
//                     userId = newValue;
//                     print(userId);
//                   });
//                 },
//               ),
//             ),
//
// // width: 80.0,
// // height: 20.0,
//
//
//
//
//
//           //   DropdownButton<String>(
//           //   value: selectedValue,
//           //   onChanged: (String? newValue) {
//           //     setState(() {
//           //       selectedValue = newValue;
//           //     });
//           //   },
//           //   items: catData?.map((String? value) {
//           //     return DropdownMenuItem<String>(
//           //       value: value,
//           //       child: Text(value ?? ''),
//           //     );
//           //   }).toList() ?? [],
//           // ),
//
//
// //             // reportCubit.dropdown2(reportCubit.catModel!.data!);
// //           },
// //           ),
//           ),
//           ),
                    DropdownButtonHideUnderline(
                      child: DropdownButton(
                        isExpanded: true,
                        hint: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Select Item'),
                        ),
                        value: userId,
                        items: reportCubit.catModel!.data!.map((item) {
                          return DropdownMenuItem(
                            child: Text(item.name.toString()),
                            value: item.id.toString(),
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

                    // DropdownButton<String>(
                    //
                    //   value: reportCubit.catModel!.data![0].name,
                    //
                    //   icon: const Icon(Icons.arrow_downward),
                    //   elevation: 16,
                    //   style: const TextStyle(color: Colors.deepPurple),
                    //   underline: Container(
                    //     height: 2,
                    //     color: Colors.deepPurpleAccent,
                    //   ),
                    //   onChanged: ( value) {
                    //     // This is called when the user selects an item.
                    //     setState(() {
                    //       reportCubit.catModel!.data![0].name = value!;
                    //       print(value);
                    //
                    //     });
                    //   },
                    //   items: reportCubit.catModel!.data!.map<DropdownMenuItem<String>>(( value) {
                    //     return DropdownMenuItem<String>(
                    //       value: value.name,
                    //       child: Text(value.name!),
                    //     );
                    //   }).toList(),
                    // ),
                    _gap(),
                    _gap(),
//                     SizedBox(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(4)),
//                         ),
//                         child: const Padding(
//                           padding: EdgeInsets.all(10.0),
//                           child: Text(
//                             'Make Report',
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                         onPressed: () async {
//                           if (await reportCubit.formKey.currentState
//                               ?.validate() ??
//                               false)
//
// //
// //   // Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfScheduleScreen()));
//                             if (await confirm(
//                               context,
//                               title: const Text('Confirm'),
//                               content: const Text('Would you like to make report'),
//                               textOK: const Text('Yes'),
//                               textCancel: const Text('No'),
//                             )) {
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => RedirectSucc()));
//                             }
// // Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfMakeOnlineMeeting()));
//                         },
//                       ),
//                     ),
                    SizedBox(
                      width: double.infinity,
                      child: ConditionalBuilder(
                        condition: state is! CreateTicketLoadingState,
                        builder:(context)=>ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2)),
                          ),
                          child: Text(
                            'Make report',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            if (reportCubit.formKey.currentState?.validate() ?? false) {
                              reportCubit.SubmitTicket(
                                cat_id:  userId!,
                                description:reportCubit.descriptionController.text,
                                title: reportCubit.titleController.text,
                                // id: idCubit.idController.text,


                              );
                              // // Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentGeneral()));
                              // LoginCubit.get(context).userLogin(
                              //   email: emailController.text,
                              //   password: passwordController.text,
                              // );
                              // reportCubit.SubmitTicket(
                              //   category:va1! ,
                              //     description:reportCubit.descriptionController.text,
                              //    title: reportCubit.titleController.text,
                              //    // id: idCubit.idController.text,
                              //
                              //
                              // );


                            }
                          },
                        ),
                        fallback: (context)=>Center(child: CircularProgressIndicator()) ,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator()),

          );
        },
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}