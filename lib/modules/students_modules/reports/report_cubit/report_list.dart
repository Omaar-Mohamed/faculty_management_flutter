import 'package:flutter/material.dart';
import 'package:sms_flutter/shared/components/components.dart';
// import '../../shared/components/components.dart';
class ReportList extends StatelessWidget {
  TextEditingController _textEditingController = TextEditingController();
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
