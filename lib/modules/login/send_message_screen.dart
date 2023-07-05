import 'package:flutter/material.dart';
import 'package:sms_flutter/modules/login/code_screen.dart';

class sendMessage extends StatefulWidget {
  const sendMessage({Key? key}) : super(key: key);

  @override
  State<sendMessage> createState() => _sendMessageState();
}

class _sendMessageState extends State<sendMessage> {


  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(

      body: Container(

        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(


                child: Column(
                  mainAxisSize: MainAxisSize.min,

                  children: [


                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(


                      child:   Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          "Welcome to Student Management System ",
                          textAlign: TextAlign.center,
                          style: isSmallScreen
                              ? Theme.of(context).textTheme.headline5
                              : Theme.of(context)
                              .textTheme
                              .headline4
                              ?.copyWith(color: Colors.black),
                        ),



                      ),
                      ),
                    ),
                    SizedBox(
                      height: 40.0,
                    ),


                    Container(
                      child: Text(
                        'Select a Method to send you the code',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,                    fontSize: 20.0,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    //           if(formKey.currentState!.validate(){
                    // print('email');
                    // print('password')}),
                    Container(
                      width: double.infinity,
                      color: Colors.grey,
                      child: MaterialButton(onPressed: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=> const codeScreen()));

                      },
                        height: 60.0,
                        child: Text('Send massage to xxxxxxxxx90',style:TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold

                        ) ,),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.grey,
                      child: MaterialButton(onPressed: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context)=> const codeScreen()));

                      },
                        height: 60.0,
                        child: Text('Send mail to omrxxxxx@gmail.com',style:TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold

                        ) ,),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),

    );
  }
}
