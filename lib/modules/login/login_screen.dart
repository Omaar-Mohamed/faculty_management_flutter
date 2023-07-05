import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pusher_client/pusher_client.dart';
import 'package:sms_flutter/layout/student_general/student_general.dart';
import 'package:sms_flutter/modules/login/id_screen.dart';
import 'package:sms_flutter/modules/professor_modules/professor_schedule_module/prof_schedule_screen.dart';
import 'package:sms_flutter/modules/students_modules/schedules/schedules_screen.dart';
import 'package:sms_flutter/shared/components/components.dart';
import 'package:sms_flutter/shared/network/local/cache_helper(shared_prefrenceds).dart';
import 'package:sms_flutter/shared/network/remote/pusher.dart';

import '../../layout/login/login_cubit/login_cubit.dart';
import '../../layout/login/login_cubit/login_states.dart';
import '../../shared/constants/constants.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {

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
          )
        ],
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
  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => LoginCubit()..printToken() ,
      child: BlocConsumer<LoginCubit,LoginStates>(
        listener: (BuildContext context, state) {
          if (state is LoginSuccessState) {

            if(state.loginModel.data!.user!.role=='student'){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => SchedulesScreen(type:'student' ,)));
            }else if(state.loginModel.data!.user!.role=='professor'){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SchedulesScreen(type: 'professor',)));
            }
            Fluttertoast.showToast(
                msg: 'Login ${state.loginModel.status.toString()}',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0
            );
          } else if (state is LoginErrorState) {
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
          var loginCubit=LoginCubit.get(context);
          return SingleChildScrollView(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: emailController,
                      validator: (value) {
                        // add email validation
                        if (value == null || value.isEmpty) {
                          return 'Please enter email';
                        }

                        bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value);
                        if (!emailValid) {
                          return 'Please enter a valid email';
                        }

                        return null;
                      },
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        prefixIcon: Icon(Icons.email_outlined),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    _gap(),
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
                    CheckboxListTile(
                      value: _rememberMe,
                      onChanged: (value) {
                        if (value == null) return;
                        setState(() {
                          _rememberMe = value;
                        });
                      },
                      title: const Text('Remember me'),
                      controlAffinity: ListTileControlAffinity.leading,
                      dense: true,
                      contentPadding: const EdgeInsets.all(0),
                    ),
                    _gap(),
                    SizedBox(
                      width: double.infinity,
                      child: ConditionalBuilder(
                        condition: state is! LoginLoadingState,
                        builder:(context)=>ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4)),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(10.0),
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),

                          ),
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              // // Navigator.push(context, MaterialPageRoute(builder: (context)=> StudentGeneral()));
                              // LoginCubit.get(context).userLogin(
                              //   email: emailController.text,
                              //   password: passwordController.text,
                              // );
                              loginCubit.userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );

                            }
                          },
                        ),
                        fallback: (context)=>Center(child: CircularProgressIndicator()) ,
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=> const idScreen()));


                            print('forgot password');
                          },
                          child: Text('Forgot password'),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },

      ),
    );
  }

  Widget _gap() => const SizedBox(height: 16);
}