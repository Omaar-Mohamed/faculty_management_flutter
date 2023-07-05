import 'package:sms_flutter/models/channel/channels_model.dart';
import 'package:sms_flutter/models/login_model/code_model.dart';
import 'package:sms_flutter/models/login_model/forget_password.dart';
import 'package:sms_flutter/models/login_model/login_model.dart';
import 'package:sms_flutter/models/login_model/change_password.dart';
import 'package:sms_flutter/models/login_model/reset_password.dart';

import '../../../models/course_model/course_model.dart';

abstract class LoginStates{}

class DrawerInitialState extends LoginStates{}

class ChangeDrawer extends LoginStates{}

class ChangeDrawerColor extends LoginStates{}
//Login
class LoginLoadingState extends LoginStates{}
class LoginSuccessState extends LoginStates
{
  late final LoginModel loginModel;
  LoginSuccessState(this.loginModel);
}
class LoginErrorState extends LoginStates
{
  final String error;
  LoginErrorState(this.error);
}
//Forget password
class  ForgetPasswordLoadingState extends LoginStates{}

class ForgetPasswordSuccessState extends LoginStates{
  late final ForgetPasswordModel idModel;
  ForgetPasswordSuccessState(this.idModel);
 }
class ForgetPasswordErrorState extends LoginStates
{
  final String error;
  ForgetPasswordErrorState(this.error);
}
//Code
class  CodeLoadingState extends LoginStates{}
class CodeSuccessState extends LoginStates{
  late final CodeModel codeModel;
  CodeSuccessState(this.codeModel);
}
class CodeErrorState extends LoginStates
{
  final String error;
  CodeErrorState(this.error);
}
//New password

class NewPasswordLoadingState extends LoginStates{}
class  NewPasswordSuccessState extends LoginStates{
  late final NewPasswordModel newModel;
  NewPasswordSuccessState(this.newModel);
}
class NewPasswordErrorState extends LoginStates
{
  final String error;
  NewPasswordErrorState(this.error);
}
class ResetLoadingState extends LoginStates{}
class  ResetSuccessState extends LoginStates{
  late final ResetModel resetModel;
  ResetSuccessState(this.resetModel);
}
class ResetErrorState extends LoginStates
{
  final String error;
  ResetErrorState(this.error);
}
class LogoutSuccessState extends LoginStates{
}
class LogoutErrorState extends LoginStates{}

class CourseInitialState extends LoginStates{}

class CourseLoadingState extends LoginStates{}

class CourseSuccessState extends LoginStates{
  late final CourseModel courseModel;
  CourseSuccessState(this.courseModel);
}

class CourseErrorState extends LoginStates{
  final String error;
  CourseErrorState(this.error);
}

class ChannelsInitialState extends LoginStates{}
class ChannelsLoadingState extends LoginStates{}
class ChannelsSuccessState extends LoginStates{
  late final ChannelModel channelModel;
  ChannelsSuccessState(this.channelModel);
}
class ChannelsErrorState extends LoginStates{
  final String error;
  ChannelsErrorState(this.error);
}