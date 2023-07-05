import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sms_flutter/modules/students_modules/reports/report_cubit/report_cubit.dart';
import 'package:sms_flutter/modules/students_modules/reports/report_cubit/report_states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_flutter/modules/students_modules/reports/report_cubit/report_states.dart';
class TicketScreen extends StatelessWidget {
  int? id ;
  TicketScreen({Key? key,required this.id }) : super(key: key);


  TextEditingController _textEditingController = TextEditingController();
  //

  @override
  Widget build(BuildContext context) {
    int? index;
    // int ? id;
    List<Map<String, dynamic>> messages = [
      {'sender': 'user', 'message': 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley','date':'1/11/2000'},
      // {'sender': 'bot', 'message': 'Hello! How can I assist you today?'},

    ];


    return BlocProvider(
      create: (BuildContext context)=>ReportCubit()..getChatMessage(id),
      child: BlocConsumer<ReportCubit,ReportStates>(
        listener: (BuildContext context, Object? state) {  },
    builder: (BuildContext context , state,){
    var chatCubit=ReportCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Support Chat'),
        actions: [
          //
          // ConditionalBuilder(
          //   condition:ReportCubit.get(context).ticketModel?.data! !=null,
          //   fallback: (context)=>Center(child: CircularProgressIndicator()),
          //   builder: (BuildContext context) =>
          //       PopupMenuButton<String>(
          //
          //         itemBuilder: (BuildContext context) {
          //           return [
          //             PopupMenuItem<String>(
          //               value: 'option1',
          //               child: Text(""),
          //             ),
          //             PopupMenuItem<String>(
          //               value: 'option2',
          //               child: Text('Option 2'),
          //             ),
          //             PopupMenuItem<String>(
          //               value: 'option3',
          //               child: Text('Option 3'),
          //             ),
          //           ];
          //         },
          //         onSelected: (String value) {
          //           // Handle menu item selection here
          //           print('Selected: $value');
          //         },
          //       ),
          //
          // ),
        ],
      ),
      body: ConditionalBuilder(
        condition:ReportCubit.get(context).messageModel?.data! !=null,
        builder: (BuildContext context) => Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: chatCubit.messages.length,
                  itemBuilder: (context, index) {
                    final message = chatCubit.messages[index];
                    return Container(
                      alignment: message['sender'] == 'user'
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                          color: message['sender'] == 'user'
                              ? Colors.blue
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                       'Title :'+   chatCubit.messageModel!.data![0].title!.toString()+'\n'+
                           'Description :'+chatCubit.messageModel!.data![0].description!.toString()+'\n'+
                           'Category :'+ chatCubit.messageModel!.data![0].category!.toString()+'\n'+'\n'+
                           'Created At :'+  DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse( chatCubit.messageModel!.data![0].createdAt!))+'\n',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        enabled: chatCubit.messageModel!.data![0].status! =='closed'?false:true,
                        controller: chatCubit.textEditingController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type a message',
                        ),

                        onChanged:(value)
                        {

                          chatCubit.enable(

                          );

                        } ,

                      ),
                    ),
                    IconButton(
                      onPressed: chatCubit.isButtonEnabled
                          ? () {
                        chatCubit.respone2();
                      }
                          : null,
                      icon: Icon(
                        Icons.send,
                      ),
                      color: chatCubit.isButtonEnabled ? Colors.blue : Colors.grey,
                    ),
                  ],
                ),
              ),
            ],
          ),

        fallback: (context)=>Center(child: CircularProgressIndicator()),

      ),
    );
    },
      ),
    );
  }

}

