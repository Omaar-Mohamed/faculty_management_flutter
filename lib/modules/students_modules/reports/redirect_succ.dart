import 'package:flutter/material.dart';
import 'package:sms_flutter/modules/students_modules/reports/reports.dart';
class RedirectSucc extends StatefulWidget {
  const RedirectSucc({Key? key}) : super(key: key);

  @override
  State<RedirectSucc> createState() => _RedirectSuccState();
}

class _RedirectSuccState extends State<RedirectSucc> {
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




                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        color: Colors.grey,


                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            "Report sent successfully",

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
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>  ReportsScreen()));


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
