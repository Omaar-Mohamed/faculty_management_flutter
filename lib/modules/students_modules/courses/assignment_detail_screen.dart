import 'dart:io';
import 'dart:typed_data';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as path;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:sms_flutter/modules/students_modules/courses/course_cubit/course_cubit.dart';
import 'package:sms_flutter/modules/students_modules/courses/course_cubit/course_states.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';



class AssignmentDetailsScreen extends StatefulWidget {
  final String? type;
  String? id;
  String? assignmentId;
  AssignmentDetailsScreen({Key? key,this.type,this.id,this.assignmentId}) : super(key: key);

  @override
  State<AssignmentDetailsScreen> createState() => _AssignmentDetailsScreenState();
}

class _AssignmentDetailsScreenState extends State<AssignmentDetailsScreen> {
  File? _file;
  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final path = result.files.single.path!;
      setState(() {
        _file = File(path);
      });
    }
  }

  // void _openFile(BuildContext context,String? urll) {
  //   if (urll != null) {
  //     OpenFile.open(urll);
  //   }
  // }
  // _openFile(String? fileUrl) async {
  //   try {
  //     await OpenFile.open(fileUrl);
  //   } catch (error) {
  //     print('Error opening file: $error');
  //   }
  // }
 // Future<void> _launchFileLink(String url) async {
 //    final Uri uri = Uri(scheme: 'https', host: url);
 //    if(!await launchUrl(
 //      uri,
 //      mode: LaunchMode.externalApplication,
 //    ) ){
 //      throw 'Could not launch $uri';
 //    }
 //  }
  Future<void> _launchFileLink(String url) async {
    if (!await canLaunch(url)) {
      throw 'Could not launch $url';
    }

    await launch(
      url,
      forceSafariVC: false,
      forceWebView: false,
      enableJavaScript: true,
      headers: <String, String>{'my_header_key': 'my_header_value'},
    );
  }
  // Future<void> downloadAndOpenFile(String fileUrl) async {
  //   try {
  //     final taskId = await FlutterDownloader.enqueue(
  //       url: fileUrl,
  //       savedDir: '/storage/emulated/0/Download',
  //       showNotification: true,
  //       openFileFromNotification: true,
  //     );
  //
  //     FlutterDownloader.registerCallback((id, status, progress) {
  //       if (status == DownloadTaskStatus.complete) {
  //         // File downloaded successfully, open it
  //         OpenFile.open('/storage/emulated/0/Download');
  //       }
  //     });
  //   } catch (error) {
  //     // Handle any errors that occur during the download process
  //     print('Download error: $error');
  //   }
  // }

  void openFile(String fileUrl) async {
    await OpenFile.open(fileUrl);
  }
  PlatformFile? pickedFile;
  Future selectFile()async{
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if(result==null)return;
    setState(() {
      pickedFile= result.files.first;

    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> CourseCubit()..getStudentAssignmentDetailCourses(widget.id!,widget.assignmentId!),
      child: BlocConsumer<CourseCubit,CourseStates>(
        listener: (BuildContext context, state) {
          if(state is SubmitAssignmentSuccessState ){
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: state.submitAssignmentModel!.message!,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.green[400],
                textColor: Colors.white,
                fontSize: 16.0
            );
          }else if(state is SubmitAssignmentErrorState){
Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red[400],
                textColor: Colors.white,
                fontSize: 16.0
            );

          }
        },
        builder: (BuildContext context, Object? state) {
          var courseCubit = CourseCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text('Assignment Details'),
            ),
            body: widget.type == 'student'? ConditionalBuilder(
              condition: CourseCubit.get(context).assignmentDetailModel?.data! !=null,
              builder: (BuildContext context) { return SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      courseCubit.assignmentDetailModel!.data![0].name!,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Description:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      courseCubit.assignmentDetailModel!.data![0].description!,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    InkWell(
                      onTap: (){
                        // _openFile(courseCubit.assignmentDetailModel!.data![0].attachments![0].url!);
                        // _launchFileLink(courseCubit.assignmentDetailModel!.data![0].attachments![0].url!);
                        // openFile('https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&w=1000&q=80');
                        _launchFileLink(courseCubit.assignmentDetailModel!.data![0].attachments![0].url!);
                      },
                      child: Row(
                          children:[
                            Icon(

                              Icons.document_scanner,
                            ),
                            SizedBox(width: 10,),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                courseCubit.assignmentDetailModel!.data![0].attachments![0].name!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),

                          ]
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Attachment:',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                            onPressed: widget.type=='student'? () => _pickFile():null

                            // openFile(file!);
                            // print('Name:${file.name}');
                            // print('Name:${file.bytes}');
                            // print('Name:${file.size}');
                            // print('Name:${file.extension}');
                            // print('Name:${file.path}');
                            ,
                            icon:Icon( Icons.attachment_sharp)
                        ),

                      ],
                    ),
                    SizedBox(height: 10.0,),
                    Text(
                      'my work',
                      style:TextStyle(
                        color: Colors.black38,
                      ) ,


                    ),
                    SizedBox(height: 16.0),
                    if(_file!=null) ...[
                      InkWell(
                        onTap: (){
                          // _openFile(context);
                          openFile(_file!.path);
                        },
                        child: Expanded(
                          child: Row(

                              children:[
                                Icon(Icons.description),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Text(
                                    path.basename(_file!.path),
                                  ),
                                ),

                              ]
                          ),
                        ),
                      )
                    ],
                    SizedBox(height: 16.0),
                    ConditionalBuilder(
                      condition:  state is! SubmitAssignmentLoadingState ,
                      builder: (BuildContext context) { return ElevatedButton(
                        // onPressed: widget.type=='student' ? ()=>courseCubit.submitAssignment( widget.id, widget.assignmentId,_file?.readAsBytes()):null
                        // Submit button pressed callback
                        onPressed: widget.type == 'student' ? ()  {
                          courseCubit.submitAssignment(
                              widget.id, widget.assignmentId, _file);
                          // Navigator.pop(context);
                        } : null,


                        child: Text('Submit'),
                      ); },
                      fallback: (BuildContext context) { return Center(child: CircularProgressIndicator());  },

                    ),
                  ],
                ),
              );   },
              fallback: (BuildContext context) { return Center(child: CircularProgressIndicator()); },
            )
                :
            ConditionalBuilder(
              condition: CourseCubit.get(context).profGetAssignmentDetail?.data! !=null,
              builder: (BuildContext context) { return SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Title:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      courseCubit.profGetAssignmentDetail!.data![0].name!,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Description:',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      courseCubit.profGetAssignmentDetail!.data![0].description!,
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 16.0),
                    InkWell(
                      onTap: (){
                        // _openFile(courseCubit.assignmentDetailModel!.data![0].attachments![0].url!);
                        // _launchFileLink(courseCubit.assignmentDetailModel!.data![0].attachments![0].url!);
                        // openFile('https://images.unsplash.com/photo-1575936123452-b67c3203c357?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aW1hZ2V8ZW58MHx8MHx8fDA%3D&w=1000&q=80');
                        _launchFileLink(courseCubit.profGetAssignmentDetail!.data![0].attachments![0].url!);
                      },
                      child: Row(
                          children:[
                            Icon(

                              Icons.document_scanner,
                            ),
                            SizedBox(width: 10,),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                courseCubit.profGetAssignmentDetail!.data![0].attachments![0].name!,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ),

                          ]
                      ),
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Attachment:',
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                            onPressed: widget.type=='student'? () => _pickFile():null

                            // openFile(file!);
                            // print('Name:${file.name}');
                            // print('Name:${file.bytes}');
                            // print('Name:${file.size}');
                            // print('Name:${file.extension}');
                            // print('Name:${file.path}');
                            ,
                            icon:Icon( Icons.attachment_sharp)
                        ),

                      ],
                    ),
                    SizedBox(height: 10.0,),
                    Text(
                      'my work',
                      style:TextStyle(
                        color: Colors.black38,
                      ) ,


                    ),
                    SizedBox(height: 16.0),
                    if(_file!=null) ...[
                      InkWell(
                        onTap: (){
                          // _openFile(context);
                          openFile(_file!.path);
                        },
                        child: Expanded(
                          child: Row(

                              children:[
                                Icon(Icons.description),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Text(
                                    path.basename(_file!.path),
                                  ),
                                ),

                              ]
                          ),
                        ),
                      )
                    ],
                    SizedBox(height: 16.0),
                    ConditionalBuilder(
                      condition:  state is! SubmitAssignmentLoadingState ,
                      builder: (BuildContext context) { return ElevatedButton(
                        // onPressed: widget.type=='student' ? ()=>courseCubit.submitAssignment( widget.id, widget.assignmentId,_file?.readAsBytes()):null
                        // Submit button pressed callback
                        onPressed: widget.type == 'student' ? ()  {
                          courseCubit.submitAssignment(
                              widget.id, widget.assignmentId, _file);
                          // Navigator.pop(context);
                        } : null,


                        child: Text('Submit'),
                      ); },
                      fallback: (BuildContext context) { return Center(child: CircularProgressIndicator());  },

                    ),
                  ],
                ),
              );   },
              fallback: (BuildContext context) { return Center(child: CircularProgressIndicator()); },
            )
            ,
          );
        },

      ),
    );


  }
void submitFunction({
    required String? id,
    required String? assignmentId,
  required File? file,
}){

}

}
