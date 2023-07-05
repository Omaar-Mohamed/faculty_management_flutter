import 'package:flutter/material.dart';

import '../../shared/components/components.dart';

class ChatList extends StatefulWidget {
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  List<String> chatNames = ['Chat 1', 'Chat 2', 'Chat 3', 'Chat 4'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: projectAppBar(context),
      body: ListView.builder(
        itemCount: chatNames.length,
        itemBuilder: (BuildContext context, int index) {
          return buildChatItem(context);
        },
      ),
    );
  }
}
