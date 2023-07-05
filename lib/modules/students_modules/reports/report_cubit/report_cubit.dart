import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_flutter/models/report_model/create_ticket_model.dart';
import 'package:sms_flutter/models/report_model/get_ticket_categories.dart';
import 'package:sms_flutter/models/report_model/get_ticket_message.dart';
import 'package:sms_flutter/models/report_model/get_tickets_model.dart';
import 'package:sms_flutter/models/report_model/report_chat_model.dart';
import 'package:sms_flutter/modules/students_modules/reports/report_cubit/report_states.dart';
import 'package:sms_flutter/shared/constants/constants.dart';
import 'package:sms_flutter/shared/network/end_points.dart';
import 'package:sms_flutter/shared/network/remote/dio_helper.dart';

class ReportCubit extends Cubit<ReportStates> {

  ReportCubit() : super(GetCategoriesInitialState()){
    catModel = GetTicketModel();
    getTicketCat();
  }
  static ReportCubit get(context) => BlocProvider.of(context);





   GetTicketModel? catModel;
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  void getTicketCat()
  {
    // print(token);
    emit(GetCategoriesLoadingState());
    DioHelper.getData(url: GETTICKETSCATEGORIES,
      token: token,
    ).then((value)
    {

      // print(value?.data.toString());
      catModel = GetTicketModel.fromJson(value?.data);
      emit(GetCategoriesSuccessState(catModel));


    }).catchError((error){
      print(error.toString());
      if (error.response != null && error.response.data != null) {
        // print('Errors: ${error.response.data}');
        if (error.response.data['errors'] != null) {
          // Handle multiple errors
          List<String> errors = List<String>.from(error.response.data['errors']);
          // print('Errors: $errors');
          emit(GetCategoriesErrorState(errors.join(", ")));
        } else if (error.response.data['message'] != null) {
          // Handle single error message
          String errorMessage = error.response.data['message'];
          // print('Error: $errorMessage');
          emit(GetCategoriesErrorState(errorMessage));
        } else {
          // print('Some thing went wrong , please try again');
          emit(GetCategoriesErrorState('Some thing went wrong , please try again'));
        }
      } else {
        // print(''Some thing went wrong , please try again' ');
        emit(GetCategoriesErrorState('Some thing went wrong , please try again'));
      }
    });
  }
  GetTicketsModel? ticketsModel;
int? page ;
  void getTickets( int? page)
  {

    print(token);
    emit(GetTicketsLoadingState());
    DioHelper.getData(url: GETTICKETS,
      query: {
        "page": page,
      },
      token: token,
    ).then((value)
    {

      print(value?.data.toString());
      ticketsModel = GetTicketsModel.fromJson(value?.data);
      emit(GetTicketsSuccessState(  ticketsModel));


    }).catchError((error){
      print(error.toString());
      if (error.response != null && error.response.data != null) {
        // print('Errors: ${error.response.data}');
        if (error.response.data['errors'] != null) {
          // Handle multiple errors
          List<String> errors = List<String>.from(error.response.data['errors']);
          // print('Errors: $errors');
          emit( GetTicketsErrorState(errors.join(", ")));
        } else if (error.response.data['message'] != null) {
          // Handle single error message
          String errorMessage = error.response.data['message'];
          // print('Error: $errorMessage');
          emit( GetTicketsErrorState(errorMessage));
        } else {
          // print('Some thing went wrong , please try again');
          emit( GetTicketsErrorState('Some thing went wrong , please try again'));
        }
      } else {
        // print(''Some thing went wrong , please try again' ');
        emit( GetTicketsErrorState('Some thing went wrong , please try again'));
      }
    });
  }
  TicketMessageModel? messageModel;


  void getChatMessage(int? id)
  {
    print(token);
    print(id);
    emit(TicketChatLoadingState());
    DioHelper.getData(url: 'tickets/$id',
      token: token,
    ).then((value)
    {

      print(value?.data.toString());
      messageModel = TicketMessageModel.fromJson(value?.data);
      emit(TicketChatSuccessState(  messageModel));


    }).catchError((error){
      print(error.toString());
      if (error.response != null && error.response.data != null) {
        // print('Errors: ${error.response.data}');
        if (error.response.data['errors'] != null) {
          // Handle multiple errors
          List<String> errors = List<String>.from(error.response.data['errors']);
          // print('Errors: $errors');
          emit(TicketChatErrorState(errors.join(", ")));
        } else if (error.response.data['message'] != null) {
          // Handle single error message
          String errorMessage = error.response.data['message'];
          // print('Error: $errorMessage');
          emit( TicketChatErrorState(errorMessage));
        } else {
          // print('Some thing went wrong , please try again');
          emit( TicketChatErrorState('Some thing went wrong , please try again'));
        }
      } else {
        // print(''Some thing went wrong , please try again' ');
        emit( TicketChatErrorState('Some thing went wrong , please try again'));
      }
    });
  }
  var ticketvalue;
  CreateTicketModel? createModel;

  void SubmitTicket({
    required String cat_id ,
    required String description,
    required String title,

  }) {
    // CacheHelper.saveData(key:'cacheid', value: id);
    // cacheid=CacheHelper.getData(key: 'cacheid').toString();
    print(cat_id);
    print(title);
    print(description);

    emit(CreateTicketLoadingState());
    DioHelper.postData(
      url: CREATETICKET,
      token: token,

      data: {

        'cat_id': cat_id,
        'title': title,
        'description':description,
      },
    ).then((value) {
      print(value?.data);

      // print(LOGIN);
      // print(value.toString());
      // Check if the value is not null
      CreateTicketModel createModel = CreateTicketModel.fromJson(value?.data);
      // print(value?.data['data']['token'].toString());
      // print(idModel!.data!);
      emit(CreateTicketSuccessState(createModel));
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
      emit(CreateTicketErrorState(error.toString()));
    });
  }

  GetTicketModel? ticketModel;
   int? index ;
  void getTicket()
  {
    print(token);
    emit(GetTicketLoadingState());
    DioHelper.getData(url: GETTICKET,
      token: token,
    ).then((value)
    {

      print(value?.data.toString());
      ticketModel = GetTicketModel.fromJson(value?.data);
      emit(GetTicketSuccessState(  ticketModel));


    }).catchError((error){
      print(error.toString());
      if (error.response != null && error.response.data != null) {
        // print('Errors: ${error.response.data}');
        if (error.response.data['errors'] != null) {
          // Handle multiple errors
          List<String> errors = List<String>.from(error.response.data['errors']);
          // print('Errors: $errors');
          emit( GetTicketErrorState(errors.join(", ")));
        } else if (error.response.data['message'] != null) {
          // Handle single error message
          String errorMessage = error.response.data['message'];
          // print('Error: $errorMessage');
          emit( GetTicketErrorState(errorMessage));
        } else {
          // print('Some thing went wrong , please try again');
          emit( GetTicketErrorState('Some thing went wrong , please try again'));
        }
      } else {
        // print(''Some thing went wrong , please try again' ');
        emit( GetTicketErrorState('Some thing went wrong , please try again'));
      }
    });
  }

  TextEditingController textEditingController = TextEditingController();
  bool isButtonEnabled = false;
  String dropdownvalue = 'choose your report type';
  var searchController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var items =  ['choose your report type','General report','technical issue','report user',];
  String? selectedValue;
  List<dynamic> titles = [

    "Ticket 1",
    "Ticket  2",
    "Ticket 3",
    "Ticket 4",
    "Ticket 5",
    "Ticket 6",];
  final subtitles = [
    "11/3/2023",
    "11/3/2023",
    "11/3/2023",
    "11/3/2023",
    "11/3/2023",
    "11/3/2023",
    // "11/3/2023",
  ];
  final List<String> list2 = <String>["General", "Technical", "Billing", "Sales","Other"];

  List<dynamic> search=[];
  List<Map<String, dynamic>> messages = [
    {'sender': 'user', 'message': 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley','date':'1/11/2000'},
    // {'sender': 'bot', 'message': 'Hello! How can I assist you today?'},

  ];

  void enable() {
    if (textEditingController.text == '') {
      isButtonEnabled = false;
      emit(ReportChangeState());
    } else {
      isButtonEnabled = true;
      emit(ReportChangeState());

    }
  }

  void respone2(){
    final message = textEditingController.text;
    textEditingController.clear();
    isButtonEnabled=false;
    emit(ReportWriteState());
    messages
        .add({'sender': 'user', 'message': message});
    messages.add({
      'sender': 'bot',
      'message':
      'Sorry, I am just a prototype and I cannot respond!'
    });

  }
  void getSearch(String value){


    emit(ReportLoadingState());
    titles=[];
  }
  void dropdown2(String value){
    dropdownvalue = value;
    emit(ReportChangeState());
  }
  final int itemsPerPage = 10;


  List<String> itemList = List<String>.generate(100, (index) => 'Item ${index + 1}');
  //
  // List<String> getPaginatedItems() {
  //   // final startIndex = (page - 1) * itemsPerPage;
  //   final endIndex = startIndex + itemsPerPage;
  //   return itemList.sublist(startIndex, endIndex);
  // }

  void nextPage(int page) {
    if (page < 10) {
      page++;
    }
    emit(NextReportState());

  }

  void previousPage(int page) {
    if (page > 1) {
      page--;
    }
    emit(PreviousReportState());
  }

  int get totalPages => (50 / itemsPerPage).ceil();
  // final paginatedItems = getPaginatedItems();
  //
  // void fetchData() {
  //   // Make the API call
  //   // ...
  //
  //   // Handle the response
  //   DioHelper.getData(url: yourApiUrl).then((response) {
  //     // Extract the new page number from the response
  //     int newPage = response['pagination']['current_page'];
  //
  //     // Update the currentPage variable
  //     setState(() {
  //       currentPage = newPage;
  //     });
  //
  //     // Process the response data
  //     // ...
  //   }).catchError((error) {
  //     // Handle the error
  //     // ...
  //   });
  // }

}