import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms_flutter/layout/profile/profile_cubit.dart';
import 'package:sms_flutter/layout/profile/profile_states.dart';
import 'package:sms_flutter/layout/student_general/student_general.dart';
import 'package:sms_flutter/modules/students_modules/profile/profile_screen.dart';
import 'package:sms_flutter/modules/students_modules/setting/setting_screen.dart';
import 'package:sms_flutter/shared/components/components.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sms_flutter/shared/constants/constants.dart';

class editScreen extends StatefulWidget {
  final String type;
  final String fname;
  final String sname;
  final String phone;
  final String address;
  final String gender;
  final String username;
  final String id;
  final String national_id;
  final String email;

  const editScreen(
      {Key? key,
      required this.type,
      required this.phone,
      required this.username,
      required this.sname,
      required this.address,
      required this.national_id,
      required this.fname,
      required this.gender,
      required this.id,
      required this.email})
      : super(key: key);

  @override
  State<editScreen> createState() => _editScreenState();
}

class _editScreenState extends State<editScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting UI",
      home: EditProfilePage(
          type: widget.type,
          address: widget.address,
          username: widget.username,
          sname: widget.sname,
          phone: widget.phone,
          national_id: widget.national_id,
          id: widget.id,
          email: widget.email,
          gender: widget.gender,
          fname: widget.fname),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  final String type;
  final String fname;
  final String sname;
  final String phone;
  final String address;
  final String gender;
  final String username;
  final String id;
  final String national_id;
  final String email;
  const EditProfilePage(
      {Key? key,
      required this.type,
      required this.phone,
      required this.username,
      required this.sname,
      required this.address,
      required this.national_id,
      required this.fname,
      required this.gender,
      required this.id,
      required this.email})
      : super(key: key);
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _imageFile;
  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      _imageFile = pickedFile != null ? File(pickedFile.path) : null;
    });
  }

  _showOption(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Make a choice'),
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.image),
                      title: Text('Gallery'),
                      onTap: () => _pickImage(ImageSource.gallery),
                    ),
                    ListTile(
                      leading: Icon(Icons.camera_alt),
                      title: Text('Camera'),
                      onTap: () => _pickImage(ImageSource.camera),
                    ),
                  ],
                ),
              ),
            ));
  }

  bool showPassword = false;
  var nat_idController = TextEditingController();
  var fnameController = TextEditingController();
  var phoneController = TextEditingController();
  var genderController = TextEditingController();
  var snameController = TextEditingController();
  var idController = TextEditingController();
  var emailController = TextEditingController();
  var usernameController = TextEditingController();
  var addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ProfileCubit(),

      // create: (BuildContext context)=>ProfileCubit()..userChange(national_id: nat_idController.text,
      //   address: addressController.text,
      //   id: idController.text,
      //   email: emailController.text,
      //   fname:fnameController.text ,
      //   gender: genderController.text,
      //   phone: phoneController.text,
      //   sname: snameController.text,
      //   username: usernameController.text,
      // ),

      child: BlocConsumer<ProfileCubit, ProfileStatus>(
        listener: (BuildContext context, state) {
          if (state is ChangeProfileSuccessState) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileScreen(type: widget.type)));
            Fluttertoast.showToast(
                msg: 'change profile ${state.changeModel?.status.toString()}',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          } else if (state is ChangeProfileErrorState) {
            // showToast(text: state.error, state: ToastStates.ERROR);
            Fluttertoast.showToast(
                msg: 'Error ',
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 5,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        },
        builder: (BuildContext context, Object? state) {
          var changeCubit = ProfileCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 1,
              // leading: IconButton(
              //   icon: Icon(
              //     Icons.arrow_back,
              //     color: Colors.blue,
              //   ),
              //   onPressed: () {
              //     // Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen()));
              //     navigateAndFinsh(
              //         context,
              //         ProfileScreen(
              //           type: widget.type,
              //         ));
              //   },
              // ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.settings,
                    color: Colors.blue,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => settingScreen()));
                  },
                ),
              ],
            ),
            body: Container(
              padding: EdgeInsets.only(left: 16, top: 25, right: 16),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: ListView(
                  children: [
                    Text(
                      "Edit Profile",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 130,
                            height: 130,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 4,
                                  color: Theme.of(context)
                                      .scaffoldBackgroundColor),
                              boxShadow: [
                                BoxShadow(
                                    spreadRadius: 2,
                                    blurRadius: 10,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(0, 10))
                              ],
                              shape: BoxShape.circle,
                            ),
                            child: CircleAvatar(
                              // foregroundImage:BoxFit.cover,
                              radius: double.infinity,
                              child: IconButton(
                                onPressed: () {},
                                icon: _imageFile != null
                                    ? Image.file(_imageFile!)
                                    : Icon(Icons.person),
                                iconSize: 100,
                                // fit: BoxFit.cover,

                                //
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    // width: 2,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  color: Colors.blue,
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.camera_alt),
                                  color: Colors.white,
                                  alignment: Alignment.center,
                                  onPressed: () {
                                    _showOption(context);
                                  },
                                ),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 35,
                    ),
                    // buildTextField( 'id',widget.id, false, idController),
                    // buildTextField(
                    //     "national-id", widget.national_id,  false, nat_idController),
                    buildTextField("fname",widget.fname,  false, fnameController),
                    buildTextField("sname",widget.sname,  false, snameController),
                    buildTextField("phone", widget.phone, false, phoneController),
                    buildTextField(
                        "address",widget.address, false, addressController),
                    // buildTextField("gender", widget.gender, false, genderController),
                    buildTextField("email", widget.email, false, emailController),
                    buildTextField(
                        "username", widget.username, false, usernameController),

                    // buildTextField("Specialization", "Data Science", false),
                    // buildTextField("Phone", "01121528257", false),
                    // buildTextField("E-mail", "alexd@gmail.com", false),
                    // buildTextField("Id", "203165", false),
                    //
                    // buildTextField("Password", "********", true),

                    SizedBox(
                      height: 35,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: Container(
                            color: Colors.red,
                            child: OutlinedButton(
                              // padding: EdgeInsets.symmetric(horizontal: 50),
                              // RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(20)),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ProfileScreen(type: widget.type)));
                              },
                              child: Text("Cancel",
                                  style: TextStyle(
                                      fontSize: 14,
                                      letterSpacing: 2.2,
                                      color: Colors.white)),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 20),
                          child: ConditionalBuilder(
                            condition:state is! ChangeProfileLoadingState ,
                            builder: (BuildContext context) {return Container(
                              color: Colors.blue,
                              child: OutlinedButton(
                                // padding: EdgeInsets.symmetric(horizontal: 50),
                                // RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(20)),
                                onPressed: () {
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfileScreen(type: widget.type,)));
                                  changeCubit.userChange(
                                    // national_id: nat_idController.text==''?widget.national_id:nat_idController.text,
                                    address: addressController.text==''?widget.address:addressController.text,

                                    // id: idController.text==''?widget.id:idController.text,
                                    email: emailController.text==''?widget.email:emailController.text,
                                    fname: fnameController.text==''?widget.fname:fnameController.text,
                                    // gender: genderController.text==null?widget.gender:genderController.text,
                                    phone: phoneController.text==''?widget.phone:phoneController.text,
                                    sname: snameController.text==''?widget.sname:snameController.text,
                                    username: usernameController.text==''?widget.username:usernameController.text,
                                  );
                                  fname = fnameController.text==''?widget.fname:fnameController.text;
                                  lname = snameController.text==''?widget.sname:snameController.text;
                                  cacheEmail = emailController.text==''?widget.email:emailController.text;
                                },
                                child: Text("Save",
                                    style: TextStyle(
                                        fontSize: 14,
                                        letterSpacing: 2.2,
                                        color: Colors.white)),
                              ),
                            );  },
                            fallback: (BuildContext context) {return Center(child: CircularProgressIndicator());  },

                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }




  Widget buildTextField(String labelText, String placeholder,
      bool isPasswordTextField, TextEditingController zontroller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        controller: zontroller,
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        showPassword = !showPassword;
                      });
                    },
                    icon: Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    ),
                  )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
