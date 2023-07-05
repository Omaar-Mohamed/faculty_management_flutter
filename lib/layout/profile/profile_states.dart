import 'package:sms_flutter/models/login_model/edit_profile_model.dart';
import 'package:sms_flutter/models/login_model/login_model.dart';
import 'package:sms_flutter/models/login_model/profile_model.dart';
import 'package:sms_flutter/modules/students_modules/profile/edit_profile_screen.dart';

abstract class ProfileStatus{}
class ProfileInitialState extends ProfileStatus{}



class ProfileLoadingState extends ProfileStatus{}
class ProfileSuccessState extends ProfileStatus
{
  late final ProfileModel? profileModel;
  ProfileSuccessState(this.profileModel);
}
class ProfileErrorState extends ProfileStatus
{
  final String error;
  ProfileErrorState(this.error);
}
class ChangeProfileLoadingState extends ProfileStatus{}
class ChangeProfileSuccessState extends ProfileStatus
{
  late final ChangeProfileModel? changeModel;
  ChangeProfileSuccessState(this.changeModel);
}
class  ChangeProfileErrorState extends ProfileStatus
{
  final String error;
  ChangeProfileErrorState(this.error);
}