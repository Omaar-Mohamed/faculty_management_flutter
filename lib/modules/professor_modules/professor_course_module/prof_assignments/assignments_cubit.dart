import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sms_flutter/modules/professor_modules/professor_course_module/prof_assignments/assignment_states.dart';
import 'package:open_file/open_file.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';
import 'package:sms_flutter/shared/constants/constants.dart';

import '../../../../models/course_model/SubmitAssignment.dart';
import '../../../../models/course_model/prof_add_assignment.dart';
import '../../../../shared/network/remote/dio_helper.dart';
class AssignmentCubit extends  Cubit<AssignmentStates>{
  AssignmentCubit() : super(AssignmentInitialState());

  static AssignmentCubit get(context) => BlocProvider.of(context);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  File? file;

  Future<void> pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final path = result.files.single.path!;
      file = File(path);
      emit(AssignmentUploadState());
    }
  }

  void openFile(BuildContext context) {
    if (file != null) {
      OpenFile.open(file!.path);
    }
  }
  PlatformFile? pickedFile;
  Future selectFile()async{
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if(result==null)return;
    pickedFile= result.files.first;
    emit(AssignmentOpenState());

  }
  ProfAddAssignment? profAddAssignment;
  void addNewAssignment(
      String? courseId,
      String title,
      String description,
      int? point,
      DateTime? date,
      File? file,
      ) async {
    emit(ProfAddAssignmentLoading());

    try {
      String formattedDate = DateFormat('yyyy-MM-dd').format(date!);

      FormData formData = FormData.fromMap({
        'title': title,
        'description': description,
        'points': point,
        'due_date': formattedDate,
        'files[]': await MultipartFile.fromFile(
          file!.path,
          filename: file.path.split('/').last,
        ),
      });

      Response? response = await DioHelper.postFile(
        url: 'professor/courses/$courseId/assignments/add',
        data: formData,
        token: token,
      );

      if (response != null) {
        print(response.data.toString());
        profAddAssignment = ProfAddAssignment.fromJson(response.data);
        emit(ProfAddAssignmentSuccess(profAddAssignment!));
      } else {
        emit(ProfAddAssignmentError('Something went wrong, please try again'));
      }
    } catch (error) {
      print(error.toString());
      emit(ProfAddAssignmentError('Something went wrong, please try again'));
    }
  }



}