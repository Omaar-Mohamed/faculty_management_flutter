import 'package:flutter/material.dart';
import 'package:sms_flutter/layout/student_general/student_general.dart';
import 'package:sms_flutter/shared/components/components.dart';

class User {
  final String name;
  final String image;

  User({required this.name, required this.image});
}

class Comment {
  final User user;
  final String text;
  final String likes;

  Comment({required this.user, required this.text,required this.likes});
}

class CommentScreen extends StatefulWidget {

  final List<Comment> comments = [
    Comment(
      user: User(name: 'Omar Mohamed', image: 'https://picsum.photos/200'),
      text: 'Vivamus laoreet, nunc vel vehicula pharetra, quam lectus maximus turpis, sit amet bibendum mauris elit ut mauris.',
      likes: '5',

    ),
    Comment(
      user: User(name: 'Omar Mohamed', image: 'https://picsum.photos/200'),
      text: 'Vivamus laoreet, nunc vel vehicula pharetra, quam lectus maximus turpis, sit amet bibendum mauris elit ut mauris.',
      likes: '10',

    ),


  ];

  @override
  _CommentScreenState createState() => _CommentScreenState();
}

class _CommentScreenState extends State<CommentScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  bool isLiked=false;

  void _addComment(String comment) {
    setState(() {
      Comment newComment = Comment(user: User(name: 'John', image: 'https://picsum.photos/200',),
          text: comment,
          likes: '8',
      );
      widget.comments.add(newComment);
      _textEditingController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Comments'),
    ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              itemCount: widget.comments.length,
              separatorBuilder: (BuildContext context , int index)=>SizedBox(
                height: 20.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                Comment comment = widget.comments[index];
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(comment.user.image),
                      ),
                      title: Text(comment.user.name),
                      subtitle: Text(comment.text),

                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0,0,0,0),
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(
                                Icons.thumb_up,
                                color: isLiked ? Colors.blue :Colors.black,
                            ),
                            onPressed: ()
                            {
                              // setState(() {
                              //   isLiked = !isLiked;
                              // });
                            },
                          ),
                          Text(comment.likes),
                          SizedBox(width: 20,),
                          IconButton(
                              icon: Icon(Icons.reply),
                            onPressed: ()
                            {

                            },

                          ),

                        ],
                      ),
                    )
                  ],
                );
              },
            ),
          ),
          Divider(height: 1),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: Row(
              children: [
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _textEditingController,
                    decoration: InputDecoration(
                      hintText: 'Add a comment...',
                      border: InputBorder.none,
                    ),
                    onSubmitted: (String comment) {
                      _addComment(comment);
                    },
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    _addComment(_textEditingController.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
