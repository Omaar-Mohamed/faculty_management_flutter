import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms_flutter/modules/login/code_screen.dart';
import 'package:sms_flutter/modules/login/send_message_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import '../../layout/login/login_cubit/login_cubit.dart';
import '../../layout/login/login_cubit/login_states.dart';

class idScreen extends StatefulWidget {
  const idScreen({Key? key}) : super(key: key);

  @override
  State<idScreen> createState() => _idScreenState();
}

class _idScreenState extends State<idScreen> {
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

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
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
            )
          ],
        ),
      ),
    );


  }
}


class _FormContent extends StatefulWidget {
  const _FormContent({Key? key}) : super(key: key);

  @override
  State<_FormContent> createState() => __FormContentState();
}

class __FormContentState extends State<_FormContent> {


  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit() ,
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (BuildContext context, state) {
          if(state is ForgetPasswordSuccessState){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => codeScreen()));
            Fluttertoast.showToast(
                msg: 'ForgetPassword ${state.idModel.status.toString()}',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
          } else if (state is ForgetPasswordErrorState) {
            // showToast(text: state.error, state: ToastStates.ERROR);
            Fluttertoast.showToast(
                msg: 'Error wrong national id',
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
          var idCubit=LoginCubit.get(context);

          return Container(

            constraints: const BoxConstraints(maxWidth: 300),
            child: Form(
              key: idCubit.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: idCubit.idController,
                    validator: (value) {
// add id validation
                      if (value == null || value.isEmpty) {
                        return 'Please enter some numbers';

                      }


                      bool idValid = RegExp(
                          r"^[0-9.0-9]")
                          .hasMatch(value);
                      if (!idValid) {
                        return 'Please enter a valid id';
                      }


                      return null;
                    },
                    decoration: const InputDecoration(
                      labelText: 'National-id',
                      hintText: 'Enter your id',
                      prefixIcon: Icon(Icons.perm_identity_rounded),
                      border: OutlineInputBorder(),
                    ),
                  ),

                  _gap(),
// CheckboxListTile(
//   value: _rememberMe,
//   onChanged: (value) {
//     if (value == null) return;
//     setState(() {
//       _rememberMe = value;
//     });
//   },
//   title: const Text('Remember me'),
//   controlAffinity: ListTileControlAffinity.leading,
//   dense: true,
//   contentPadding: const EdgeInsets.all(0),
// ),
// _gap(),
                  SizedBox(
                    width: double.infinity,
                    child: ConditionalBuilder(
                      condition: state is! ForgetPasswordLoadingState,
                      builder:(context)=>ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2)),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          if (idCubit.formKey.currentState?.validate() ?? false) {
                            // // Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentGeneral()));
                            // LoginCubit.get(context).userLogin(
                            //   email: emailController.text,
                            //   password: passwordController.text,
                            // );
                            idCubit.userForget(
                              id: idCubit.idController.text,

                            );

                          }
                        },
                      ),
                      fallback: (context)=>Center(child: CircularProgressIndicator()) ,
                    ),
                  ),


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

