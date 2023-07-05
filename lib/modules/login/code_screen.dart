import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms_flutter/modules/login/change_password.dart';
import 'package:sms_flutter/modules/login/id_screen.dart';
import 'package:sms_flutter/modules/login/new_password.dart';
import 'package:sms_flutter/modules/login/send_message_screen.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_flutter/shared/constants/constants.dart';
import 'package:sms_flutter/shared/network/local/cache_helper(shared_prefrenceds).dart';

import '../../layout/login/login_cubit/login_cubit.dart';
import '../../layout/login/login_cubit/login_states.dart';
class codeScreen extends StatefulWidget {
  const codeScreen({Key? key}) : super(key: key);
// ddd
  @override
  State<codeScreen> createState() => _codeScreenState();
}

class _codeScreenState extends State<codeScreen> {
  @override
  Widget build(BuildContext context) {

    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Scaffold(
        body: SingleChildScrollView(
          child: Expanded(
            child: Center(
                child: isSmallScreen
                    ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    _Logo(),
                    _FormContent(),
                  ],
                )
                    : Container(
                  padding: const EdgeInsets.all(32.0),
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Row(
                    children: const [
                      Expanded(child: _Logo()),
                      Expanded(
                        child: Center(child: _FormContent()),
                      ),
                    ],
                  ),
                )),
          ),
        ));
  }
}

class _Logo extends StatelessWidget {
  const _Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.all(50.0),
          child: Image(
            image: AssetImage('assets/images/logo.png'),
            height: 200.0,
            width: 200.0,
          ),
        ),

        // FlutterLogo(size: isSmallScreen ? 100 : 200),
        Padding(
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
        SizedBox(height: 20.0,),
        Container(
          child: Text(
            'Enter the code',
            style: TextStyle(
              fontWeight: FontWeight.bold,fontSize: 20.0,
            ),
          ),

        ),
        SizedBox(height: 20.0,),

      ],
    );

  }
}


class _FormContent extends StatefulWidget {
  const _FormContent({Key? key}) : super(key: key);

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {

  var codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit() ,
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (BuildContext context, state) {
          if(state is CodeSuccessState){
            if(state.codeModel.status=="success"){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => newPassword()));
              CacheHelper.saveData(key: 'otp', value: codeController.text);
              Fluttertoast.showToast(
                  msg: 'Code ${state.codeModel.status.toString()}',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );

            }
            else if (state is CodeErrorState) {
              Fluttertoast.showToast(
                  msg: 'Error ${state.codeModel.status.toString()}',
                  // msg: state.error,
                  // msg: state.,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }


          } else if(state is CodeErrorState) {
            // showToast(text: state.error, state: ToastStates.ERROR);
            Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }

        },
        builder: (BuildContext context, Object? state) {
          var codeCubit=LoginCubit.get(context);

          return Container(

            constraints: const BoxConstraints(maxWidth: 300),
            child: Form(
              key: codeCubit.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: codeController,
                    validator: (value) {

                      if (value == null || value.isEmpty) {
                        return 'Please enter some numbers';

                      }


                      bool idValid = RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9]")
                          .hasMatch(value);
                      if (!idValid) {
                        return 'Please enter a valid code';
                      }


                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'OTP',
                      hintText: 'Enter your code',
                      prefixIcon: Icon(Icons.message),
                      border: OutlineInputBorder(),
                    ),
                  ),

                  _gap(),

                  SizedBox(
                    width: double.infinity,
                    child: ConditionalBuilder(
                      condition: state is! CodeLoadingState,
                      builder:(context)=>ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'Submit',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),

                        ),
                        onPressed: () {
                          if (codeCubit.formKey.currentState?.validate() ?? false) {
                            // // Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentGeneral()));
                            // LoginCubit.get(context).userLogin(
                            //   email: emailController.text,
                            //   password: passwordController.text,
                            // );
                            codeCubit.userCode(
                              code: codeController.text,
                              //   password: codeCubit.passwordController.text,
                              // password_confirmation: codeCubit.password2Controller.text,


                            );
                          }
                        },
                      ),
                      fallback: (context)=>Center(child: CircularProgressIndicator()) ,
                    ),
                  ),

                  _gap(),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     TextButton(
                  //       onPressed: () {
                  //         // Navigator.push(context, MaterialPageRoute(builder: (context)=> const idScreen()));
                  //
                  //         codeCubit.userResent(
                  //   code: codeCubit.codeController.text,                            // password_confirmation: codeCubit.password2Controller.text,
                  //
                  //
                  //         );
                  //         print('Resend code');
                  //       },
                  //       child: Text('Resend code'),
                  //     )
                  //   ],
                  // ),
                  TextButton(

                    onPressed: () {
                      codeCubit.userResent(
                        id: cacheid,
                      );

                      Fluttertoast.showToast(
                          msg: 'resent code success ',
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          timeInSecForIosWeb: 5,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    },
                    child: Text('Resend code'),
                  )


                ],
              ),
            ),
          );
        },

      ),
    );




  }

  Widget _gap() => const SizedBox(height: 16);
}
