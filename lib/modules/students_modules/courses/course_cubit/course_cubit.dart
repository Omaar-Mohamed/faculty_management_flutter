import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms_flutter/models/course_model/SubmitAssignment.dart';
import 'package:sms_flutter/models/course_model/assignments_model.dart';
import 'package:sms_flutter/models/course_model/course_model.dart';
import 'package:sms_flutter/models/course_model/delete_assignment.dart';
import 'package:sms_flutter/models/course_model/get_tags_model.dart';
import 'package:sms_flutter/models/course_model/prof_course_model.dart';
import 'package:sms_flutter/models/course_model/prof_upload_material_model.dart';
import 'package:sms_flutter/models/course_model/tag_material_model.dart';
import 'package:sms_flutter/models/course_register_model/course_register_model.dart';
import 'package:sms_flutter/modules/students_modules/courses/course_cubit/course_states.dart';

import '../../../../models/course_model/assignment_detail_model.dart';
import '../../../../models/course_model/prof_add_material_model.dart';
import '../../../../models/course_model/prof_assignment_detial_model.dart';
import '../../../../models/course_model/prof_get_assignment.dart';
import '../../../../models/course_model/student_course_material_model.dart';
import '../../../../shared/constants/constants.dart';
import '../../../../shared/network/end_points.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class CourseCubit extends Cubit<CourseStates>{
  // CourseCubit(super.initialState);
  late CourseModel? courseModel;
  late StudentCourseMaterialModel? studentCourseMaterialModel;
  CourseCubit() : super(CourseInitialState()){
    courseModel = CourseModel();
    // studentCourseMaterialModel = StudentCourseMaterialModel();
    // getStudentCourses();
  }
  static CourseCubit get(context) => BlocProvider.of(context);



  void getStudentCourses()
  {
    // print(token);
    emit(CourseLoadingState());
    if(role=='student'){
    DioHelper.getData(url: STUDENTCOURSES,
      token: token,
    ).then((value)
    {
      // getMaterialStudentCourses();
      // print(value?.data.toString());
      courseModel = CourseModel.fromJson(value?.data);
      // print(courseModel.data[0].course.);
      emit(CourseSuccessState(courseModel));


    }).catchError((error){
      print(error.toString());
      if (error.response != null && error.response.data != null) {
        // print('Errors: ${error.response.data}');
        if (error.response.data['errors'] != null) {
          // Handle multiple errors
          List<String> errors = List<String>.from(error.response.data['errors']);
          // print('Errors: $errors');
          emit(CourseErrorState(errors.join(", ")));
        } else if (error.response.data['message'] != null) {
          // Handle single error message
          String errorMessage = error.response.data['message'];
          // print('Error: $errorMessage');
          emit(CourseErrorState(errorMessage));
        } else {
          // print('Some thing went wrong , please try again');
          emit(CourseErrorState('Some thing went wrong , please try again'));
        }
      } else {
        // print(''Some thing went wrong , please try again' ');
        emit(CourseErrorState('Some thing went wrong , please try again'));
      }
    });}else{
      emit(ProfCourseLoadingState());
      DioHelper.getData(url: 'professor/courses',
        token: token,
      ).then((value)
      {
        // getMaterialStudentCourses();
        // print(value?.data.toString());
        profCourseModel = ProfCourseModel.fromJson(value?.data);
        // print(courseModel.data[0].course.);
        emit(ProfCourseSuccessState(profCourseModel));


      }).catchError((error){
        print(error.toString());
        if (error.response != null && error.response.data != null) {
          // print('Errors: ${error.response.data}');
          if (error.response.data['errors'] != null) {
            // Handle multiple errors
            List<String> errors = List<String>.from(error.response.data['errors']);
            // print('Errors: $errors');
            emit(ProfCourseErrorState(errors.join(", ")));
          } else if (error.response.data['message'] != null) {
            // Handle single error message
            String errorMessage = error.response.data['message'];
            // print('Error: $errorMessage');
            emit(ProfCourseErrorState(errorMessage));
          } else {
            // print('Some thing went wrong , please try again');
            emit(ProfCourseErrorState('Some thing went wrong , please try again'));
          }
        } else {
          // print(''Some thing went wrong , please try again' ');
          emit(ProfCourseErrorState('Some thing went wrong , please try again'));
        }
      });
    }
  }

TagsModel? tagsModel;
  void getStudentTagsCourses(String? id, String? type)
  {
    print('type: $type');
    // print(token);
    // getStudentAssignmentsCourses(id);
    if(role=='student'){
    emit(TagLoadingState());
    DioHelper.getData(url: 'student/courses/$id/materials/tags?type=$type',
      token: token,
    ).then((value)
    {
      // getMaterialStudentCourses();
      // print(value?.data.toString());
      // print(courseModel.data[0].course.);
      emit(TagSuccessState(tagsModel));
      tagsModel = TagsModel.fromJson(value?.data);


    }).catchError((error){
      print(error.toString());
      if (error.response != null && error.response.data != null) {
        // print('Errors: ${error.response.data}');
        if (error.response.data['errors'] != null) {
          // Handle multiple errors
          List<String> errors = List<String>.from(error.response.data['errors']);
          // print('Errors: $errors');
          emit(TagErrorState(errors.join(", ")));
        } else if (error.response.data['message'] != null) {
          // Handle single error message
          String errorMessage = error.response.data['message'];
          // print('Error: $errorMessage');
          emit(TagErrorState(errorMessage));
        } else {
          // print('Some thing went wrong , please try again');
          emit(TagErrorState('Some thing went wrong , please try again'));
        }
      } else {
        // print(''Some thing went wrong , please try again' ');
        emit(TagErrorState('Some thing went wrong , please try again'));
      }
    });}else{
      emit(ProfCourseMaterialTagsLoadingState());
      DioHelper.getData(url: 'professor/courses/$id/materials/tags?type=$type',
        token: token,
      ).then((value)
      {
        // getMaterialStudentCourses();
        // print(value?.data.toString());
        // print(courseModel.data[0].course.);
        emit(TagSuccessState(tagsModel));
        tagsModel = TagsModel.fromJson(value?.data);


      }).catchError((error){
        print(error.toString());
        if (error.response != null && error.response.data != null) {
          // print('Errors: ${error.response.data}');
          if (error.response.data['errors'] != null) {
            // Handle multiple errors
            List<String> errors = List<String>.from(error.response.data['errors']);
            // print('Errors: $errors');
            emit(TagErrorState(errors.join(", ")));
          } else if (error.response.data['message'] != null) {
            // Handle single error message
            String errorMessage = error.response.data['message'];
            // print('Error: $errorMessage');
            emit(TagErrorState(errorMessage));
          } else {
            // print('Some thing went wrong , please try again');
            emit(TagErrorState('Some thing went wrong , please try again'));
          }
        } else {
          // print(''Some thing went wrong , please try again' ');
          emit(TagErrorState('Some thing went wrong , please try again'));
        }
      });
  }
  }


  void getSectionTagsCourses(String? id, String type)
  {
    // print(token);
    // getStudentAssignmentsCourses(id);
    if(role=='student'){
      emit(TagLoadingState());
      DioHelper.getData(url: 'student/courses/$id/materials/tags?type=$type',
        token: token,
      ).then((value)
      {
        // getMaterialStudentCourses();
        // print(value?.data.toString());
        // print(courseModel.data[0].course.);
        emit(TagSuccessState(tagsModel));
        tagsModel = TagsModel.fromJson(value?.data);


      }).catchError((error){
        print(error.toString());
        if (error.response != null && error.response.data != null) {
          // print('Errors: ${error.response.data}');
          if (error.response.data['errors'] != null) {
            // Handle multiple errors
            List<String> errors = List<String>.from(error.response.data['errors']);
            // print('Errors: $errors');
            emit(TagErrorState(errors.join(", ")));
          } else if (error.response.data['message'] != null) {
            // Handle single error message
            String errorMessage = error.response.data['message'];
            // print('Error: $errorMessage');
            emit(TagErrorState(errorMessage));
          } else {
            // print('Some thing went wrong , please try again');
            emit(TagErrorState('Some thing went wrong , please try again'));
          }
        } else {
          // print(''Some thing went wrong , please try again' ');
          emit(TagErrorState('Some thing went wrong , please try again'));
        }
      });}else{
      emit(ProfCourseMaterialTagsLoadingState());
      DioHelper.getData(url: 'professor/courses/$id/materials/tags?type=$type',
        token: token,
      ).then((value)
      {
        // getMaterialStudentCourses();
        // print(value?.data.toString());
        // print(courseModel.data[0].course.);
        emit(TagSuccessState(tagsModel));
        tagsModel = TagsModel.fromJson(value?.data);


      }).catchError((error){
        print(error.toString());
        if (error.response != null && error.response.data != null) {
          // print('Errors: ${error.response.data}');
          if (error.response.data['errors'] != null) {
            // Handle multiple errors
            List<String> errors = List<String>.from(error.response.data['errors']);
            // print('Errors: $errors');
            emit(TagErrorState(errors.join(", ")));
          } else if (error.response.data['message'] != null) {
            // Handle single error message
            String errorMessage = error.response.data['message'];
            // print('Error: $errorMessage');
            emit(TagErrorState(errorMessage));
          } else {
            // print('Some thing went wrong , please try again');
            emit(TagErrorState('Some thing went wrong , please try again'));
          }
        } else {
          // print(''Some thing went wrong , please try again' ');
          emit(TagErrorState('Some thing went wrong , please try again'));
        }
      });
    }
  }






  void profAddLectureTag({
    required String? name,
required String? courseId,
    required String? materialType,
}){
    emit(ProfAddTagLoadingState());
    DioHelper.postData(
      url: 'professor/courses/$courseId/materials/addtag',
      token: token,
      data: {
        'name': name,
        'type': materialType,
      },
    ).then((value) {
      print(value?.data);
      emit(ProfAddTagSuccessState());

    }).catchError((error) {
      print(error.toString());
      if (error.response != null && error.response.data != null) {
        // print('Errors: ${error.response.data}');
        if (error.response.data['errors'] != null) {
          // Handle multiple errors
          List<String> errors = List<String>.from(error.response.data['errors']);
          // print('Errors: $errors');
          emit(ProfAddTagErrorState(errors.join(", ")));
        } else if (error.response.data['message'] != null) {
          // Handle single error message
          String errorMessage = error.response.data['message'];
          // print('Error: $errorMessage');
          emit(ProfAddTagErrorState(errorMessage));
        } else {
          // print('Some thing went wrong , please try again');
          emit(ProfAddTagErrorState('Some thing went wrong , please try again'));
        }
      } else {
        // print(''Some thing went wrong , please try again' ');
        emit(ProfAddTagErrorState('Some thing went wrong , please try again'));
      }
    });
  }



  TagMaterialModel? tagsMaterialModel;
  void getStudentTagsMaterialCourses(String? id, String? type,String? tagId)
  {
    // print(token);
    print(id);
    print(type);
    print(tagId);
    if(role=='student') {
      emit(TagMaterialLoadingState());
      DioHelper.getData(
        url: 'student/courses/$id/materials?type=$type&tag=$tagId',
        // url: 'student/courses/63/materials/?type=lecture&tag=4',
        token: token,
      ).then((value) {
        // getMaterialStudentCourses();
        print(value?.data.toString());
        // print(courseModel.data[0].course.);
        emit(TagMaterialSuccessState(tagsMaterialModel));
        tagsMaterialModel = TagMaterialModel.fromJson(value?.data);
      }).catchError((error) {
        print(error.toString());
        if (error.response != null && error.response.data != null) {
          // print('Errors: ${error.response.data}');
          if (error.response.data['errors'] != null) {
            // Handle multiple errors
            List<String> errors = List<String>.from(
                error.response.data['errors']);
            // print('Errors: $errors');
            emit(TagMaterialErrorState(errors.join(", ")));
          } else if (error.response.data['message'] != null) {
            // Handle single error message
            String errorMessage = error.response.data['message'];
            // print('Error: $errorMessage');
            emit(TagMaterialErrorState(errorMessage));
          } else {
            // print('Some thing went wrong , please try again');
            emit(TagMaterialErrorState(
                'Some thing went wrong , please try again'));
          }
        } else {
          // print(''Some thing went wrong , please try again' ');
          emit(TagMaterialErrorState(
              'Some thing went wrong , please try again'));
        }
      });
    }else{
      emit(TagMaterialLoadingState());
      DioHelper.getData(
        url: 'professor/courses/$id/materials?type=$type&tag=$tagId',
        // url: 'student/courses/63/materials/?type=lecture&tag=4',
        token: token,
      ).then((value) {
        // getMaterialStudentCourses();
        print(value?.data.toString());
        // print(courseModel.data[0].course.);
        emit(TagMaterialSuccessState(tagsMaterialModel));
        tagsMaterialModel = TagMaterialModel.fromJson(value?.data);
      }).catchError((error) {
        print(error.toString());
        if (error.response != null && error.response.data != null) {
          // print('Errors: ${error.response.data}');
          if (error.response.data['errors'] != null) {
            // Handle multiple errors
            List<String> errors = List<String>.from(
                error.response.data['errors']);
            // print('Errors: $errors');
            emit(TagMaterialErrorState(errors.join(", ")));
          } else if (error.response.data['message'] != null) {
            // Handle single error message
            String errorMessage = error.response.data['message'];
            // print('Error: $errorMessage');
            emit(TagMaterialErrorState(errorMessage));
          } else {
            // print('Some thing went wrong , please try again');
            emit(TagMaterialErrorState(
                'Some thing went wrong , please try again'));
          }
        } else {
          // print(''Some thing went wrong , please try again' ');
          emit(TagMaterialErrorState(
              'Some thing went wrong , please try again'));
        }
      });
    }
  }

  AssignmentsModel? assignmentsModel;
  ProfGetAssignment? profGetAssignment;
  void getStudentAssignmentsCourses(String? id)
  {
    // print(token);
    emit(ProfGetAssignmentLoadingState());
    if(role == 'student') {
      DioHelper.getData(url: 'student/courses/$id/assignments',
        token: token,
      ).then((value) {
        // getMaterialStudentCourses();
        // print(value?.data.toString());
        // print(courseModel.data[0].course.);
        emit(AssignmentsSuccessState(assignmentsModel));
        assignmentsModel = AssignmentsModel.fromJson(value?.data);
        // getStudentAssignmentDetailCourses(id,assignmentsModel!.data![0].id.toString());
      }).catchError((error) {
        print(error.toString());
        if (error.response != null && error.response.data != null) {
          // print('Errors: ${error.response.data}');
          if (error.response.data['errors'] != null) {
            // Handle multiple errors
            List<String> errors = List<String>.from(
                error.response.data['errors']);
            // print('Errors: $errors');
            emit(AssignmentsErrorState(errors.join(", ")));
          } else if (error.response.data['message'] != null) {
            // Handle single error message
            String errorMessage = error.response.data['message'];
            // print('Error: $errorMessage');
            emit(AssignmentsErrorState(errorMessage));
          } else {
            // print('Some thing went wrong , please try again');
            emit(AssignmentsErrorState(
                'Some thing went wrong , please try again'));
          }
        } else {
          // print(''Some thing went wrong , please try again' ');
          emit(AssignmentsErrorState(
              'Some thing went wrong , please try again'));
        }
      });
    }
    else if(role=='professor')
    {
      DioHelper.getData(url: 'professor/courses/$id/assignments',
        token: token,
      ).then((value) {
        // getMaterialStudentCourses();
        // print(value?.data.toString());
        // print(courseModel.data[0].course.);
        emit(ProfGetAssignmentSuccessState(profGetAssignment));
        profGetAssignment = ProfGetAssignment.fromJson(value?.data);
        // getStudentAssignmentDetailCourses(id,assignmentsModel!.data![0].id.toString());
      }).catchError((error) {
        print(error.toString());
        if (error.response != null && error.response.data != null) {
          // print('Errors: ${error.response.data}');
          if (error.response.data['errors'] != null) {
            // Handle multiple errors
            List<String> errors = List<String>.from(
                error.response.data['errors']);
            // print('Errors: $errors');
            emit(ProfGetAssignmentErrorState(errors.join(", ")));
          } else if (error.response.data['message'] != null) {
            // Handle single error message
            String errorMessage = error.response.data['message'];
            // print('Error: $errorMessage');
            emit(ProfGetAssignmentErrorState(errorMessage));
          } else {
            // print('Some thing went wrong , please try again');
            emit(ProfGetAssignmentErrorState(
                'Some thing went wrong , please try again'));
          }
        } else {
          // print(''Some thing went wrong , please try again' ');
          emit(ProfGetAssignmentErrorState(
              'Some thing went wrong , please try again'));
        }
      });
    }
  }
  ProfAddMaterialModel? profAddMaterialModel;
  void profAddLectureMaterial({
   required String? courseId,
   required String? tagId,
    required File? file,
    required String? materialType,
  } ) async {
    print(courseId);
    print(tagId);
    print(file!.path);
    emit(profAddLectureMaterialLoadingState());

    try {

      FormData formData = FormData.fromMap({
        'type': materialType,
        'tags[]': tagId,
        'file': await MultipartFile.fromFile(
          file!.path,
          filename: file.path.split('/').last,
        ),
      });

      Response? response = await DioHelper.postFile(
        url: 'professor/courses/$courseId/materials/add',
        data: formData,
        token: token,
      );

      if (response != null) {
        print(response.data.toString());
        profAddMaterialModel = ProfAddMaterialModel.fromJson(response.data);
        emit(profAddLectureMaterialSuccessState(profAddMaterialModel!));
      } else {
        emit(profAddLectureMaterialErrorState('Something went wrong, please try again'));
      }
    } catch (error) {
      print(error.toString());
      emit(profAddLectureMaterialErrorState('Something went wrong, please try again'));
    }
  }


  AssignmentDetailModel ? assignmentDetailModel;
  ProfGetAssignmentDetail ? profGetAssignmentDetail;
  void getStudentAssignmentDetailCourses(String? id,String? assignmentId)
  {
    if(role=='student'){
    // print(token);
    emit(AssignmentDetailLoadingState());
    DioHelper.getData(url: 'student/courses/$id/assignments/$assignmentId',
      token: token,
    ).then((value)
    {
      // getMaterialStudentCourses();
      print(value?.data.toString());
      // print(courseModel.data[0].course.);
      emit(AssignmentDetailSuccessState(assignmentDetailModel));
      assignmentDetailModel = AssignmentDetailModel.fromJson(value?.data);

    }).catchError((error){
      print(error.toString());
      if (error.response != null && error.response.data != null) {
        // print('Errors: ${error.response.data}');
        if (error.response.data['errors'] != null) {
          // Handle multiple errors
          List<String> errors = List<String>.from(error.response.data['errors']);
          // print('Errors: $errors');
          emit(AssignmentDetailErrorState(errors.join(", ")));
        } else if (error.response.data['message'] != null) {
          // Handle single error message
          String errorMessage = error.response.data['message'];
          // print('Error: $errorMessage');
          emit(AssignmentDetailErrorState(errorMessage));
        } else {
          // print('Some thing went wrong , please try again');
          emit(AssignmentDetailErrorState('Some thing went wrong , please try again'));
        }
      } else {
        // print(''Some thing went wrong , please try again' ');
        emit(AssignmentDetailErrorState('Some thing went wrong , please try again'));
      }
    });
    }else if(role=='professor'){
      // print(token);
      emit(ProfGetAssignmentDetailLoading());
      DioHelper.getData(url: 'professor/courses/$id/assignments/$assignmentId',
        token: token,
      ).then((value)
      {
        // getMaterialStudentCourses();
        print(value?.data.toString());
        // print(courseModel.data[0].course.);
        profGetAssignmentDetail = ProfGetAssignmentDetail.fromJson(value?.data);
        emit(ProfGetAssignmentDetailSuccess(profGetAssignmentDetail));

      }).catchError((error){
        print(error.toString());
        if (error.response != null && error.response.data != null) {
          // print('Errors: ${error.response.data}');
          if (error.response.data['errors'] != null) {
            // Handle multiple errors
            List<String> errors = List<String>.from(error.response.data['errors']);
            // print('Errors: $errors');
            emit(ProfGetAssignmentDetailError(errors.join(", ")));
          } else if (error.response.data['message'] != null) {
            // Handle single error message
            String errorMessage = error.response.data['message'];
            // print('Error: $errorMessage');
            emit(ProfGetAssignmentDetailError(errorMessage));
          } else {
            // print('Some thing went wrong , please try again');
            emit(ProfGetAssignmentDetailError('Some thing went wrong , please try again'));
          }
        } else {
          // print(''Some thing went wrong , please try again' ');
          emit(ProfGetAssignmentDetailError('Some thing went wrong , please try again'));
        }
      });
    }
  }




SubmitAssignment? submitAssignmentModel;
  void submitAssignment(String? id, String? assignmentId, File? file) async {
    emit(SubmitAssignmentLoadingState());

    if (file == null) {
      emit(SubmitAssignmentErrorState('Please select a file'));
      Fluttertoast.showToast(
        msg: "Please select a file",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    } else {
      try {
        MultipartFile multipartFile = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        );

        FormData formData = FormData.fromMap({
          'files[]': [multipartFile],
        });

        Response? response = await DioHelper.postFile(
          url: 'student/courses/$id/assignments/$assignmentId/submit',
          token: token,
          data: formData,
        );

        print(response!.data.toString());
        submitAssignmentModel = SubmitAssignment.fromJson(response.data);
        emit(SubmitAssignmentSuccessState(submitAssignmentModel!));
      } catch (error) {
        if (error is DioError) {
          if (error.response != null && error.response?.data != null) {
            if (error.response!.data['errors'] != null) {
              List<String> errors =
              List<String>.from(error.response?.data['errors']);
              emit(SubmitAssignmentErrorState(errors.join(", ")));
            } else if (error.response?.data['message'] != null) {
              String errorMessage = error.response?.data['message'];
              emit(SubmitAssignmentErrorState(errorMessage));
            } else {
              emit(SubmitAssignmentErrorState(
                  'Something went wrong, please try again'));
            }
          } else {
            emit(SubmitAssignmentErrorState(
                'Something went wrong, please try again'));
          }
        } else {
          emit(SubmitAssignmentErrorState(
              'Something went wrong, please try again'));
        }
      }
    }
  }






ProfCourseModel ? profCourseModel;
ProfUploadFileModel ? profUploadFileModel;
  void uploadFile(String? id,String? lecName,String? fileName,String? filePath)
  {
    // print(token);
    emit(ProfUploadFileLoadingState());

      DioHelper.uploadFile(
          url: 'professor/courses/$id/materials/add',
          token: token,
          data: {
            // 'file': [file],
            // 'name': fileName,
            'type':'lecture',
            'tags': [lecName],

          },
          fileFieldName: fileName,
        filePath: filePath,
      ).then((value) {
        // getMaterialStudentCourses();
        print(value?.data.toString());
        // print(courseModel.data[0].course.);
        emit(ProfUploadFileSuccessState(profUploadFileModel));
        profCourseModel = ProfCourseModel.fromJson(value?.data);
        // assignmentDetailModel = AssignmentDetailModel.fromJson(value?.data);

      }).catchError((error) {
        print(error.toString());
        if (error.response != null && error.response.data != null) {
          // print('Errors: ${error.response.data}');
          if (error.response.data['errors'] != null) {
            // Handle multiple errors
            List<String> errors = List<String>.from(
                error.response.data['errors']);
            // print('Errors: $errors');
            emit(ProfUploadFileErrorState(errors.join(", ")));
          } else if (error.response.data['message'] != null) {
            // Handle single error message
            String errorMessage = error.response.data['message'];
            // print('Error: $errorMessage');
            emit(ProfUploadFileErrorState(errorMessage));
          } else {
            // print('Some thing went wrong , please try again');
            emit(ProfUploadFileErrorState(
                'Some thing went wrong , please try again'));
          }
        } else {
          // print(''Some thing went wrong , please try again' ');
          emit(SubmitAssignmentErrorState(
              'Some thing went wrong , please try again'));
        }
      });
    }

DeleteAssignment ? deleteAssignmentModel;
void deleteAssignment(String? id,String? assignmentId){
  emit(ProfDeleteAssignmentLoading());
  DioHelper.deleteData(
    url: 'professor/courses/$id/assignments/$assignmentId',
    token: token,
  ).then((value) {
    print(value?.data.toString());

    deleteAssignmentModel = DeleteAssignment.fromJson(value?.data);
    emit(ProfDeleteAssignmentSuccess(deleteAssignmentModel!));
  }).catchError((error) {
    print(error.toString());
    if (error.response != null && error.response.data != null) {
      // print('Errors: ${error.response.data}');
      if (error.response.data['errors'] != null) {
        // Handle multiple errors
        List<String> errors = List<String>.from(
            error.response.data['errors']);
        // print('Errors: $errors');
        emit(ProfDeleteAssignmentError(errors.join(", ")));
      } else if (error.response.data['message'] != null) {
        // Handle single error message
        String errorMessage = error.response.data['message'];
        // print('Error: $errorMessage');
        emit(ProfDeleteAssignmentError(errorMessage));
      } else {
        // print('Some thing went wrong , please try again');
        emit(ProfDeleteAssignmentError(
            'Some thing went wrong , please try again'));
      }
    } else {
      // print(''Some thing went wrong , please try again' ');
      emit(ProfDeleteAssignmentError(
          'Some thing went wrong , please try again'));
    }
  });
}

  }


