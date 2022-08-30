import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'firestore_methods.dart';

class AddPost extends StatefulWidget {
  const AddPost({Key? key}) : super(key: key);

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController _titleController = TextEditingController();

  void sendPost() async {
    try {
      String res = await FirestoreMethods().uploadPost(_titleController.text);
    } catch (e) {}
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextField(
                controller: _titleController,
                decoration: InputDecoration(hintText: 'Add Post')),
            SizedBox(height: 6),
            InkWell(
              onTap: () {
                sendPost();
              },
              child: Container(
                width: 200,
                height: 40,
                color: Colors.blue,
                alignment: Alignment.center,
                child: Text(
                  'Send Post',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
