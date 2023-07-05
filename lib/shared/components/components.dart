import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sms_flutter/models/course_model/assignment_detail_model.dart';
import 'package:sms_flutter/modules/chat/chat_list.dart';
import 'package:sms_flutter/modules/notifications/notifications_screen.dart';
import 'package:sms_flutter/modules/students_modules/courses_register/course_register_cubit/course_register_cubit.dart';
import 'package:sms_flutter/modules/students_modules/courses_register/course_register_cubit/course_register_states.dart';

import '../../modules/chat/chat_screen.dart';
import '../../modules/students_modules/courses_register/courses_register_screen.dart';

Widget articalItem(article, context) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120.0,
            height: 120.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: DecorationImage(
                image: NetworkImage('${article['urlToImage']}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${article['title']}',
                    style: Theme.of(context).textTheme.bodyLarge,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${article['publishedAt']}',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

Widget myDivider() => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Divider(
          height: 10,
          thickness: 2,
          color: Colors.grey,
          indent: 10,
          endIndent: 10,
        ),
      ),
    );

Widget articleBuilder(list, context) => ConditionalBuilder(
    condition: list.length > 0,
    builder: (context) => ListView.separated(
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) => articalItem(list[index], context),
        separatorBuilder: (context, index) => myDivider(),
        itemCount: list.length),
    fallback: (context) => Center(child: CircularProgressIndicator()));

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onSubmit,
  Function? onChange,
  Function? onTap,
  bool isclicable = true,
  required Function validator,
  required String label,
  required IconData prefix,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: (s) {
        onSubmit!(s);
      },
      onChanged: (s) {
        onChange!(s);
      },
      // validator
      onTap: () {
        onTap!();
      },
      validator: (s) {
        validator(s);
      },
      enabled: isclicable,
      decoration: InputDecoration(
        label: Text(label),
        prefixIcon: Icon(prefix),
        border: OutlineInputBorder(),
      ),
    );

void navigateTo(context, widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

void navigateAndFinsh(
    context,
    widget,
    )=>
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder:(context)=>widget,
        ),
        (route) => false,

        );
void navigateAndReplace(
    context,
    widget,
    )=>
    Navigator.pushReplacement(context, MaterialPageRoute(
      builder:(context)=>widget,
    ),

    );

Widget defaultSearch(String Text) => Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.horizontal(),
            borderSide: BorderSide(width: 0.8),
          ),
          hintText: Text,

          prefixIcon: Icon(Icons.search),

          // suffixIcon:IconButton(
          //   icon: Icon(Icons.clear),
          //   onPressed: (){},
          // )
        ),
      ),
    );

Widget courseDetailsItem(
        {required String name,
        required String image,
        Widget? widget,
        context}) =>
    Expanded(
      child: InkWell(
        splashColor: Colors.black12,
        child: Ink(
          height: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10.0,
              ),
              color: HexColor('D9D9D9')),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: AssetImage(image),
                  ),
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                name,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        onTap: () {
          navigateTo(context, widget);
        },
        hoverColor: Colors.cyan,
      ),
    );
Widget CourseRegisterItem(
        {required name,
        required image,
        required creditHours,
        required docName,
          required bool selected,
           int? courseID,
          List <int?>? selectedList,
        context,
        }) {
  bool  tapped=false;

  return BlocProvider(
    create: (BuildContext context) { return CourseRegisterCubit(); },
    child: BlocConsumer<CourseRegisterCubit,CourseRegesterStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        var cubit = CourseRegisterCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: Expanded(
            child: InkWell(
              splashColor: Colors.black12,
              child: Ink(

                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      image,
                      width: 100,
                      height: 100,
                    ),
                    SizedBox(height: 10),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.03,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      docName,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      creditHours,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                // cubit.tapped(tapped);
                selected?
                showModalBottomSheet(
                    context: context,
                    builder:(BuildContext context){
                      return Container(
                        height: MediaQuery.of(context).size.height /4 ,
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              name,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24.0,
                              ),
                            ),
                            Text(
                              'are you sure you want to unselect this course?!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 16.0,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                BlocProvider(
                                  create: (BuildContext context) => CourseRegisterCubit(),
                                 child: BlocConsumer<CourseRegisterCubit,CourseRegesterStates>(
                                    listener: (BuildContext context, state) {  },
                                    builder: (BuildContext context, Object? state) {
                                      var cubit = CourseRegisterCubit.get(context);
                                      return ElevatedButton(
                                        onPressed: (){
                                          print(selectedList);
                                          // print(courseID);
                                          selectedList!.remove(courseID);
                                          print(selectedList);
                                          cubit.submitCourseRegester(selectedList);
                                          Navigator.pop(context);
                                          navigateTo(context, CoursesRegisterScreen());
                                        // cubit.submitCourseRegester(course_id: '63');

                                        },
                                        child: Text('Yes'),
                                      );
                                    },

                                  ),
                                ),
                                OutlinedButton(
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                  child: Text('NO'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );



                    }
                ) :
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: MediaQuery.of(context).size.height /4 ,
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 24.0,
                            ),
                          ),
                          Text(
                            'course description',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              BlocProvider(
                                create: (BuildContext context) => CourseRegisterCubit(),
                                child: BlocConsumer<CourseRegisterCubit,CourseRegesterStates>(
                                  listener: (BuildContext context, state) {  },
                                  builder: (BuildContext context, Object? state) {
                                    var cubit = CourseRegisterCubit.get(context);
                                    return ElevatedButton(
                                      onPressed: (){
                                        selectedList?.add(courseID);
                                        print(selectedList);
                                        // selectedList[courseID];
                                        // print(selectedList);
                                        // cubit.selectedCourses.add(courseID as int);
                                        print(courseID);
                                        cubit.submitCourseRegester(selectedList);
                                        Navigator.pop(context);
                                        if(selectedList!.isEmpty) {
                                          navigateTo(
                                              context, CoursesRegisterScreen());
                                        }

                                      },
                                      child: Text('Select'),
                                    );
                                  },

                                ),
                              ),
                              OutlinedButton(
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                                child: Text('cancel'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              hoverColor: Colors.black12,
            ),
          ),
        );
      },

    ),
  );
}
PreferredSizeWidget projectAppBar(contex) => AppBar(
      title: Center(child: Text("SMS")),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(Icons.chat),
            onPressed: () {
              navigateTo(contex, ChatList());
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: IconButton(
            icon: const Icon(Icons.notifications),
            onPressed: () {
              navigateTo(contex, NotificationsScreen());
            },
          ),
        ),
      ],
    );

Widget buildChatItem(BuildContext context) => InkWell(
      onTap: () {
        navigateTo(context, ChatScreen());
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20.0,
              backgroundImage: AssetImage('assets/images/profile.jpg'),
            ),
            SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Omar Mohamed',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'normal text from the sender ',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );

Widget buildCourseItem(String courseName, String imagePath) => Container(
      margin: EdgeInsets.only(top: 16.0),
      height: 200.0,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 6.0,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
            child: Image.asset(
              imagePath,
              height: 120.0,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              courseName,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );




// Widget buildCourseItem(String courseName, String imagePath) => Container(
//       margin: EdgeInsets.only(top: 16.0),
//       height: 200.0,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(16.0),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.3),
//             blurRadius: 6.0,
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(16.0),
//               topRight: Radius.circular(16.0),
//             ),
//             child: Image.asset(
//               imagePath,
//               height: 120.0,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Text(
//               courseName,
//               style: TextStyle(
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );


