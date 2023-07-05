import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sms_flutter/modules/login/login_screen.dart';


class redirectScreen extends StatefulWidget {
  const redirectScreen({Key? key}) : super(key: key);

  @override
  State<redirectScreen> createState() => _redirectScreenState();
}

class _redirectScreenState extends State<redirectScreen> {
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

                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/images/logo.png'),
                      height: 200.0,
                      width: 200.0,
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(


                       child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Student Management System ",
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


                        // SizedBox(height: 20.0,),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        color: Colors.grey,


                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Password reset successfully",

                            textAlign: TextAlign.center,
                            style: isSmallScreen
                                ? Theme.of(context).textTheme.headline5
                                : Theme.of(context)
                                .textTheme
                                .headline5
                                ?.copyWith(color: Colors.black),

                          ),



                        ),
                      ),
                    ),


                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const loginScreen()));


                            print('Redirect in (countdown)');
                          },
                          child: Text('Redirect in (countdown)'),
                        )
                      ],
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
