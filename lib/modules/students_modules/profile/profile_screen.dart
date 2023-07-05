import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_flutter/layout/profile/profile_cubit.dart';
import 'package:sms_flutter/layout/profile/profile_states.dart';
import 'package:sms_flutter/layout/student_general/student_general.dart';
import 'package:sms_flutter/modules/students_modules/profile/edit_profile_screen.dart';
import 'package:sms_flutter/shared/constants/constants.dart';

import '../../../layout/professor_general/professor_general.dart';
import '../../../models/student_drawer_sections/student_drawer_section.dart';
import '../../../shared/components/components.dart';

class ProfileScreen extends StatefulWidget {
  final String type;
  const ProfileScreen ({Key? key,required this.type}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>ProfileCubit()..getProfile(),

      child: BlocConsumer<ProfileCubit,ProfileStatus>(
        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {
          var profileCubit=ProfileCubit.get(context);
          return Scaffold(
            appBar:projectAppBar(context),
            drawer: widget.type == "student" ? StudentGeneral() : ProfessorGeneral(),
            body: ConditionalBuilder(

              condition:ProfileCubit.get(context).profileModel!.data !=null,
              builder: (BuildContext context) =>
                Container(
                padding: EdgeInsets.only(left: 16, top: 25, right: 16),
                child: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  child: ListView(
                    children: [
                      Text(
                        "My Profile",
                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
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
                                      color: Theme.of(context).scaffoldBackgroundColor),
                                  boxShadow: [
                                    BoxShadow(
                                        spreadRadius: 2,
                                        blurRadius: 10,
                                        color: Colors.black.withOpacity(0.1),
                                        offset: Offset(0, 10))
                                  ],
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage('https://sms.gxadev.me'+profileCubit.profileModel!.data!.user!.avatar!))),
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
                                      color: Theme.of(context).scaffoldBackgroundColor,
                                    ),
                                    color: Colors.blue,
                                  ),
                                  child: IconButton(

                                    icon: const Icon(Icons.edit),color: Colors.white,alignment: Alignment.center,
                                    onPressed: () {
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> editScreen(type: widget.type,
                                          address: profileCubit.profileModel!.data!.user!.address.toString(),
                                          username: profileCubit.profileModel!.data!.user!.username.toString(),
                                          sname: profileCubit.profileModel!.data!.user!.sname.toString(),
                                          phone: profileCubit.profileModel!.data!.user!.phone.toString(),
                                          national_id: profileCubit.profileModel!.data!.user!.national_id.toString(),
                                          id: profileCubit.profileModel!.data!.user!.national_id.toString(),
                                          email: profileCubit.profileModel!.data!.user!.email.toString(),
                                          gender: profileCubit.profileModel!.data!.user!.gender.toString(),
                                          fname: profileCubit.profileModel!.data!.user!.fname.toString(),







                                      )));

                                    },
                                  ),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 35,
                      ),
                      // buildTextField("Id",ProfileCubit.get(context).profileModel!.data!.user!.id.toString(), false),

                      buildTextField("fName",profileCubit.profileModel!.data!.user!.fname.toString(), false),
                      buildTextField("sName",profileCubit.profileModel!.data!.user!.sname.toString(), false),
                      buildTextField("E-mail",profileCubit.profileModel!.data!.user!.email.toString(), false),
                      buildTextField("Username",profileCubit.profileModel!.data!.user!.username.toString(), false),
                      buildTextField("phone",profileCubit.profileModel!.data!.user!.phone.toString(), false),
                      buildTextField("gender",profileCubit.profileModel!.data!.user!.gender.toString(), false),
                      buildTextField("Address",profileCubit.profileModel!.data!.user!.address.toString(), false),

                      buildTextField("National-id",profileCubit.profileModel!.data!.user!.national_id.toString(), false),
                      buildTextField("Role",profileCubit.profileModel!.data!.user!.role.toString(), false),





//
//
//                     buildTextField("Username", "Sha3toos", false),
//
//                     buildTextField("Type", "Professor", false),
// // buildTextField("Department", "Computer Science", false),
// // buildTextField("Specialization", "Data Science", false),
//                     buildTextField("Phone", "01121528257", false),
//                     buildTextField("E-mail", "alexd@gmail.com", false),
//                     buildTextField("Id", "203165", false),
//                     buildTextField("National-Id", "20316569", false),




                      SizedBox(
                        height: 35,
                      ),

                    ],
                  ),
                ),
              ) ,
              fallback: (context)=>Center(child: CircularProgressIndicator()),
            ),
          );

        },

      ),
    );

  }

  Widget buildTextField(

      String labelText, String placeholder, bool isPasswordTextField) {

    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(

        enableInteractiveSelection: false,
        readOnly: true,

        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
              onPressed: () {
                // setState(() {
                //   showPassword = !showPassword;
                // });
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
