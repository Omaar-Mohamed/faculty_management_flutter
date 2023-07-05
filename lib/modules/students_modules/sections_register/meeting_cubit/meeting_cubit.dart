import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_flutter/models/meetings_model/meetings_model.dart';
import 'package:sms_flutter/models/meetings_model/post_meeting_model.dart';
import 'package:sms_flutter/models/meetings_model/sign_up_meeting.dart';
import 'package:sms_flutter/modules/students_modules/sections_register/meeting_cubit/meeting_status.dart';
import 'package:sms_flutter/shared/constants/constants.dart';
import 'package:sms_flutter/shared/network/end_points.dart';
import 'package:sms_flutter/shared/network/remote/dio_helper.dart';

class MeetingsCubit extends Cubit<MeetingsStates> {

  MeetingsCubit() : super(MeetingsInitialState()){
    // getMeetings();
  }

  static MeetingsCubit get(context) => BlocProvider.of(context);

  // final List<Map<String, String>> Meetings = [
  //   {'name': 'oop', 'image': 'assets/images/oop.png','lectures': 'Available lectures : 2','sections': 'Available sections : 4'},
  //   {'name': 'oop', 'image': 'assets/images/oop.png','lectures': 'Available lectures : 2','sections': 'Available sections : 4'},
  //   {'name': 'oop', 'image': 'assets/images/oop.png','lectures': 'Available lectures : 2','sections': 'Available sections : 4'},
  //   {'name': 'oop', 'image': 'assets/images/oop.png','lectures': 'Available lectures : 2','sections': 'Available sections : 4'},
  // ];


  MeetingsModel? meetingModel;
  void getMeetings()
  {
    print(token);
    emit(MeetingsLoadingState());
    DioHelper.getData(url: GETCOURSEFORMEETINGS,
      token: token,
    ).then((value)
    {

      // print(value?.data.toString());
      meetingModel = MeetingsModel.fromJson(value?.data);
      emit(MeetingsSuccessState(  meetingModel));


    }).catchError((error){
      print(error.toString());
      // if (error.response != null && error.response.data != null) {
      //   // print('Errors: ${error.response.data}');
      //   if (error.response.data['errors'] != null) {
      //     // Handle multiple errors
      //     List<String> errors = List<String>.from(error.response.data['errors']);
      //     // print('Errors: $errors');
      //     emit( MeetingsErrorState(errors.join(", ")));
      //   } else if (error.response.data['message'] != null) {
      //     // Handle single error message
      //     String errorMessage = error.response.data['message'];
      //     // print('Error: $errorMessage');
      //     emit( MeetingsErrorState(errorMessage));
      //   } else {
      //     // print('Some thing went wrong , please try again');
      //     emit( MeetingsErrorState('Some thing went wrong , please try again'));
      //   }
      // } else {
      //   // print(''Some thing went wrong , please try again' ');
      //   emit( MeetingsErrorState('Some thing went wrong , please try again'));
      // }
    });
  }
  SignUpMeetingModel? signmeetingModel;
  void signUpMeeting(int? courseid)
  {

    print(token);
    emit(SignUpMeetingLoadingState());
    DioHelper.getData(url: 'student/meeting_register/$courseid',
      token: token,
    ).then((value)
    {

      print(value?.data.toString());
      signmeetingModel = SignUpMeetingModel.fromJson(value?.data);
      emit(SignUpMeetingSuccessState(  signmeetingModel));


    }).catchError((error){
      print(error.toString());
      // if (error.response != null && error.response.data != null) {
      //   // print('Errors: ${error.response.data}');
      //   if (error.response.data['errors'] != null) {
      //     // Handle multiple errors
      //     List<String> errors = List<String>.from(error.response.data['errors']);
      //     // print('Errors: $errors');
      //     emit( SignUpMeetingErrorState(errors.join(", ")));
      //   } else if (error.response.data['message'] != null) {
      //     // Handle single error message
      //     String errorMessage = error.response.data['message'];
      //     // print('Error: $errorMessage');
      //     emit(SignUpMeetingErrorState(errorMessage));
      //   } else {
      //     // print('Some thing went wrong , please try again');
      //     emit( SignUpMeetingErrorState('Some thing went wrong , please try again'));
      //   }
      // } else {
      //   // print(''Some thing went wrong , please try again' ');
      //   emit(SignUpMeetingErrorState('Some thing went wrong , please try again'));
      // }
    });
  }
  PostMeetingModel? postmeetingModel;
  void userPostMeeting({
   int? lecture,
    int? section,
  int? courseid,
}) {
    // CacheHelper.saveData(key:'cacheid', value: id);
    // cacheid=CacheHelper.getData(key: 'cacheid').toString();


print(lecture);
print(section);
print(courseid);
    emit(PostMeetingsLoadingState());
    DioHelper.postData(
      url: 'student/meeting_register/$courseid',
  token: token,
      data: {

  'lecture': lecture,
  'section': section,

  },
    ).then((value) {
      print(value?.data);

      // print(LOGIN);
      // print(value.toString());
      // Check if the value is not null
      PostMeetingModel postmeetingModel = PostMeetingModel.fromJson(value?.data);
      // print(value?.data['data']['token'].toString());
      // print(idModel!.data!);
      emit(PostMeetingsSuccessState(postmeetingModel));
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
      emit(PostMeetingsErrorState(error.toString()));
    });
  }

}