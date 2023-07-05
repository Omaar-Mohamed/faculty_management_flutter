import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sms_flutter/layout/student_general/student_general.dart';
import 'package:sms_flutter/modules/students_modules/courses/course_cubit/course_cubit.dart';
import 'package:sms_flutter/modules/students_modules/courses/course_cubit/course_states.dart';
import 'package:sms_flutter/modules/students_modules/courses/lecorsec_screen.dart';
import 'package:sms_flutter/shared/components/components.dart';

import '../../../layout/professor_general/professor_general.dart';
import 'course_material_lecture_screen.dart';

class FolderModel {
  final String name;
  final String apiName;
  final IconData icon;
  final String? date;
  final String? url;

  FolderModel({required this.name, required this.icon, this.date,this.url,required this.apiName});
}

class CourseMaterialScreen extends StatefulWidget {
  final String? type;
  final String? id;
  final String? materialType;
  CourseMaterialScreen({Key? key, this.type,this.id,required this.materialType}) : super(key: key);

  @override
  State<CourseMaterialScreen> createState() => _CourseMaterialScreenState();
}

class _CourseMaterialScreenState extends State<CourseMaterialScreen> {
  final _formKey = GlobalKey<FormState>();

  final _textController = TextEditingController();

  // final List<FolderModel> folders = [
  //   FolderModel(name: 'lecture 1', icon: Icons.folder,date: '9/4/1801',apiName: 'lecture1'),
  //   FolderModel(name: 'lecture 2', icon: Icons.folder,date: '9/4/1801',apiName: 'lecture2'),
  //   FolderModel(name: 'lecture 3', icon: Icons.folder,date: '9/4/1801',apiName: 'lecture3'),
  //   FolderModel(name: 'lecture 4', icon: Icons.folder,date: '9/4/1801',apiName: 'lecture4'),
  //   FolderModel(name: 'lecture 6', icon: Icons.folder,date: '9/4/1801',apiName: 'lecture6'),
  //   FolderModel(name: 'lecture 7', icon: Icons.folder,date: '9/4/1801',apiName: 'lecture7'),
  //   FolderModel(name: 'lecture 8', icon: Icons.folder,date: '9/4/1801',apiName: 'lecture8'),
  //   FolderModel(name: 'lecture 9', icon: Icons.folder,date: '9/4/1801',apiName: 'lecture9'),
  // ];
  Future<void> _refreshPage() async {
    // Simulate a delay for reloading the page
    await Future.delayed(Duration(seconds: 1));
    navigateAndReplace(context, CourseMaterialScreen(type: widget.type, id: widget.id,materialType: widget.materialType,));

    // setState(() {
    //   // Generate new data for the page
    //   items = List.generate(10, (index) => 'Item $index (Reloaded)');
    // });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CourseCubit()..getStudentTagsCourses(widget.id,widget.materialType),
      child: BlocConsumer<CourseCubit,CourseStates>(
        listener: (BuildContext context, state) {

          if(state is ProfAddTagSuccessState){
            navigateAndReplace(context, CourseMaterialScreen(type: widget.type,id: widget.id,materialType: widget.materialType,));
            Fluttertoast.showToast(
                msg: "Tag Added Successfully",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.amber,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }else if(state is ProfAddTagErrorState){
            Fluttertoast.showToast(
                msg: "Error Adding Tag",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.amber,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
        },
        builder: (BuildContext context, Object? state) {
          var cubit = CourseCubit.get(context);
          return Scaffold(
            // resizeToAvoidBottomInset: true,
            appBar: projectAppBar(context),
            drawer: widget.type == "student" ? StudentGeneral() : ProfessorGeneral(),
            body:widget.type== 'student'? RefreshIndicator(
              onRefresh: () { return _refreshPage(); },
              child: ConditionalBuilder(
                condition: CourseCubit.get(context).tagsModel?.data! != null,
                builder: (BuildContext context) =>ListView.builder(
                  itemCount: cubit.tagsModel!.data!.length,
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
                                  widget.type=='Professor'?   ListTile(
                                    leading: Icon(Icons.delete),
                                    title: Text('Delete folder'),
                                    onTap: () {
                                      // Handle delete folder option
                                      Navigator.pop(context); // Close the bottom sheet
                                    },
                                  ):Container(),
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
                      child: InkWell(
                        onTap: ()
                        {
                          navigateTo(context, CourseMaterialLectureScreen(type: widget.type,id: widget.id,tagId:cubit.tagsModel?.data![index].id.toString(),materialType: widget.materialType,));
                        },
                        child: Container(
                          height: 60,
                          padding: EdgeInsets.all(9),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.folder,
                                      color: Colors.amber,
                                    ),
                                    SizedBox(width: 16),
                                    Text(cubit.tagsModel!.data![index].name!),
                                  ],
                                ),
                              ),
                              // Text(
                              //   folders[index].date!,
                              //   style: TextStyle(color: Colors.grey),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                fallback: (BuildContext context)=>Center(child: CircularProgressIndicator())

              ),
            ):
            RefreshIndicator(
              onRefresh: () { return _refreshPage();  },
              child: ConditionalBuilder(
                  condition: CourseCubit.get(context).tagsModel?.data! != null,
                  builder: (BuildContext context) =>ListView.builder(
                    itemCount: cubit.tagsModel!.data!.length,
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
                                    widget.type=='Professor'?   ListTile(
                                      leading: Icon(Icons.delete),
                                      title: Text('Delete folder'),
                                      onTap: () {
                                        // Handle delete folder option
                                        Navigator.pop(context); // Close the bottom sheet
                                      },
                                    ):Container(),
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
                        child: InkWell(
                          onTap: ()
                          {
                            navigateTo(context, CourseMaterialLectureScreen(type: widget.type,id: widget.id,tagId:cubit.tagsModel?.data![index].id.toString(),materialType: widget.materialType,));
                          },
                          child: Container(
                            height: 60,
                            padding: EdgeInsets.all(9),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.folder,
                                        color: Colors.amber,
                                      ),
                                      SizedBox(width: 16),
                                      Text(cubit.tagsModel!.data![index].name!),
                                    ],
                                  ),
                                ),
                                // Text(
                                //   folders[index].date!,
                                //   style: TextStyle(color: Colors.grey),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  fallback: (BuildContext context)=>Center(child: CircularProgressIndicator())

              ),
            ),
            floatingActionButton: widget.type == 'Professor'
                ? FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (BuildContext context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: SingleChildScrollView(
                        child: Container(
                          padding: EdgeInsets.all(16.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                TextFormField(
                                  controller: _textController,
                                  decoration: InputDecoration(
                                    labelText: 'Add Folder',
                                    hintText: 'Add Folder Name',
                                  ),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Add Folder Name';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 16.0),
                                ElevatedButton(
                                  onPressed: () {
                                    setState(() {
                                      if (_formKey.currentState!.validate()) {
                                        // do something with the text
                                        // folders.add(FolderModel(
                                        //     name: _textController.text,
                                        //     icon: Icons.folder,
                                        //     date: '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                                        // ));
                                        // print(_textController.text);
                                        cubit.profAddLectureTag(courseId: widget.id, name: _textController.text,materialType: widget.materialType);

                                        Navigator.pop(context);
                                      }
                                    });
                                  },
                                  child: Text('Submit'),
                                ),
                              ],
                            ),
                          ),
                        ),
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
