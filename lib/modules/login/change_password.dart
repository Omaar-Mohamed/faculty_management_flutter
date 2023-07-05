import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms_flutter/layout/login/login_cubit/login_cubit.dart';
import 'package:sms_flutter/layout/login/login_cubit/login_states.dart';
import 'package:sms_flutter/modules/login/redirect_screen.dart';

class PasswordScreen extends StatefulWidget {
  String otp;
  PasswordScreen({Key? key,required this.otp}) : super(key: key);

  @override
  _PasswordScreenState createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  String? _password;
  String? _confirmPassword;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (BuildContext context) => LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (BuildContext context, state) {
          // if(state is NewPasswordSuccessState){
          // if(state.newModel.status=="success"){
          // Navigator.pushReplacement(
          // context,
          // MaterialPageRoute(
          // builder: (context) => redirectScreen()));
          // Fluttertoast.showToast(
          // msg: 'New password ${state.newModel.status.toString()}',
          // toastLength: Toast.LENGTH_SHORT,
          // gravity: ToastGravity.BOTTOM,
          // timeInSecForIosWeb: 5,
          // backgroundColor: Colors.green,
          // textColor: Colors.white,
          // fontSize: 16.0
          // );
          //
          // }
          // else{
          // Fluttertoast.showToast(
          // msg: 'Error ${state.newModel.status.toString()}',
          // toastLength: Toast.LENGTH_SHORT,
          // gravity: ToastGravity.BOTTOM,
          // timeInSecForIosWeb: 5,
          // backgroundColor: Colors.green,
          // textColor: Colors.white,
          // fontSize: 16.0
          // );
          // }
          //
          //
          // } else   {
          // // showToast(text: state.error, state: ToastStates.ERROR);
          // // Fluttertoast.showToast(
          // //     msg: 'Error wrong OTP',
          // //     toastLength: Toast.LENGTH_SHORT,
          // //     gravity: ToastGravity.BOTTOM,
          // //     timeInSecForIosWeb: 5,
          // //     backgroundColor: Colors.red,
          // //     textColor: Colors.white,
          // //     fontSize: 16.0
          // // );
          // }
          //
          //
        },
        builder: (BuildContext context, Object? state) {
          var newCubit = LoginCubit.get(context);
          return Padding(
            padding: EdgeInsets.all(16.0),
            child: Form(
              key: newCubit.formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _password = value;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter the password again';
                      } else if (value != _password) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _confirmPassword = value;
                      });
                    },
                  ),
                  SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: ConditionalBuilder(
                      condition: state is! ForgetPasswordLoadingState,
                      builder:(context)=>Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2)),
                          ),
                          child: Text(
                            'Submit',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                           newCubit.userNewPassword(otp: widget.otp, password: _passwordController.text, password_confirmation: _confirmPasswordController.text);


                          },
                        ),
                      ),
                      fallback: (context)=>CircularProgressIndicator() ,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
}
