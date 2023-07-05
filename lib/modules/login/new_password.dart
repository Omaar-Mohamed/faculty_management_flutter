import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms_flutter/modules/login/redirect_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_flutter/shared/constants/constants.dart';
import 'package:sms_flutter/shared/network/local/cache_helper(shared_prefrenceds).dart';

import '../../layout/login/login_cubit/login_cubit.dart';
import '../../layout/login/login_cubit/login_states.dart';
class newPassword extends StatelessWidget {

  const newPassword({Key? key}) : super(key: key);

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
  bool _isPasswordVisible = false;
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController password2Controller = TextEditingController();
  bool _isPassword2Visible = false;



  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => LoginCubit() ,
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (BuildContext context, state) {

          if(state is NewPasswordSuccessState){
            if(state.newModel.status=="success"){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => redirectScreen()));
              Fluttertoast.showToast(
                  msg: 'New password ${state.newModel.status.toString()}',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0
              );

            }
            else if (state is NewPasswordErrorState){
              Fluttertoast.showToast(
                  msg: 'Error ${state.newModel.status.toString()}',
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


          } else   {
            // showToast(text: state.error, state: ToastStates.ERROR);
            // Fluttertoast.showToast(
            //     msg: 'Error wrong OTP',
            //     toastLength: Toast.LENGTH_SHORT,
            //     gravity: ToastGravity.BOTTOM,
            //     timeInSecForIosWeb: 5,
            //     backgroundColor: Colors.red,
            //     textColor: Colors.white,
            //     fontSize: 16.0
            // );
          }




        },
        builder: (BuildContext context, Object? state) {
          var newCubit=LoginCubit.get(context);
          return Container(
            constraints: const BoxConstraints(maxWidth: 300),
            child: Form(
              key: newCubit.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter password';
                      }

                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(_isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        )),
                  ),

                  _gap(),
                  TextFormField(

                    controller:password2Controller,

                    validator: (value2) {

                      if (value2 == null || value2.isEmpty) {
                        return 'Please enter password';
                      }

                      if (value2.length < 6) {
                        return 'Password must be at least 6 characters';
                      }

                      if(passwordController.text!=password2Controller.text){
                        return 'passwords donot match';}
                      if(passwordController.text==password2Controller.text) {
                        return null;
                      }


                    },
                    obscureText: ! _isPassword2Visible,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon( _isPassword2Visible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              _isPassword2Visible = !_isPassword2Visible;
                            });
                          },
                        )),
                  ),
                  _gap(),
                  // CheckboxListTile(
                  //   value: newCubit.rememberMe,
                  //   onChanged: (value) {
                  //     if (value == null) return;
                  //     // setState(() {
                  //     // });
                  //     newCubit.rememberMe = value;
                  //
                  //   },
                  //   title: const Text('Remember me'),
                  //   controlAffinity: ListTileControlAffinity.leading,
                  //   dense: true,
                  //   contentPadding: const EdgeInsets.all(0),
                  // ),
                  _gap(),
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(4)),
                  //     ),
                  //     child: const Padding(
                  //       padding: EdgeInsets.all(10.0),
                  //       child: Text(
                  //         'Submit',
                  //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  //       ),
                  //     ),
                  //     onPressed: () {
                  //       if (newCubit.formKey.currentState?.validate() ?? false) {
                  //         Navigator.push(context, MaterialPageRoute(builder: (context)=> const redirectScreen()));
                  //
                  //       }
                  //     },
                  //   ),
                  // ),
                  SizedBox(
                    width: double.infinity,
                    child: ConditionalBuilder(
                      condition: state is! NewPasswordLoadingState,
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
                          if (newCubit.formKey.currentState?.validate() ?? false) {
                            // // Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentGeneral()));
                            // LoginCubit.get(context).userLogin(
                            //   email: emailController.text,
                            //   password: passwordController.text,
                            // );
                              newCubit.userNewPassword(otp: cachecode, password: passwordController.text, password_confirmation:password2Controller.text);


                          }
                        },
                      ),
                      fallback: (context)=>Center(child: CircularProgressIndicator()) ,
                    ),
                  ),


                  //  newCubit.userNewPassword(otp: cachecode, password: passwordController.text, password_confirmation:password2Controller.text);


                  SizedBox(
                    height: 15.0,
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
// newCubit.userNewPassword(otp: cachecode, password: passwordController.text, password_confirmation:password2Controller.text);
