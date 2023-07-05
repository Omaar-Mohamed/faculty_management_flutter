import 'package:sms_flutter/models/meetings_model/meetings_model.dart';
import 'package:sms_flutter/models/meetings_model/post_meeting_model.dart';
import 'package:sms_flutter/models/meetings_model/sign_up_meeting.dart';

abstract class MeetingsStates {}
class  MeetingsLoadingState extends MeetingsStates{}
class  MeetingsInitialState extends MeetingsStates{}

class MeetingsSuccessState extends MeetingsStates{
  late final MeetingsModel? meetingModel;
  MeetingsSuccessState(this.meetingModel);
}

class  MeetingsErrorState extends MeetingsStates{
  final String error;
  MeetingsErrorState(this.error);
}
//sign up meeting
class  SignUpMeetingLoadingState extends MeetingsStates{}

class SignUpMeetingSuccessState extends MeetingsStates{
  late final SignUpMeetingModel? signmeetingModel;
  SignUpMeetingSuccessState(this.signmeetingModel);
}

class  SignUpMeetingErrorState extends MeetingsStates{
  final String error;
  SignUpMeetingErrorState(this.error);
}
//post meeting
class  PostMeetingsLoadingState extends MeetingsStates{}

class PostMeetingsSuccessState extends MeetingsStates{
  late final PostMeetingModel? postmeetingModel;
  PostMeetingsSuccessState(this.postmeetingModel);
}

class  PostMeetingsErrorState extends MeetingsStates{
  final String error;
  PostMeetingsErrorState(this.error);
}
