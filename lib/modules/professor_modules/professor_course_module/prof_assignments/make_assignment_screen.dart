import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms_flutter/layout/professor_general/professor_general.dart';
import 'package:sms_flutter/modules/professor_modules/professor_course_module/prof_assignments/assignment_states.dart';
import 'package:sms_flutter/modules/professor_modules/professor_course_module/prof_assignments/assignments_cubit.dart';
import 'package:sms_flutter/modules/professor_modules/professor_course_module/prof_course_screen.dart';
import 'package:sms_flutter/modules/students_modules/courses/assignments.dart';
import 'package:sms_flutter/shared/components/components.dart';
import 'package:path/path.dart' as path;

class MakeAssignmentScreen extends StatelessWidget {
  final String? type;
  String? courseId;
  MakeAssignmentScreen({Key? key, this.type, this.courseId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
        appBar: projectAppBar(context),
        // drawer: ProfessorGeneral(),
        body: SingleChildScrollView(
          child: Center(
              child: isSmallScreen
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _Logo(),
                        FormContent(
                          courseId: courseId,
                        ),
                      ],
                    )
                  : Container(
                      padding: const EdgeInsets.all(32.0),
                      constraints: const BoxConstraints(maxWidth: 800),
                      child: Row(
                        children: [
                          Expanded(child: _Logo()),
                          Expanded(
                            child: Center(
                                child: FormContent(
                              courseId: courseId,
                            )),
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
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Assignments",
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
  String? courseId;

  FormContent({Key? key, this.courseId}) : super(key: key);

  @override
  State<FormContent> createState() => _FormContentState();
}

class _FormContentState extends State<FormContent> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController possiblePointsController = TextEditingController();
  // final TextEditingController descriptionController = TextEditingController();
  DateTime? dueDate;

  @override
  Widget build(BuildContext context) {
    String dropdownvalue = 'choose your course';

    return BlocProvider(
      create: (BuildContext context) => AssignmentCubit(),
      child: BlocConsumer<AssignmentCubit, AssignmentStates>(
        listener: (BuildContext context, Object? state) {
          if (state is ProfAddAssignmentSuccess) {
            navigateTo(context, AssignmentsScreen(type: 'Professor',id: widget.courseId,));
            Fluttertoast.showToast(
                msg: 'Assignment added successfully',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green[400],
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (state is ProfAddAssignmentError) {
            Fluttertoast.showToast(
                msg: 'error adding assignment',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red[400],
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (BuildContext context, state) {
          var assignmentCubit = AssignmentCubit.get(context);

          return Container(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Form(
              autovalidateMode: AutovalidateMode.disabled,
              key: assignmentCubit.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _gap(),
                  TextFormField(
                    controller: titleController,
                    validator: (value) {
// add email validation
                      if (value == null || value.isEmpty) {
                        return 'Please enter name';
                      }

                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Assignment name',
                      hintText: 'Enter Assignment name',
                      // prefixIcon: Icon(Icons.drive_file_rename_outline),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  _gap(),
                  TextFormField(
                    controller: descriptionController,
                    autocorrect: true,
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter assignment description';
                      }

                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Assignment description',
                      hintText: 'Enter your description',
// prefixIcon: Icon(Icons.account_circl),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  _gap(),
                  DateTimeFormField(
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black45),
                      errorStyle: TextStyle(color: Colors.red),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.event_note),
                      labelText: 'From date',
                    ),
                    mode: DateTimeFieldPickerMode.date,
                    autovalidateMode: AutovalidateMode.always,
                    validator: (e) =>
                        (e?.day ?? 0) == 0 ? 'Please choose date' : null,
                    onDateSelected: (DateTime value) {
                      print(value);
                    },
                  ),
                  _gap(),
                  DateTimeFormField(
                    decoration: const InputDecoration(
                      hintStyle: TextStyle(color: Colors.black45),
                      errorStyle: TextStyle(color: Colors.red),
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.event_note),
                      labelText: 'To date',
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
                  TextFormField(
                    controller: possiblePointsController,
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: (value) {
// add email validation
                      if (value == null || value.isEmpty) {
                        return 'Please enter points';
                      }

                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Possible points',
                      hintText: 'Enter possible points',
                      // prefixIcon: Icon(Icons.mark_chat_unread_rounded),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  _gap(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Attachment:',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            assignmentCubit.pickFile();
                            // openFile(file!);
                            // print('Name:${file.name}');
                            // print('Name:${file.bytes}');
                            // print('Name:${file.size}');
                            // print('Name:${file.extension}');
                            // print('Name:${file.path}');
                          },
                          icon: Icon(Icons.attachment_sharp)),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (assignmentCubit.file != null) ...[
                    InkWell(
                      onTap: () {
                        assignmentCubit.openFile(context);
                      },
                      child: Expanded(
                        child: Row(children: [
                          Icon(Icons.description),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              path.basename(assignmentCubit.file!.path),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  ],
                  _gap(),
                  SizedBox(
                    width: double.infinity,
                    child: ConditionalBuilder(
                      condition: state is! ProfAddAssignmentLoading,
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
                            if (await assignmentCubit.formKey.currentState
                                    ?.validate() ??
                                false)
                              // Navigator.pop(context);
                              assignmentCubit.addNewAssignment(
                                widget.courseId,
                                titleController.text,
                                descriptionController.text,
                                int.parse(possiblePointsController.text),
                                dueDate,
                                assignmentCubit.file!,
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
          );
        },
      ),
    );
  }

  Widget _gap() => const SizedBox(height: 12);
}
