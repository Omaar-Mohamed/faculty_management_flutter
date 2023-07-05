import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_flutter/layout/student_general/student_general.dart';
import 'package:sms_flutter/modules/students_modules/sections_register/meeting_cubit/meeting_cubit.dart';
import 'package:sms_flutter/modules/students_modules/sections_register/meeting_cubit/meeting_status.dart';
import 'package:sms_flutter/modules/students_modules/sections_register/signup_meeting.dart';
import 'package:sms_flutter/shared/components/components.dart';
import 'package:sms_flutter/layout/professor_general/professor_general.dart';

class MeetingsRegister extends StatelessWidget {

  final String? type;
  MeetingsRegister({Key? key, this.type }) : super(key: key);

  // final List<Map<String, String>> Meetings = [
  //   {'name': 'oop', 'image': 'assets/images/oop.png','lectures': 'Available lectures : 2','sections': 'Available sections : 4'},
  //   {'name': 'oop', 'image': 'assets/images/oop.png','lectures': 'Available lectures : 2','sections': 'Available sections : 4'},
  //   {'name': 'oop', 'image': 'assets/images/oop.png','lectures': 'Available lectures : 2','sections': 'Available sections : 4'},
  //   {'name': 'oop', 'image': 'assets/images/oop.png','lectures': 'Available lectures : 2','sections': 'Available sections : 4'},
  // ];

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context)=>MeetingsCubit()..getMeetings(),
      child: BlocConsumer<MeetingsCubit,MeetingsStates>(
        listener: (BuildContext context, Object? state) {  },
        builder: (BuildContext context , state){
          var meetingsCubit=MeetingsCubit.get(context);
          return Scaffold(
            appBar: projectAppBar(context),
            drawer: StudentGeneral(),
            body: ConditionalBuilder(
              condition: MeetingsCubit.get(context).meetingModel?.data !=null,
              builder: (BuildContext context) =>   Column(
            children: [
            Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Sign up Meetings',
              style:TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ) ,

            ),
          ),
          Expanded(
          child: ListView.builder(
          physics: BouncingScrollPhysics(),

          itemCount:meetingsCubit.meetingModel!.data!.length,
          itemBuilder: (context, index) {
          return InkWell(
          onTap: ()
          {
          navigateTo(context, SignupMeetingScreen(
            name: meetingsCubit.meetingModel!.data![index].course![0].name! ,
          courseid:meetingsCubit.meetingModel!.data![index].id! ,
          // coursename: meetingsCubit.meetingModel!.data![index].course![0].name!.toString(),
          ));
          },
          child: Container(

          margin: EdgeInsets.all(10.0),
          height: 110.0,
          decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
          BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          offset: Offset(0, 3),
          ),
          ],
          ),
          child: Row(
          children: [
          Padding(
          padding: const EdgeInsets.only(left: 8,right: 8),
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
          ClipRRect(
          borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          // topRight: Radius.circular(16.0),
          ),
          child: Image.asset(
            'assets/images/oop.png',
          height: 80.0,
          width: 90,
          // fit: BoxFit.cover,
          ),
          ),

          ],
          ),
          ),
          Padding(
          padding: const EdgeInsets.all(8.0),
          child: Expanded(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Expanded(
              child: Text(
              // Meetings[index]['name']!,

              meetingsCubit.meetingModel!.data![index].course![0].name!.toString(),
              style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
              ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            SizedBox(
            height: 7,
            ),
            Expanded(
              child: Text(
              meetingsCubit.meetingModel!.data![index].course![0].courseCode!.toString(),
              style: TextStyle(
              fontSize: 10.0,
              fontWeight: FontWeight.normal,
              ),
              ),
            ),
            SizedBox(
            height: 5,
            ),
            Expanded(
              child: Text(
                'Lecture: ${MeetingsCubit.get(context).meetingModel!.data![index].registered?.lecture !=null ? 'Lecture registered!' : 'Not registered'}',
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            SizedBox(
            height: 5,
            ),

            Expanded(
              child: Text(
                'Section: ${MeetingsCubit.get(context).meetingModel!.data![index].registered?.section !=null ? 'Section registered!' : 'Not registered'}',
                style: TextStyle(
                  fontSize: 10.0,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            ),
            ],
            ),
          ),
          ),



          ],
          ),

          ),

          );
          },
          ),
          ),
          ],
          ),








              fallback: (context)=>Center(child: CircularProgressIndicator()),

            ),
          );

        },
      ),
    );

  }
}
