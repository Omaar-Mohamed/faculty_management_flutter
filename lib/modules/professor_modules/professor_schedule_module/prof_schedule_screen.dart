// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sms_flutter/layout/professor_general/professor_general.dart';
// import 'package:sms_flutter/layout/student_general/student_general.dart';
// import 'package:sms_flutter/modules/professor_modules/professor_schedule_module/prof_make_online_meeting_screen.dart';
// import 'package:sms_flutter/shared/components/components.dart';
// import 'package:sms_flutter/modules/students_modules/schedules/shedules_cubit/schedules_cubit.dart';
// import 'package:sms_flutter/modules/students_modules/schedules/shedules_cubit/schedules_states.dart';
// class ProfScheduleScreen extends StatelessWidget {
//   const ProfScheduleScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     return BlocProvider(
//       create: (BuildContext context)=>SchedulesCubit(),
//       child: BlocConsumer<SchedulesCubit,SchedulesStates>(
//         listener: (BuildContext context, Object? state) {  },
//         builder: (BuildContext context , state){
//           var schedulesCubit=SchedulesCubit.get(context);
//           return Scaffold(
//             appBar: projectAppBar(context),
//             drawer: ProfessorGeneral(),
//             body: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//
//                     child:
//                     SizedBox(
//
//                       height: 50,
//                       child: SingleChildScrollView(
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                           children: List.generate(
//                             SchedulesCubit().item.length,
//                                 (index) => GestureDetector(
//                               onTap: () {
//                                 schedulesCubit.scroll(index);
//                               },
//                               child: Container(
//                                 width: 45,
//                                 height: 100,
//
//
//
//                                 margin: EdgeInsets.symmetric(horizontal: 10),
//
//                                 decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
//                                   color:schedulesCubit.selectedIndex == index
//                                       ? Colors.blueGrey[900]
//                                       : Colors.white,
//
//                                   border: Border.all(
//                                       color: schedulesCubit.selectedIndex == index
//                                           ? Colors.white
//                                           : Colors.black,
//                                       width: 1.0,
//                                       style: BorderStyle.solid
//                                   ),
//                                 ),
//
//
//
//                                 child: Center(
//                                   child: Column(
//                                     children: [
//                                       Center(
//                                         child: Text(
//                                           'sat ',
//                                           // ${index + 1}
//
//                                           style: TextStyle(
//                                             color:schedulesCubit.selectedIndex == index
//                                                 ? Colors.white
//                                                 : Colors.black,
//
//                                             fontSize: 15,
//                                           ),
//                                         ),
//                                       ),
//                                       Text(
//                                         '25 ',
//                                         // ${index + 1}
//
//                                         style: TextStyle(
//                                           color: schedulesCubit.selectedIndex == index
//                                               ? Colors.white
//                                               : Colors.black,
//
//                                           fontSize: 15,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Text(
//                     'Day ${schedulesCubit.selectedIndex + 1}',
//
//                     style: TextStyle(fontSize: 20),
//                   ),
//
//
//                   Expanded(
//                     child: ListView.builder(
//                       physics: BouncingScrollPhysics(),
//
//                       itemCount: schedulesCubit.item[schedulesCubit.selectedIndex].length,
//                       itemBuilder: (BuildContext context, int index) {
//                         // final item = _items[_selectedIndex][index];
//                         return Card(
//                           // color: Colors.grey,
//                           elevation: 10,
//                           margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                           child: Container(
//
//                             padding: EdgeInsets.all(10),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               crossAxisAlignment: CrossAxisAlignment.center,
//                               children: [
//                                 // Expanded(child: ClipRRect(
//                                 //   // child: Image(
//                                 //   //   image: NetworkImage(element["thumbnailUrl"]),
//                                 //   //   fit: BoxFit.cover,
//                                 //   // ) ,
//                                 //   borderRadius: BorderRadius.all(Radius.circular(5)),
//                                 // )),
//                                 Expanded(
//                                   flex: 5,
//                                   child: Container(
//                                     padding: EdgeInsets.only(bottom: 10),
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Padding(
//                                           padding: EdgeInsets.only(left: 10, right: 10),
//                                           child: Text(
//                                             schedulesCubit.item[schedulesCubit.selectedIndex][index]['title'],
//                                             style: TextStyle(
//                                                 fontSize: 16, fontWeight: FontWeight.bold),
//                                             maxLines: 2,
//                                             overflow: TextOverflow.ellipsis,
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding:
//                                           EdgeInsets.only(left: 10, right: 10, top: 5),
//                                           child: Row(
//                                             mainAxisSize: MainAxisSize.max,
//                                             mainAxisAlignment: MainAxisAlignment.start,
//                                             children: [
//                                               Icon(
//                                                 Icons.watch_later_outlined,
//                                                 // color: Colors.blueGrey,
//                                                 size: 16,
//                                               ),
//                                               Container(
//                                                 margin: EdgeInsets.only(left: 10),
//                                                 child: Text(schedulesCubit.item[schedulesCubit.selectedIndex][index]['time']),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding:
//                                           EdgeInsets.only(left: 10, right: 10, top: 5),
//                                           child: Row(
//                                             mainAxisSize: MainAxisSize.max,
//                                             mainAxisAlignment: MainAxisAlignment.start,
//                                             children: [
//                                               Icon(
//                                                 Icons.calendar_today,
//                                                 color: Colors.grey,
//                                                 size: 16,
//                                               ),
//                                               Container(
//                                                 margin: EdgeInsets.only(left: 10),
//                                                 child: Text(schedulesCubit.item[schedulesCubit.selectedIndex][index]['day']),
//                                                 // ${element['']}
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding:
//                                           EdgeInsets.only(left: 10, right: 10, top: 5),
//                                           child: Row(
//                                             mainAxisSize: MainAxisSize.max,
//                                             mainAxisAlignment: MainAxisAlignment.start,
//                                             children: [
//                                               Icon(
//                                                 Icons.location_on_sharp,
//                                                 color: Colors.grey,
//                                                 size: 16,
//                                               ),
//                                               Container(
//                                                 margin: EdgeInsets.only(left: 10),
//                                                 child: Text(schedulesCubit.item[schedulesCubit.selectedIndex][index]['location']),
//                                                 // ${element['']}
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding:
//                                           EdgeInsets.only(left: 10, right: 10, top: 5),
//                                           child: Row(
//                                             mainAxisSize: MainAxisSize.max,
//                                             mainAxisAlignment: MainAxisAlignment.start,
//                                             children: [
//                                               Icon(
//                                                 Icons.account_circle_sharp,
//                                                 color: Colors.grey,
//                                                 size: 16,
//                                               ),
//                                               Container(
//                                                 margin: EdgeInsets.only(left: 10),
//                                                 child: Text(schedulesCubit.item[schedulesCubit.selectedIndex][index]['teacher']),
//                                                 // ${element['']}
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Padding(
//                                           padding:
//                                           EdgeInsets.only(left: 10, right: 10, top: 5),
//                                           child: Row(
//                                             mainAxisSize: MainAxisSize.max,
//                                             mainAxisAlignment: MainAxisAlignment.start,
//                                             children: [
//                                               Icon(
//                                                 Icons.book,
//                                                 color: Colors.grey,
//                                                 size: 16,
//                                               ),
//                                               Container(
//                                                 margin: EdgeInsets.only(left: 10),
//                                                 child: Text('Lecture'),
//                                                 // ${element['']}
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//
//                               ],
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
// floatingActionButton: FloatingActionButton(
// onPressed: (){
// Navigator.push(context, MaterialPageRoute(builder: (context)=> ProfMakeOnlineMeeting()));
//
// },
// child: const Icon(Icons.add),
//
// )
//
//
//           );
//
//         },
//       ),
//     );
//   }
// }
//
