import 'package:flutter/material.dart';

class Post {
  // final String title;
  final String content;

  Post({
    // required this.title,
    required this.content});
}

class NewPostScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  // final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  void _submitPost(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // final title = _titleController.text;
      final content = _contentController.text;

      final newPost = Post(
          // title: title
           content: content);
      // TODO: Save the new post to a database or backend service.

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // TextFormField(
            //   controller: _titleController,
            //   decoration: InputDecoration(
            //     labelText: 'Title',
            //     border: OutlineInputBorder(),
            //   ),
            //   validator: (value) {
            //     if (value!.isEmpty) {
            //       return 'Please enter a title.';
            //     }
            //     return null;
            //   },
            // ),
            // SizedBox(height: 16.0),
            TextFormField(
              controller: _contentController,
              decoration: InputDecoration(
                labelText: 'Post Content',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some content.';
                }
                return null;
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Add Attachment:',
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                    onPressed: ()
                    {
                      // _pickFile();
                    }
                    ,
                    icon:Icon( Icons.attachment_sharp)
                ),

              ],
            ),
            SizedBox(height: 16.0),
            InkWell(
              onTap: (){
                // _openFile(context);
              },
              child: Expanded(
                child: Row(

                    children:[
                      Icon(Icons.description),
                      SizedBox(width: 10,),
                      Expanded(
                        child: Text(
                          'File Name'
                          // path.basename(_file!.path),
                        ),
                      ),

                    ]
                ),
              ),
            ),
            SizedBox(height: 16.0),

            InkWell(
              onTap: (){
                // _openFile(context);
              },
              child: Expanded(
               child: Image.network(
                   'https://picsum.photos/500/300',
                 width: 70,
                 height: 70,
               )
              ),
            ),

            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _submitPost(context),
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}