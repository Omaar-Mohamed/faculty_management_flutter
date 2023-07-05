import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_flutter/modules/chat/chat_cubit/chat_cubit.dart';
import 'package:sms_flutter/modules/chat/chat_cubit/chat_states.dart';

class ChatScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ChatCubit(),
      child: BlocConsumer<ChatCubit,ChatStates>(
        listener: (BuildContext context, Object? state) {  },
        builder: (BuildContext context , state){
          var chatCubit=ChatCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Flutter Chat'),
            ),
            body: Column(
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
                            message['message'],
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
                          controller: chatCubit.textEditingController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type a message',
                          ),

                          onChanged:(value)
                          {

                            chatCubit.enable();

                          } ,

                        ),
                      ),
                      IconButton(
                        onPressed: chatCubit.isButtonEnabled
                            ? () {
                          chatCubit.respone();
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
          );
        },
      ),
    );
  }

}

