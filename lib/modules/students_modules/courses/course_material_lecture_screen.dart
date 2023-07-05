import 'dart:io';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path/path.dart';
import 'package:sms_flutter/layout/professor_general/professor_general.dart';
import 'package:sms_flutter/layout/student_general/student_general.dart';
import 'package:sms_flutter/modules/students_modules/courses/course_cubit/course_cubit.dart';
import 'package:sms_flutter/shared/components/components.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:path/path.dart' as path;

import 'course_cubit/course_states.dart';

class FolderModel {
  final String name;
  final IconData icon;
  final String date;
  final String? url;

  FolderModel(
      {required this.name, required this.icon, required this.date, this.url});
}

class CourseMaterialLectureScreen extends StatefulWidget {
  final String? type;
  final String? id;
  final String? tagId;
  final String? folderName;
  final String? materialType;
  CourseMaterialLectureScreen({Key? key, this.type,this.id,this.folderName,this.tagId,required this.materialType}) : super(key: key);

  @override
  State<CourseMaterialLectureScreen> createState() =>
      _CourseMaterialLectureScreenState();
}

class _CourseMaterialLectureScreenState
    extends State<CourseMaterialLectureScreen> {
  File? file;
  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      final path = result.files.single.path!;
      setState(() {
      file = File(path);
      });
    }
  }

  void openFile(String fileUrl) async {
    await OpenFile.open(fileUrl);
  }

  PlatformFile? pickedFile;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return;
    setState(() {
      pickedFile = result.files.first;
    });
  }

  final _formKey = GlobalKey<FormState>();

  final _textController = TextEditingController();

  // final List<FolderModel> folders = [
  //   FolderModel(
  //       name: 'lecture 1', icon: Icons.picture_as_pdf, date: '9/4/1801'),
  //   FolderModel(
  //       name: 'lecture 2', icon: Icons.picture_as_pdf, date: '9/4/1801'),
  //   FolderModel(
  //       name: 'lecture 3', icon: Icons.video_file_outlined, date: '9/4/1801'),
  //   FolderModel(
  //       name: 'lecture 4',
  //       icon: Icons.picture_as_pdf_outlined,
  //       date: '9/4/1801'),
  //   FolderModel(name: 'lecture 6', icon: Icons.video_file, date: '9/4/1801'),
  //   FolderModel(
  //       name: 'lecture 7', icon: Icons.video_file_sharp, date: '9/4/1801'),
  //   FolderModel(
  //       name: 'lecture 8', icon: Icons.picture_as_pdf_sharp, date: '9/4/1801'),
  // ];
  Icon getFileIcon(String? fileType) {
    switch (fileType) {
      case 'png':
        return Icon(Icons.image, color: Colors.red);
      case 'pdf':
        return Icon(Icons.picture_as_pdf, color: Colors.red);
      case 'mp4':
        return Icon(Icons.video_file, color: Colors.red);
      case 'mp3':
        return Icon(Icons.music_note, color: Colors.red);
      case 'docx':
        return Icon(Icons.document_scanner, color: Colors.red);
      case 'xlsx':
        return Icon(Icons.table_chart, color: Colors.red);
      case 'pptx':
        return Icon(Icons.picture_as_pdf, color: Colors.red);
      case 'doc':
        return Icon(Icons.document_scanner, color: Colors.red);
      default:
        return Icon(Icons.document_scanner, color: Colors.red);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>CourseCubit()..getStudentTagsMaterialCourses(widget.id,widget.materialType,widget.tagId),
      child: BlocConsumer<CourseCubit,CourseStates>(
        listener: (BuildContext context, state) {
          if(state is profAddLectureMaterialSuccessState){
            navigateAndReplace(context, CourseMaterialLectureScreen(id: widget.id,type: widget.type,tagId: widget.tagId,materialType: widget.materialType,));
            Fluttertoast.showToast(
              msg: "Material Added Successfully",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.green,
              textColor: Colors.white
            );

          }else if(state is profAddLectureMaterialErrorState){
            Fluttertoast.showToast(
              msg: state.error.toString(),
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white
            );
          }
        },
        builder: (BuildContext context, Object? state) {
          var courseCubit=CourseCubit.get(context);
          return Scaffold(
            appBar: projectAppBar(context),
            drawer: widget.type == "student" ? StudentGeneral() : ProfessorGeneral(),
            body: ConditionalBuilder(
              condition: CourseCubit.get(context).tagsMaterialModel?.data!=null,
              builder: (BuildContext context)=>ListView.builder(
                itemCount: courseCubit.tagsMaterialModel!.data!.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onLongPress: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                widget.type == 'Professor'
                                    ? ListTile(
                                  leading: Icon(Icons.delete),
                                  title: Text('Delete folder'),
                                  onTap: () {
                                    // Handle delete folder option
                                    Navigator.pop(
                                        context); // Close the bottom sheet
                                  },
                                )
                                    : Container(),
                                ListTile(
                                  leading: Icon(Icons.download),
                                  title: Text('Download folder'),
                                  onTap: () {
                                    // Handle download folder option
                                    Navigator.pop(context); // Close the bottom sheet
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Column(
                      children: [
                        if (courseCubit.tagsMaterialModel!.data![index].url != null) ...[
                          InkWell(
                            onTap: () async{
                              if(await canLaunch(courseCubit.tagsMaterialModel!.data![index].url!)){
                                await launch(
                                    courseCubit.tagsMaterialModel!.data![index].url!,
                                forceSafariVC: false,
                                );
                              }
                            },
                            // navigateTo(context, CourseMaterialLectureScreen(type: type,));

                            child: Container(
                              height: 60,
                              padding: EdgeInsets.all(9),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [

                   getFileIcon(courseCubit.tagsMaterialModel!.data![index].fileType),
                                        SizedBox(width: 16),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 0.5,
                                          child: Text(
                                            courseCubit.tagsMaterialModel!.data![index].name!,
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,

                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(

                                    child: Text(
                                      DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.parse(courseCubit.tagsMaterialModel!.data![index].createdAt!)),
                                      style: TextStyle(color: Colors.grey,
                                        fontSize: MediaQuery.of(context).size.width * 0.03,

                                      ),

                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ] else ...[
                          Container(
                            height: 60,
                            padding: EdgeInsets.all(9),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        courseCubit.tagsMaterialModel!.data![index].fileType!='png'?Icons.image:
                                        courseCubit.tagsMaterialModel!.data![index].fileType!='pdf'?Icons.picture_as_pdf:
                                        courseCubit.tagsMaterialModel!.data![index].fileType!='mp4'?Icons.video_file:
                                        courseCubit.tagsMaterialModel!.data![index].fileType!='mp3'?Icons.music_note:
                                        courseCubit.tagsMaterialModel!.data![index].fileType!='docx'?Icons.document_scanner:
                                        courseCubit.tagsMaterialModel!.data![index].fileType!='xlsx'?Icons.table_chart:
                                        courseCubit.tagsMaterialModel!.data![index].fileType!='pptx'?Icons.picture_as_pdf:
                                        courseCubit.tagsMaterialModel!.data![index].fileType!='doc'?Icons.document_scanner:
                                            Icons.document_scanner,

                                        color: Colors.red,
                                      ),
                                      SizedBox(width: 16),
                                      Text(courseCubit.tagsMaterialModel!.data![index].name!),
                                    ],
                                  ),
                                ),
                                Text(
                                  courseCubit.tagsMaterialModel!.data![index].createdAt!,
                                  style: TextStyle(
                                      color: Colors.grey,
                                  fontSize: MediaQuery.of(context).size.width*0.03
                                  ),

                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
              fallback: (BuildContext context)=>Center(child: CircularProgressIndicator()),


            ),
            floatingActionButton: widget.type == 'Professor'
                ? FloatingActionButton(
              onPressed: () {
                _pickFile();
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Center(
                                child: Text(
                                  'Add New ِAttachment',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                              // IconButton(
                              //     onPressed: (){
                              //       setState(() {
                              //         _pickFile();
                              //       });
                              //     },
                              //     icon: Icon(Icons.attachment_sharp
                              //     )),
                            ],
                          ),
                          SizedBox(height: 16),
                          if(file!=null) ...[
                            InkWell(

                              onTap: (){
                                // _openFile(context);
                                openFile(file!.path);
                              },
                              child: Expanded(
                                child: Row(

                                    children:[
                                      Icon(Icons.description),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        child: Text(
                                          path.basename(file!.path),
                                        ),
                                      ),

                                    ]
                                ),
                              ),
                            )
                          ],
                          SizedBox(height: 16),
                          ConditionalBuilder(
                            condition: state is! profAddLectureMaterialLoadingState,
                            builder: (BuildContext context) { return ElevatedButton(
                              onPressed: () {
                                // TODO: Implement attachment upload logic
                                setState(() {
                                  if (file != null) {
                                    courseCubit.profAddLectureMaterial(
                                      courseId: widget.id,
                                      file: file,
                                      tagId: widget.tagId,
                                      materialType: widget.materialType,
                                    );
                                    Navigator.pop(context);
                                  }else{
                                    Fluttertoast.showToast(
                                        msg: "Please Select File",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.red,
                                        textColor: Colors.white,
                                        fontSize: 16.0
                                    );
                                    Navigator.pop(context);
                                  }

                                });
                              },
                              child: Text('Add Attachment'),
                            );  },
                            fallback: (BuildContext context) { return Center(child: CircularProgressIndicator()); },

                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Icon(Icons.add),
            )
                : null,
          );
        },

      ),
    );
  }
}
