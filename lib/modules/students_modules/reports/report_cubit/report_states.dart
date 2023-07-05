import 'package:sms_flutter/models/report_model/create_ticket_model.dart';
import 'package:sms_flutter/models/report_model/get_ticket_categories.dart';
import 'package:sms_flutter/models/report_model/get_ticket_message.dart';
import 'package:sms_flutter/models/report_model/get_tickets_model.dart';
import 'package:sms_flutter/models/report_model/report_chat_model.dart';

abstract class ReportStates {}
class ReportInitialState extends ReportStates {}
class ReportChangeState extends ReportStates {}

class ReportWriteState extends ReportStates {}
class ReportPendState extends ReportStates {}
class ReportLoadingState extends ReportStates{}
class ReportSearchState extends ReportStates{}
class ReportSearchSuccessState extends ReportStates{}
class ReportSearchErrorState extends ReportStates{
  final String error ;
  ReportSearchErrorState(this.error);
}



class GetCategoriesInitialState extends ReportStates{}

class GetCategoriesLoadingState extends ReportStates{}

class GetCategoriesSuccessState extends ReportStates{
  late final GetTicketModel? catModel;
  GetCategoriesSuccessState(this.catModel);
}

class GetCategoriesErrorState extends ReportStates{
  final String error;
  GetCategoriesErrorState(this.error);
}
class GetTicketsInitialState extends ReportStates{}

class  GetTicketsLoadingState extends ReportStates{}

class GetTicketsSuccessState extends ReportStates{
  late final GetTicketsModel? ticketsModel;
  GetTicketsSuccessState(this.ticketsModel);
}

class  GetTicketsErrorState extends ReportStates{
  final String error;
  GetTicketsErrorState(this.error);
}
//ticket
class  GetTicketLoadingState extends ReportStates{}

class GetTicketSuccessState extends ReportStates{
  late final GetTicketModel? ticketModel;
  GetTicketSuccessState(this.ticketModel);
}

class  GetTicketErrorState extends ReportStates{
  final String error;
  GetTicketErrorState(this.error);
}
//create
class  CreateTicketLoadingState extends ReportStates{}

class CreateTicketSuccessState extends ReportStates{
  late final CreateTicketModel? createModel;
  CreateTicketSuccessState(this.createModel);
}

class  CreateTicketErrorState extends ReportStates{
  final String error;
  CreateTicketErrorState(this.error);
}
//chat ticket
class  TicketChatLoadingState extends ReportStates{}

class TicketChatSuccessState extends ReportStates{
  late final TicketMessageModel? messageModel;
  TicketChatSuccessState(this.messageModel);
}

class  TicketChatErrorState extends ReportStates{
  final String error;
  TicketChatErrorState(this.error);
}
class PreviousReportState extends ReportStates{

}
class NextReportState extends ReportStates{

}

