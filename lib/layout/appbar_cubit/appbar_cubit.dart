import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_flutter/layout/appbar_cubit/appbar_states.dart';

import '../../models/notification_model/notification_model.dart';
import '../../shared/constants/constants.dart';
import '../../shared/network/remote/dio_helper.dart';

class AppbarCubit extends Cubit<AppBarStates> {
  AppbarCubit() : super(AppBarInitialState()) {

  }

  static AppbarCubit get(context) => BlocProvider.of(context);


  List<String?> notiId = [];

  NotificationModel? notificationModel;

  void getNotification() {
    print(token);
    emit(NotificationSuccessState());
    DioHelper.getData(url: 'notifications',
      token: token,
    ).then((value) {
      // print(value?.data.toString());
      notificationModel = NotificationModel.fromJson(value?.data);
      notiId.addAll(notificationModel!.data!.map((item) => item.id).toList());
      print(notiId);
      emit(NotificationSuccessState());
    }).catchError((error) {
      print(error.toString());
      if (error.response != null && error.response.data != null) {
        // print('Errors: ${error.response.data}');
        if (error.response.data['errors'] != null) {
          // Handle multiple errors
          List<String> errors = List<String>.from(
              error.response.data['errors']);
          // print('Errors: $errors');
          emit(NotificationErrorState(errors.join(", ")));
        } else if (error.response.data['message'] != null) {
          // Handle single error message
          String errorMessage = error.response.data['message'];
          // print('Error: $errorMessage');
          emit(NotificationErrorState(errorMessage));
        } else {
          // print('Some thing went wrong , please try again');
          emit(NotificationErrorState(
              'Some thing went wrong , please try again'));
        }
      } else {
        // print(''Some thing went wrong , please try again' ');
        emit(
            NotificationErrorState('Some thing went wrong , please try again'));
      }
    });
  }

  void postNofication(List <String?> notiId) {
    DioHelper.postData(
        url: 'notifications',
        data: {
          'notifications[]': notiId,
        },
    token: token,
    ).then((value) => {
      print(value?.data.toString()),
      emit(NotificationSuccessState()),
    }).catchError((error) {
      print(error.toString());
      if (error.response != null && error.response.data != null) {
        // print('Errors: ${error.response.data}');
        if (error.response.data['errors'] != null) {
          // Handle multiple errors
          List<String> errors = List<String>.from(
              error.response.data['errors']);
          // print('Errors: $errors');
          emit(NotificationErrorState(errors.join(", ")));
        } else if (error.response.data['message'] != null) {
          // Handle single error message
          String errorMessage = error.response.data['message'];
          // print('Error: $errorMessage');
          emit(NotificationErrorState(errorMessage));
        } else {
          // print('Some thing went wrong , please try again');
          emit(NotificationErrorState(
              'Some thing went wrong , please try again'));
        }
      } else {
        // print(''Some thing went wrong , please try again' ');
        emit(
            NotificationErrorState('Some thing went wrong , please try again'));
      }
    }


  );
}
}