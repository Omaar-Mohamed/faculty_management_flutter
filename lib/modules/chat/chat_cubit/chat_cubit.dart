import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_states.dart';

class ChatCubit extends Cubit<ChatStates>{

  ChatCubit() : super(ChatinitialState());

  static ChatCubit get(context) => BlocProvider.of(context);

  TextEditingController textEditingController = TextEditingController();
  bool isButtonEnabled = false;

  List<Map<String, dynamic>> messages = [
    {'sender': 'user', 'message': 'Hi there!'},
    {'sender': 'bot', 'message': 'Hello! How can I assist you today?'},
  ];

  void enable() {
    if (textEditingController.text == '') {
      isButtonEnabled = false;
      emit(ChatChangeState());
    } else {
      isButtonEnabled = true;
      emit(ChatChangeState());

    }
  }

  void respone(){
    final message = textEditingController.text;
    textEditingController.clear();
    isButtonEnabled=false;
    emit(ChatWriteState());
    messages
        .add({'sender': 'user', 'message': message});
    messages.add({
      'sender': 'bot',
      'message':
      'Sorry, I am just a prototype and I cannot respond!'
    });
  }


}


//