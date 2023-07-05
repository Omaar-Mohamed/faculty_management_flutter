import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_flutter/layout/profile/profile_states.dart';
import 'package:sms_flutter/models/login_model/edit_profile_model.dart';
import 'package:sms_flutter/models/login_model/login_model.dart';
import 'package:sms_flutter/models/login_model/profile_model.dart';
import 'package:sms_flutter/shared/constants/constants.dart';
import 'package:sms_flutter/shared/network/end_points.dart';
import 'package:sms_flutter/shared/network/local/cache_helper(shared_prefrenceds).dart';
import 'package:sms_flutter/shared/network/remote/dio_helper.dart';

class ProfileCubit extends Cubit<ProfileStatus>{
  late ProfileModel? profileModel;
  ProfileCubit() : super(ProfileInitialState()){
    profileModel = ProfileModel();

    // getProfile();
  }
  static ProfileCubit get(context) => BlocProvider.of(context);




  void getProfile()
  {
    print(token);
    emit(ProfileLoadingState());
    DioHelper.getData(url: PROFILE,
      token: token,
    ).then((value)
    {

      print(value?.data.toString());
      profileModel = ProfileModel.fromJson(value?.data);
      emit(ProfileSuccessState(profileModel));


    }).catchError((error){
      print(error.toString());
      if (error.response != null && error.response.data != null) {
        // print('Errors: ${error.response.data}');
        if (error.response.data['errors'] != null) {
          // Handle multiple errors
          List<String> errors = List<String>.from(error.response.data['errors']);
          // print('Errors: $errors');
          emit( ProfileErrorState(errors.join(", ")));
        } else if (error.response.data['message'] != null) {
          // Handle single error message
          String errorMessage = error.response.data['message'];
          // print('Error: $errorMessage');
          emit( ProfileErrorState(errorMessage));
        } else {
          // print('Some thing went wrong , please try again');
          emit( ProfileErrorState('Some thing went wrong , please try again'));
        }
      } else {
        // print(''Some thing went wrong , please try again' ');
        emit( ProfileErrorState('Some thing went wrong , please try again'));
      }
    });
  }
  void userChange({
  // String? national_id,
 String? email,
 String? username,
 // String? gender,
    String? address,
String? fname,
 String? sname,
 // String? id,
String? phone,
  }) {
    // CacheHelper.saveData(key:'cacheid', value: id);
    // cacheid=CacheHelper.getData(key: 'cacheid').toString();
    // print(national_id);
    print(token);
    print(address);
    print(fname);
    print(sname);
    // print(id);
    print(email);
    print(username);
    print(phone);
    // print(gender);



    emit(ChangeProfileLoadingState());
    // if(){}
    DioHelper.postData(
      url: CHANGEPROFILEINFO,
      data: {

        // 'id': id,
        'email':email,
        'username':username,
        'phone':phone,
        'address':address,
        // 'gender':gender,
        // 'national_id':national_id,

        'sname':sname,
        'fname':fname,

      },
      token: token,

    ).then((value) {
      print(value?.data);

      // print(LOGIN);
      // print(value.toString());
      // Check if the value is not null
      ChangeProfileModel changeModel = ChangeProfileModel.fromJson(value?.data);
      // print(value?.data['data']['token'].toString());
      // print(idModel!.data!);
      emit(ChangeProfileSuccessState(changeModel));
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
          emit(ChangeProfileErrorState(errors.join(", ")));
        } else if (error.response.data['message'] != null) {
          // Handle single error message
          String errorMessage = error.response.data['message'];
          // print('Error: $errorMessage');
          emit(ChangeProfileErrorState(errorMessage));
        } else {
          // print('Some thing went wrong , please try again');
          emit(ChangeProfileErrorState('Some thing went wrong , please try again'));
        }
      } else {
        // print(''Some thing went wrong , please try again' ');
        emit(ChangeProfileErrorState('Some thing went wrong , please try again'));
      }
      print(error.toString());
      emit(ChangeProfileErrorState(error.toString()));
    });
  }




}