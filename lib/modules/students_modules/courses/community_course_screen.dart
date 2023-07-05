import 'package:flutter/material.dart';
import 'package:sms_flutter/modules/students_modules/Community/comment_screen.dart';
import 'package:sms_flutter/shared/components/components.dart';

import '../../../layout/professor_general/professor_general.dart';
import '../../../layout/student_general/student_general.dart';
import 'new_post_screen.dart';

class Post {
  final String name;
  final String? image;
  final int likes;
  final int comments;
  final String text;
  final String time;
  final String avatar;
  // final String group;

  Post({
    required this.name,
    // required this.group,
    this.image,
    required this.likes,
    required this.comments,
    required this.text,
    required this.time,
    required this.avatar,
  });
}

class CommunityCourseScreen extends StatelessWidget {
  final String? type;
  CommunityCourseScreen({Key? key, this.type }) : super(key: key);
  final List<Post> posts = [
    Post(
      name: 'User 1',
      // group: 'OOP',
      image: 'https://picsum.photos/500/300',
      likes: 10,
      comments: 5,
      text:
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris pulvinar risus sed risus sodales suscipit. Aenean venenatis varius magna.',
      time: '2h ago',
      avatar: 'https://picsum.photos/50/50',
    ),
    Post(
      name: 'User 3',
      // group: 'OOP',
      // image: 'https://picsum.photos/501/300',
      likes: 2,
      comments: 10,
      text:
      'Vivamus laoreet, nunc vel vehicula pharetra, quam lectus maximus turpis, sit amet bibendum mauris elit ut mauris.',
      time: '4h ago',
      avatar: 'https://picsum.photos/50/52',
    ),
    Post(
      name: 'User 4',
      // group: 'OOP',
      likes: 2,
      comments: 10,
      text:
      'Vivamus laoreet, nunc vel vehicula pharetra, quam lectus maximus turpis, sit amet bibendum mauris elit ut mauris.',
      time: '4h ago',
      avatar: 'https://picsum.photos/50/52',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: projectAppBar(context),
      drawer: type=="student"? StudentGeneral():ProfessorGeneral(),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(post.avatar),
                          ),
                          SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  TextButton(
                                    child: Text(
                                      post.name,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    onPressed: () {},
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  // Text('>>'),
                                  // TextButton(
                                  //   // child: Text(
                                  //   //   post.group,
                                  //   //   style: TextStyle(
                                  //   //     color: Colors.black,
                                  //   //     fontWeight: FontWeight.bold,
                                  //   //   ),
                                  //   // ),
                                  //   onPressed: () {},
                                  // ),
                                ],
                              ),
                              Text(post.time),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(post.text),
                ),
                post.image != null ? Image.network(post.image!) : Container(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Row(
                          children: [
                            Icon(Icons.thumb_up),
                            SizedBox(width: 4),
                            Text(post.likes.toString()),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: ()
                        {
                          navigateTo(context, CommentScreen());
                        },
                        child: Row(
                          children: [
                            Icon(Icons.comment),
                            SizedBox(width: 4),
                            Text(post.comments.toString()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            builder: (context) {
              return Padding(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: SingleChildScrollView(
                  child: Container(
                    child: NewPostScreen(),
                  ),
                ),
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
