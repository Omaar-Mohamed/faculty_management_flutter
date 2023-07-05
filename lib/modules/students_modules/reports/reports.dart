import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sms_flutter/layout/professor_general/professor_general.dart';
import 'package:sms_flutter/layout/student_general/student_general.dart';
import 'package:sms_flutter/modules/students_modules/reports/report_cubit/report_cubit.dart';
import 'package:sms_flutter/modules/students_modules/reports/report_cubit/report_states.dart';
import 'package:sms_flutter/modules/students_modules/reports/send_ticket.dart';
import 'package:sms_flutter/modules/students_modules/reports/ticket_screen.dart';
import 'package:sms_flutter/shared/components/components.dart';

class ReportsScreen extends StatefulWidget {

  final String? type;
  ReportsScreen({Key? key, this.type }) : super(key: key);

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  int page = 1;
  final int itemsPerPage = 10;
  void increasePage() {
    setState(() {
      page++;
    });
  }

  void decreasePage() {
    if (page > 1) {
      setState(() {
        page--;
      });
    }
  }

  // List<String> itemList = List<String>.generate(100, (index) => 'Item ${index + 1}');

  // List<String> getPaginatedItems() {
  //   final startIndex = (page - 1) * itemsPerPage;
  //   final endIndex = startIndex + itemsPerPage;
  //   return itemList.sublist(startIndex, endIndex);
  // }
  //
  // void nextPage() {
  //   setState(() {
  //     if (page < totalPages) {
  //       page++;
  //     }
  //   });
  // }
  //
  // void previousPage() {
  //   setState(() {
  //     if (page > 1) {
  //       page--;
  //     }
  //   });
  // }
  //
  // int get totalPages => (50 / itemsPerPage).ceil();

  @override
  Widget build(BuildContext context) {

    // final paginatedItems = getPaginatedItems();

    return BlocProvider(
      create: (BuildContext context)=>ReportCubit()..getTickets(page),
      child: BlocConsumer<ReportCubit,ReportStates>(
        listener: (BuildContext context, Object? state) {  },
        builder: (BuildContext context , state){

          var reportsCubit=ReportCubit.get(context);
          return Scaffold(
            appBar: projectAppBar(context),
            drawer: widget.type=="student"? StudentGeneral():ProfessorGeneral(),
            body: ConditionalBuilder(
              condition:ReportCubit.get(context).ticketsModel?.data! !=null,
              builder: (BuildContext context) =>    Column(

            children: [

SizedBox(height: 20.0,),

Container(
    width: 200.0,
    height: 50.0,
    child:    MaterialButton(
      color: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=> SendTicketScreen(type: widget.type,)));
      },
      child: Text(
        "Submit a ticket",
        style: TextStyle(color: Colors.white),
      ),
    )
),
SizedBox(height: 20.0,),

// Padding(
//   padding: const EdgeInsets.all(20.0),
//   child: Column(
//     children: [
//       defaultFormField(
//           controller: reportsCubit.searchController,
//           type: TextInputType.text,
//           onChange: (value){
//             reportsCubit.getSearch;
//           },
//           validator: (String value){
//             if(value.isEmpty){
//               return'search must not be empty';
//             }
//             return null ;
//           },
//           label: 'Search',
//           prefix: Icons.search)
//     ],
//   ),
// ),
SizedBox(height: 20.0,),

Expanded(
  child: Container(

    child: Center(


      child: ListView.separated(
        physics: BouncingScrollPhysics(),
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount:       reportsCubit.ticketsModel!.data!.length,
        itemBuilder: (context, index) {
          return Card(

              child: ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> TicketScreen(id:reportsCubit.ticketsModel!.data![index].id! ,)));
                },
                title: Text(reportsCubit.ticketsModel!.data![index].title!),
                // leading:Text(reportsCubit.ticketsModel!.data![index].title!,) ,


                subtitle:  Text(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(reportsCubit.ticketsModel!.data![index].createdAt!),),



// trailing: Icon(icons[index]),
              )));
        },),



    ),


  ),
),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed:() {
                        setState(() {
            reportsCubit.getTickets(--page);
                        });
                      },
                      child: Icon(Icons.arrow_back),
                    ),
                    SizedBox(width: 16),
                    Text('Page ${reportsCubit.ticketsModel!.pagination!.currentPage} of ${(reportsCubit.ticketsModel!.pagination!.total! / reportsCubit.ticketsModel!.pagination!.perPage!).ceil()}'),
                    SizedBox(width: 16),
                    ElevatedButton(
                      onPressed:() {
                        setState(() {
if(page<(reportsCubit.ticketsModel!.pagination!.total! / reportsCubit.ticketsModel!.pagination!.perPage!).ceil() || page==(reportsCubit.ticketsModel!.pagination!.total! / reportsCubit.ticketsModel!.pagination!.perPage!).ceil()){
  reportsCubit.getTickets(page++);
print(reportsCubit.ticketsModel!.pagination!.total! / reportsCubit.ticketsModel!.pagination!.perPage!.ceil());
}
                        });
                      },
                      child: Icon(Icons.arrow_forward),
                    ),
                  ],
                ),
              ),
              // Container(
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Column(
              //       children: [
              //         Text(
              //           'Current Page: '+reportsCubit.ticketsModel!.pagination[index],
              //           style: TextStyle(fontSize: 18),
              //         ),
              //         SizedBox(height: 16),
              //         Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             ElevatedButton(
              //               onPressed: previousPage,
              //               child: Icon(Icons.arrow_back),
              //             ),
              //             SizedBox(width: 16),
              //             ElevatedButton(
              //               onPressed: nextPage,
              //               child: Icon(Icons.arrow_forward),
              //             ),
              //           ],
              //         ),
              //       ],),
              //   ),

              // ),


             ]
          ),
              fallback: (context)=>Center(child: CircularProgressIndicator()),

            ),
          );

        },
      ),
    );

  }
}
