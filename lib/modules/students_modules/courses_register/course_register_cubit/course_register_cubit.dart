import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_flutter/models/course_model/course_model.dart';
import 'package:sms_flutter/models/course_register_model/course_register_model.dart';
// import 'package:sms_flutter/models/course_model/course_model.dart';
import 'package:sms_flutter/modules/students_modules/courses_register/course_register_bottomnav_screens/course_register_available_screen.dart';
import 'package:sms_flutter/modules/students_modules/courses_register/course_register_bottomnav_screens/course_register_recomend_screen.dart';
import 'package:sms_flutter/modules/students_modules/courses_register/course_register_bottomnav_screens/course_register_selected_screen.dart';
import 'package:sms_flutter/modules/students_modules/courses_register/course_register_cubit/course_register_states.dart';

import '../../../../shared/constants/constants.dart';
import '../../../../shared/network/remote/dio_helper.dart';



class CourseRegisterCubit extends Cubit<CourseRegesterStates> {
  CourseRegisterCubit() : super(CourseRegisterInitialState());

  static CourseRegisterCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(Icons.thumb_up),
        label: 'Recomended'
    ),
    // BottomNavigationBarItem(
    //     icon: Icon(Icons.event_available),
    //     label: 'Available'
    // ),
    BottomNavigationBarItem(
        icon: Icon(Icons.tab_unselected),
        label: 'Selected'
    ),

  ];
  List<Widget> Screens = [
    CourseRegisterRecomendScreen(),
    // CourseRegisterAvailableScreen(),
    CourseRegisterSelectedScreen(),

  ];

  void changeBottomNavBar(int index)
  {
    currentIndex=index;

    emit(CourseRegisterChangeBottomNavstate());
  }



CourseRegister? courseRegisterModel;

  void getStudentCoursesRegister()
  {
    // print(token);
    emit(CourseRegesterLoadingState());

      DioHelper.getData(url: 'student/course_register',
        token: token,
      ).then((value)
      {
        // getMaterialStudentCourses();
        print(value?.data.toString());
        // courseModel = CourseModel.fromJson(value?.data);
        courseRegisterModel = CourseRegister.fromJson(value?.data);

        // print(courseModel.data[0].course.);
        emit(CourseRegesterSuccessState());


      }).catchError((error){
        print(error.toString());
        if (error.response != null && error.response.data != null) {
          // print('Errors: ${error.response.data}');
          if (error.response.data['errors'] != null) {
            // Handle multiple errors
            List<String> errors = List<String>.from(error.response.data['errors']);
            // print('Errors: $errors');
            emit(CourseRegesterErrorState(errors.join(", ")));
          } else if (error.response.data['message'] != null) {
            // Handle single error message
            String errorMessage = error.response.data['message'];
            // print('Error: $errorMessage');
            emit(CourseRegesterErrorState(errorMessage));
          } else {
            // print('Some thing went wrong , please try again');
            emit(CourseRegesterErrorState('Some thing went wrong , please try again'));
          }
        } else {
          // print(''Some thing went wrong , please try again' ');
          emit(CourseRegesterErrorState('Some thing went wrong , please try again'));
        }
      });
  }




  void submitCourseRegester(List <int?>?selectedCoursesId
    // required String course_id,
    // required List<int> coursesId,

  ) {
    // print(email);
    // print(password);
    emit(SubmitCourseRegesterLoadingState());
    DioHelper.postData(
      url: 'student/course_register',
      data: {
        'payment_type':1,
        'courses' : selectedCoursesId,
      },
      token: token,
    ).then((value) {
      // print(LOGIN);
      print(value.toString());
      // Check if the value is not null
      // LoginModel loginModel = LoginModel.fromJson(value?.data);
      // print(value?.data.toString());
      // print(value?.data['data']['token'].toString());
      // print(loginModel!.data!.token);
      emit(SubmitCourseRegesterSuccessState());


      // getProfile(token);
      // print(loginModel!.data!.token);

      // if (value != null) {
      //   // print(value.data.toString());
      //   // loginModel = LoginModel.fromJson(value.data);
      //   if (loginModel != null && loginModel!.data != null) {
      //     print(loginModel!.data!.token);
      //
      //   } else {
      //     print('Login model or its data is null');
      //   }
      //   emit(LoginSuccessState(loginModel!));
      // } else {
      //   print('A7A Value is null');
      // }


      // }).catchError((error) {
      //   // get error from the server
      //   print(error?.response['message']);
      //   emit(LoginErrorState(error.response.toString()));
      // });

    }).catchError((error) {
      print(error.toString());
      if (error.response != null && error.response.data != null) {
        // print('Errors: ${error.response.data}');
        if (error.response.data['errors'] != null) {
          // Handle multiple errors
          List<String> errors = List<String>.from(error.response.data['errors']);
          // print('Errors: $errors');
          emit(SubmitCourseRegesterErrorState(errors.join(", ")));
        } else if (error.response.data['message'] != null) {
          // Handle single error message
          String errorMessage = error.response.data['message'];
          // print('Error: $errorMessage');
          emit(SubmitCourseRegesterErrorState(errorMessage));
        } else {
          // print('Some thing went wrong , please try again');
          emit(SubmitCourseRegesterErrorState('Some thing went wrong , please try again'));
        }
      } else {
        // print(''Some thing went wrong , please try again' ');
        emit(SubmitCourseRegesterErrorState('Some thing went wrong , please try again'));
      }
    });


  }
bool tapped = false;
  void tappedFun(bool tapped)
  {
    tapped = !tapped;
    emit(Tapped());

  }

  var selectedCoursesId = [];
  List <int?>? idList = [];
  void deleteCourse(int? id)
  {
    var selectedList= courseRegisterModel?.data?.where((element) => element.selected==true).toList();
    idList = selectedList
        ?.where((element) => element.selected == true)
        .map((element) => element.id)
        .toList() ?? [];
    idList?.remove(id);
    submitCourseRegester(idList);
    emit(CourseRegisterUnSelectedState());
    // print(id);
    // print(selectedCoursesId);
    // print(selectedCoursesId.contains(id));
    // if(selectedCoursesId.contains(id))
    // {
    //   selectedCoursesId.remove(id);
    //   // print(selectedCoursesId);
    //   // print('remove');
    //   emit(DeleteCourseRegisterSuccessState());
    // }
    // else
    // {
    //   selectedCoursesId.add(id);
    //   // print(selectedCoursesId);
    //   // print('add');
    //   emit(AddCourseRegisterSuccessState());
    // }

  }
  void addCourse(int? id){
    var selectedList= courseRegisterModel?.data?.where((element) => element.selected==true).toList();
    idList = selectedList
        ?.where((element) => element.selected == true)
        .map((element) => element.id)
        .toList() ?? [];
    idList?.add(id);
    submitCourseRegester(idList);
    emit(CourseRegisterSelectedState());
  }


}
