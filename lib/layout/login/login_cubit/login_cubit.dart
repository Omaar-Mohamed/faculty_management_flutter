import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:sms_flutter/models/login_model/code_model.dart';
import 'package:sms_flutter/models/login_model/forget_password.dart';
import 'package:sms_flutter/models/login_model/login_model.dart';
import 'package:sms_flutter/models/login_model/change_password.dart';
import 'package:sms_flutter/models/login_model/logout.dart';
import 'package:sms_flutter/models/login_model/reset_password.dart';
// import 'package:sms_flutter/layout/student_general/student_cubit/student_states.dart';
import 'package:sms_flutter/modules/professor_modules/professor_schedule_module/prof_schedule_screen.dart';
import 'package:sms_flutter/modules/students_modules/courses/course_cubit/course_cubit.dart';
import 'package:sms_flutter/modules/students_modules/courses/courses_screen.dart';
import 'package:sms_flutter/modules/students_modules/sections_register/meetings_register.dart';
import 'package:sms_flutter/shared/components/components.dart';
import 'package:sms_flutter/shared/network/local/cache_helper(shared_prefrenceds).dart';
import 'package:sms_flutter/shared/network/remote/dio_helper.dart';

import '../../../models/channel/channels_model.dart';
import '../../../models/course_model/course_model.dart';
import '../../../models/student_drawer_sections/student_drawer_section.dart';
import '../../../modules/login/login_screen.dart';
import '../../../modules/logout/logout.dart';
import '../../../modules/students_modules/Community/community_screen.dart';
import '../../../modules/students_modules/courses_register/courses_register_screen.dart';
import '../../../modules/students_modules/payment/payment_screen.dart';
import '../../../modules/students_modules/reports/reports.dart';
import '../../../modules/students_modules/schedules/schedules_screen.dart';
import '../../../modules/students_modules/setting/setting_screen.dart';
import '../../../notify.dart';
import '../../../shared/constants/constants.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/remote/pusher.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  // late CourseModel courseModel;
  LoginCubit() : super(DrawerInitialState()){
    // courseModel=CourseModel();
  }


  var password2Controller = TextEditingController();

  var passwordController = TextEditingController();
  var idController = TextEditingController();
  var codeController = TextEditingController();

  static LoginCubit get(context) => BlocProvider.of(context);
  bool rememberMe = false;
  bool isPasswordVisible = false;
  bool isPasswordVisible2 = false;

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // var currentPage = DrawerSections.Courses;
  // var currentPage ;
  LoginModel? loginModel;

  // late var currentPage;
// var C=Color(Colors.grey[300]);

  Widget menuItem(int id, String title, IconData icon, bool selected,
      BuildContext context, String type) {
    return Material(
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          if (id == 1) {
            if (type == 'student') {
              currentPage = DrawerSections.Schedules;
              emit(ChangeDrawer());
              navigateTo(context, SchedulesScreen(type: type));
              emit(DrawerInitialState());
            } else if (type == 'Professor') {
              currentPage = DrawerSections.Schedules;
              emit(ChangeDrawer());
              navigateTo(context, SchedulesScreen(type: 'professor'));
              emit(DrawerInitialState());
            }
            // currentPage = DrawerSections.Schedules;
            // emit(ChangeDrawer());
            // navigateTo(context, SchedulesScreen());
            // emit(DrawerInitialState());
          } else if (id == 2) {
            if (type == 'student') {
              currentPage = DrawerSections.Courses;
              emit(ChangeDrawer());
              navigateTo(context, CoursesScreen(type: type));
              // getStudentCourses();
              emit(DrawerInitialState());
            } else if (type == 'Professor') {
              currentPage = DrawerSections.Courses;
              emit(ChangeDrawer());
              navigateTo(context, CoursesScreen(type: type));
              emit(DrawerInitialState());
            }
            // currentPage = DrawerSections.Courses;
            // emit(ChangeDrawer());
            // navigateTo(context, CoursesScreen());
            // emit(StudentInCoursesState());
          } else if (id == 3) {
            if (type == 'student') {
              currentPage = DrawerSections.Community;
              emit(ChangeDrawer());
              navigateTo(
                  context,
                  CommunityScreen(
                    type: type,
                  ));
              emit(DrawerInitialState());
            } else if (type == 'Professor') {
              currentPage = DrawerSections.Community;
              emit(ChangeDrawer());
              navigateTo(context, CommunityScreen(type: type));
              emit(DrawerInitialState());
            }
            // currentPage = DrawerSections.Community;
            // emit(ChangeDrawer());
            // navigateTo(context, CommunityScreen());
            // // emit(StudentInCommunityState());
          } else if (id == 4) {
            if (type == 'student') {
              currentPage = DrawerSections.Reports;
              emit(ChangeDrawer());
              navigateTo(context, ReportsScreen(type: type));
              emit(DrawerInitialState());
            } else if (type == 'Professor') {
              currentPage = DrawerSections.Reports;
              emit(ChangeDrawer());
              navigateTo(context, ReportsScreen(type: type));
              emit(DrawerInitialState());
            }
            // currentPage = DrawerSections.Reports;
            // emit(ChangeDrawer());
            // navigateTo(context, ReportsScreen());
            // // emit(StudentInReportState());
          } else if (id == 5) {
            currentPage = DrawerSections.Courses_Register;
            emit(ChangeDrawer());
            navigateTo(context, CoursesRegisterScreen());
            // emit(StudentInCourseRegisterState());
          } else if (id == 6) {
            currentPage = DrawerSections.Section_Register;
            navigateTo(context, MeetingsRegister());
            emit(ChangeDrawer());
            // emit(StudentInMeetingsRegisterState());
          } else if (id == 7) {
            currentPage = DrawerSections.Payment;
            navigateTo(context, PaymentScreen());
            emit(ChangeDrawer());
          } else if (id == 8) {
            if (type == 'student') {
              currentPage = DrawerSections.Settings;
              navigateTo(context, settingScreen(type: type));
              emit(ChangeDrawer());
            } else if (type == 'Professor') {
              currentPage = DrawerSections.Settings;
              navigateTo(context, settingScreen(type: type));
              emit(ChangeDrawer());
            }
            // currentPage = DrawerSections.Settings;
            // navigateTo(context, settingScreen());
            // emit(ChangeDrawer());
          } else if (id == 9) {
            if (type == 'student') {
              currentPage = DrawerSections.Logout;
              CacheHelper.removeData(key: 'fname');
              CacheHelper.removeData(key: 'sname');
              CacheHelper.removeData(key: 'email');
              CacheHelper.removeData(key: 'image');

              CacheHelper.removeData(key: 'cachecode');
              CacheHelper.removeData(key: 'cacheid');



              userLogout(token: token);

              CacheHelper.removeData(key: 'token').then((value){
                if(value){
                  navigateAndFinsh(context, loginScreen());
                }
              });
              // navigateTo(context, LogOutScreen());
              emit(ChangeDrawer());
            } else if (type == 'Professor') {
              currentPage = DrawerSections.Logout;
              CacheHelper.removeData(key: 'fname');
              CacheHelper.removeData(key: 'sname');
              CacheHelper.removeData(key: 'email');
              CacheHelper.removeData(key: 'image');

              CacheHelper.removeData(key: 'cachecode');
              CacheHelper.removeData(key: 'cacheid');

              userLogout(token: token);

              CacheHelper.removeData(key: 'token').then((value){
                if(value){
                  navigateAndFinsh(context, loginScreen());
                }
              });
              // navigateTo(context, LogOutScreen());
              emit(ChangeDrawer());

            }
            // currentPage = DrawerSections.Logout;
            // navigateTo(context, LogOutScreen());
            // emit(ChangeDrawer());
          }
        },
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Container(
            child: Row(
              children: [
                Expanded(
                  child: Icon(
                    icon,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      color: selected ? Colors.grey[300] : Colors.transparent,
    );
  }

  // void changeDrawerSection(DrawerSections section,int id) {
  //   emit(StudentChangeDrawerSectionState(section: DrawerSections.Schedules, currentPage: id));
  // }
  // Widget menuItem(int id, String title, IconData icon, bool selected, BuildContext context) {
  //   return BlocBuilder<StudentCubit, StudentStates>(
  //     builder: (context, state) {
  //       return Material(
  //         child: InkWell(
  //           onTap: () {
  //             Navigator.pop(context);
  //             if (id == 1) {
  //               context.read<StudentCubit>().changeDrawerSection(DrawerSections.Schedules,1);
  //               navigateTo(context, SchedulesScreen());
  //             } else if (id == 2) {
  //               context.read<StudentCubit>().changeDrawerSection(DrawerSections.Courses,2);
  //               navigateTo(context, CoursesScreen());
  //             } else if (id == 3) {
  //               context.read<StudentCubit>().changeDrawerSection(DrawerSections.Community,3);
  //               navigateTo(context, CommunityScreen());
  //             } else if (id == 4) {
  //               context.read<StudentCubit>().changeDrawerSection(DrawerSections.Reports,4);
  //               navigateTo(context, ReportsScreen());
  //             } else if (id == 5) {
  //               context.read<StudentCubit>().changeDrawerSection(DrawerSections.Courses_Register,5);
  //               navigateTo(context, CoursesRegisterScreen());
  //             } else if (id == 6) {
  //               context.read<StudentCubit>().changeDrawerSection(DrawerSections.Section_Register,6);
  //               navigateTo(context, MeetingsRegister());
  //             } else if (id == 7) {
  //               context.read<StudentCubit>().changeDrawerSection(DrawerSections.Payment,7);
  //               navigateTo(context, PaymentScreen());
  //             } else if (id == 8) {
  //               context.read<StudentCubit>().changeDrawerSection(DrawerSections.Settings,8);
  //               navigateTo(context, settingScreen());
  //             } else if (id == 9) {
  //               context.read<StudentCubit>().changeDrawerSection(DrawerSections.Logout,9);
  //               navigateTo(context, LogOutScreen());
  //             }
  //           },
  //           child: Padding(
  //             padding: EdgeInsets.all(15.0),
  //             child: Container(
  //               // color: state is StudentChangeDrawerSectionState && state.currentPage == id ? Colors.grey[300] : Colors.transparent,
  //               child: Row(
  //                 children: [
  //                   Expanded(
  //                     child: Icon(
  //                       icon,
  //                       size: 20,
  //                       color: Colors.black,
  //                     ),
  //                   ),
  //                   Expanded(
  //                     flex: 3,
  //                     child: Text(
  //                       title,
  //                       style: TextStyle(
  //                         color: Colors.black,
  //                         fontSize: 16,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //         color: state is StudentChangeDrawerSectionState && state.currentPage == id ? Colors.grey[300] : Colors.transparent,
  //
  //       );
  //     },
  //   );
  // }

// Widget changeColor(currentPage,Color color) {
//   if (currentPage == DrawerSections.Schedules) {
//     color = Colors.grey[300]!;
//     emit(ChangeDrawerColor());
//   }
//   return Container(color: color,);
// }

  Widget StudentDrawerList(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        children: [
          menuItem(1, "Schedules", Icons.schedule,
              currentPage == DrawerSections.Schedules, context, 'student'),
          menuItem(2, "Courses", Icons.book_rounded,
              currentPage == DrawerSections.Courses, context, 'student'),
          menuItem(3, "Community", Icons.comment,
              currentPage == DrawerSections.Community, context, 'student'),
          menuItem(4, "Reports", Icons.report,
              currentPage == DrawerSections.Reports, context, 'student'),
          menuItem(
              5,
              "Courses Register",
              Icons.book_outlined,
              currentPage == DrawerSections.Courses_Register,
              context,
              'student'),
          menuItem(
              6,
              "Meetings Register",
              Icons.book_rounded,
              currentPage == DrawerSections.Section_Register,
              context,
              'student'),
          menuItem(7, "Payment", Icons.monetization_on_outlined,
              currentPage == DrawerSections.Payment, context, 'student'),
          myDivider(),
          menuItem(8, "Settings", Icons.settings,
              currentPage == DrawerSections.Settings, context, 'student'),
          menuItem(9, "Logout", Icons.logout,
              currentPage == DrawerSections.Logout, context, 'student'),
        ],
      ),
    );
  }

  Widget ProfessorDrawerList(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        children: [
          menuItem(1, "Schedules", Icons.schedule,
              currentPage == DrawerSections.Schedules, context, 'Professor'),
          menuItem(2, "Courses", Icons.book_rounded,
              currentPage == DrawerSections.Courses, context, 'Professor'),
          menuItem(3, "Community", Icons.comment,
              currentPage == DrawerSections.Community, context, 'Professor'),
          menuItem(4, "Reports", Icons.report,
              currentPage == DrawerSections.Reports, context, 'Professor'),
          myDivider(),
          menuItem(8, "Settings", Icons.settings,
              currentPage == DrawerSections.Settings, context, 'Professor'),
          menuItem(9, "Logout", Icons.logout,
              currentPage == DrawerSections.Logout, context, 'Professor'),
        ],
      ),
    );
  }

  void userLogin({
    required String email,
    required String password,
  }) {
    // print(email);
    // print(password);
    emit(LoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'username': email,
        'password': password,
      },
    ).then((value) {
      // print(LOGIN);
      // print(value.toString());
      // Check if the value is not null
      LoginModel loginModel = LoginModel.fromJson(value?.data);
      // print(value?.data['data']['token'].toString());
      // print(loginModel!.data!.token);
      emit(LoginSuccessState(loginModel));

      if(loginModel != null && loginModel!.data != null){
        CacheHelper.saveData(key: 'token', value: loginModel.data!.token);
        CacheHelper.saveData(key: 'role', value: loginModel.data!.user!.role);
        CacheHelper.saveData(key: 'fname', value: loginModel.data!.user!.fname);
        CacheHelper.saveData(key: 'sname', value: loginModel.data!.user!.sname);
        CacheHelper.saveData(key: 'email', value: loginModel.data!.user!.email);
        CacheHelper.saveData(key: 'image', value: loginModel.data!.user!.avatar);
        image = CacheHelper.getData(key: 'image').toString();
        fname = CacheHelper.getData(key: 'fname').toString();
        lname = CacheHelper.getData(key: 'sname').toString();
        token = CacheHelper.getData(key: 'token').toString();
        role = CacheHelper.getData(key: 'role').toString();
        cacheEmail = CacheHelper.getData(key: 'email').toString();
        print(fname);
        print(lname);
        debugPrint('image: ${image}');
        debugPrint('token: ${token}');
      }
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
      getChannels(token);
      subscribeToChannels(channelModel!.data!.courses,
          channelModel!.data!.general!,
          channelModel!.data!.department!,
          channelModel!.data!.user!);

    }).catchError((error) {
      if (error.response != null && error.response.data != null) {
        // print('Errors: ${error.response.data}');
        if (error.response.data['errors'] != null) {
          // Handle multiple errors
          List<String> errors = List<String>.from(error.response.data['errors']);
          // print('Errors: $errors');
          emit(LoginErrorState(errors.join(", ")));
        } else if (error.response.data['message'] != null) {
          // Handle single error message
          String errorMessage = error.response.data['message'];
          // print('Error: $errorMessage');
          emit(LoginErrorState(errorMessage));
        } else {
          // print('Some thing went wrong , please try again');
          emit(LoginErrorState('Some thing went wrong , please try again'));
        }
      } else {
        // print(''Some thing went wrong , please try again' ');
        emit(LoginErrorState('Some thing went wrong , please try again'));
      }
    });


  }



  void userForget({
    required String id,
  }) {
    CacheHelper.saveData(key:'cacheid', value: id);
    cacheid=CacheHelper.getData(key: 'cacheid').toString();
    print(id);

    emit(ForgetPasswordLoadingState());
    DioHelper.postData(
      url: FORGETPASSWORD,
      data: {

        'national_id': id,
        'method':'email',
      },
    ).then((value) {
      print(value?.data);

      // print(LOGIN);
      // print(value.toString());
      // Check if the value is not null
      ForgetPasswordModel idModel = ForgetPasswordModel.fromJson(value?.data);
      // print(value?.data['data']['token'].toString());
      // print(idModel!.data!);
      emit(ForgetPasswordSuccessState(idModel));
      // getProfile(idModel!.data!);
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
    }).catchError((error) {
      print(error.toString());
      emit(ForgetPasswordErrorState(error.toString()));
    });
  }



  void userCode({
    required String code,
    // required String password,
    // required String password_confirmation,

  }) {
    print(code);
    CacheHelper.saveData(key:'cachecode', value: code);
    cachecode=CacheHelper.getData(key: 'cachecode').toString();

    emit(CodeLoadingState());
    DioHelper.postData(
      url: CHECKCODE,
      data: {

        'code':code ,
        // 'password':'123456789' ,
        // 'password_confirmation':'12345678',

        // 'password':password,

      },


    ).then((value) {
      print(value?.data);
      // print(LOGIN);
      // print(value.toString());
      // Check if the value is not null
      CodeModel codeModel = CodeModel.fromJson(value?.data);
      // print(value?.data['data']['token'].toString());
      // print(idModel!.data!);
      emit(CodeSuccessState(codeModel));
      // getProfile(idModel!.data!);
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
      //   print('Value is null');
      // }
    }).catchError((error) {
      if (error.response != null && error.response.data != null) {
        print('Errors: ${error.response.data}');
        if (error.response.data['errors'] != null) {
          // Handle multiple errors
          List<String> errors = List<String>.from(error.response.data['errors']);
          // print('Errors: $errors');
          emit(CodeErrorState(errors.join(", ")));
        } else if (error.response.data['message'] != null) {
          // Handle single error message
          String errorMessage = error.response.data['message'];
          // print('Error: $errorMessage');
          emit(CodeErrorState(errorMessage));
        } else {
          // print('Some thing went wrong , please try again');
          emit(CodeErrorState('Some thing went wrong , please try again'));
        }
      } else {
        // print(''Some thing went wrong , please try again' ');
        emit(CodeErrorState('Some thing went wrong , please try again'));
      }
    });
  }


  void userResent({
    required String id,
    // required String password,
    // required String password_confirmation,

  }) {
    print(id);
    emit(ResetLoadingState());

    DioHelper.postData(
      url: RESENTCODE,
      data: {

        'national_id':id ,
        'method':'email',


        // 'password':'123456789' ,
        // 'password_confirmation':'12345678',

        // 'password':password,
      },
    ).then((value) {
      print(value?.data);
      // print(LOGIN);
      // print(value.toString());
      // Check if the value is not null
      ResetModel resetModel = ResetModel.fromJson(value?.data);
      // print(value?.data['data']['token'].toString());
      // print(idModel!.data!);
      emit(ResetSuccessState(resetModel));
      // getProfile(idModel!.data!);
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
    }).catchError((error) {
      if (error.response != null && error.response.data != null) {
        print('Errors: ${error.response.data}');
        if (error.response.data['errors'] != null) {
          // Handle multiple errors
          List<String> errors = List<String>.from(error.response.data['errors']);
          // print('Errors: $errors');
          emit(ResetErrorState(errors.join(", ")));
        } else if (error.response.data['message'] != null) {
          // Handle single error message
          String errorMessage = error.response.data['message'];
          // print('Error: $errorMessage');
          emit(ResetErrorState(errorMessage));
        } else {
          // print('Some thing went wrong , please try again');
          emit(ResetErrorState('Some thing went wrong , please try again'));
        }
      } else {
        // print(''Some thing went wrong , please try again' ');
        emit(ResetErrorState('Some thing went wrong , please try again'));
      }
    });
  }


  void userNewPassword({
    required String otp,
    required String password,
    required String password_confirmation,

  }) {
    print(otp);

    print(password);
    print(password_confirmation);

    emit(NewPasswordLoadingState());
    DioHelper.postData(
      url: CHANGEPASSWORD,
      data: {
        'code': otp,
        'password':password ,

        'password_confirmation':password_confirmation ,
        // 'password':'123456789' ,
        // 'password_confirmation':'12345678',

        // 'password':password,
      },
    ).then((value) {
      print(value?.data);
      // print(LOGIN);
      // print(value.toString());
      // Check if the value is not null
      NewPasswordModel newModel = NewPasswordModel.fromJson(value?.data);
      // print(value?.data['data']['token'].toString());
      // print(idModel!.data!);
      emit(NewPasswordSuccessState(newModel));

    }).catchError((error) {
      if (error.response != null && error.response.data != null) {
        print('Errors: ${error.response.data}');
        if (error.response.data['errors'] != null) {
          // Handle multiple errors
          List<String> errors = List<String>.from(error.response.data['errors']);
          // print('Errors: $errors');
          emit(NewPasswordErrorState(errors.join(", ")));
        } else if (error.response.data['message'] != null) {
          // Handle single error message
          String errorMessage = error.response.data['message'];
          // print('Error: $errorMessage');
          emit(NewPasswordErrorState(errorMessage));
        } else {
          // print('Some thing went wrong , please try again');
          emit(NewPasswordErrorState('Some thing went wrong , please try again'));
        }
      } else {
        // print(''Some thing went wrong , please try again' ');
        emit(NewPasswordErrorState('Some thing went wrong , please try again'));
      }
    });
  }
  // void userResent({
  //   // required String otp,
  //   required String code,
  //   // required String password,
  //   // required String password_confirmation,
  //
  // }) {
  //   print(code);
  //   // print(password_confirmation);
  //
  //   emit(ResetLoadingState());
  //   DioHelper.postData(
  //     url: CHANGEPASSWORD,
  //     data: {
  //       'code': code,
  //       // 'password':password ,
  //
  //       // 'password_confirmation':password_confirmation ,
  //       // 'password':'123456789' ,
  //       // 'password_confirmation':'12345678',
  //
  //       // 'password':password,
  //     },
  //   ).then((value) {
  //     print(value?.data);
  //     // print(LOGIN);
  //     // print(value.toString());
  //     // Check if the value is not null
  //     ResetModel resetModel = ResetModel.fromJson(value?.data);
  //     // print(value?.data['data']['token'].toString());
  //     // print(idModel!.data!);
  //     emit(ResetSuccessState(resetModel));
  //
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(ResetErrorState(error.toString()));
  //   });
  // }

  void userLogout({
      required String token
}) {
    print(token);
    emit(ResetLoadingState());
    DioHelper.postData(
      url: LOGOUT,
      token:token,
      data: {},
    ).then((value) {
      print(token);
      print(value?.data);

      LogoutModel logoutModel = LogoutModel.fromJson(value?.data);
      emit(LogoutSuccessState());
      Fluttertoast.showToast(
          msg: ' ${logoutModel.message.toString()}',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 5,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );

    }).catchError((error) {
      print(error.toString());
      emit(LogoutErrorState());
    });
  }




  List <dynamic> Profile = [];
  void getProfile(token)
  {
    print(token);
    emit(LoginLoadingState());
    DioHelper.getData(url: PROFILE,
      token: token,

    ).then((value)
    {
      print(value?.data.toString());

    }).catchError((error){
      print(error.toString());
    });
  }
  ChannelModel? channelModel;
  void getChannels(token)
  {
    print(token);
    emit(ChannelsLoadingState());
    DioHelper.getData(url: 'channels',
      token: token,

    ).then((value)
    {
      channelModel = ChannelModel.fromJson(value?.data);
      emit(ChannelsSuccessState(channelModel!));

      print(value?.data.toString());

    }).catchError((error){
      print(error.toString());
      if (error.response != null && error.response.data != null) {
        print('Errors: ${error.response.data}');
        if (error.response.data['errors'] != null) {
          // Handle multiple errors
          List<String> errors = List<String>.from(error.response.data['errors']);
          // print('Errors: $errors');
          emit(ChannelsErrorState(errors.join(", ")));
        } else if (error.response.data['message'] != null) {
          // Handle single error message
          String errorMessage = error.response.data['message'];
          // print('Error: $errorMessage');
          emit(ChannelsErrorState(errorMessage));
        } else {
          // print('Some thing went wrong , please try again');
          emit(ChannelsErrorState('Some thing went wrong , please try again'));
        }
      } else {
        // print(''Some thing went wrong , please try again' ');
        emit(ChannelsErrorState('Some thing went wrong , please try again'));
      }
    });
  }
  void subscribeToChannels(List<String>? channelNames,String? general,String? department,String? user) {
  if (channelNames != null) {
    for (final channelName in channelNames) {
      Channel? channel = pusher?.subscribe(channelName);
      channel?.bind('course-notification', (PusherEvent? event) {
        // Handle the event data here
        // print('Received event from $channelName: ${event?.data}');
        NotificationApi.showNotification(
          event?.data!,
          'You have 5 new messages',
        );
      });
    }
  }
  Channel? channel = pusher?.subscribe(general!);
  channel?.bind('general-notification', (PusherEvent? event) {
    // Handle the event data here
    // print('Received event from $channelName: ${event?.data}');
    NotificationApi.showNotification(
      event?.data!,
      'You have 5 new messages',
    );
  });

  // Channel? channel1 = pusher?.subscribe(department!);
  // channel1?.bind('course-notification', (PusherEvent? event) {
  //   // Handle the event data here
  //   // print('Received event from $channelName: ${event?.data}');
  //   NotificationApi.showNotification(
  //     event?.data!,
  //     'You have 5 new messages',
  //   );
  // });

  Channel? channel2 = pusher?.subscribe(user!);
  channel2?.bind('user-notification', (PusherEvent? event) {
    // Handle the event data here
    // print('Received event from $channelName: ${event?.data}');
    NotificationApi.showNotification(
      event?.data!,
      'You have 5 new messages',
    );
  });
  }

  void printToken()
  {
    print('token:$token');
    print('role:$role');
  }
}