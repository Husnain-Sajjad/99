import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Posts extends StatefulWidget {
  final snap;
  const Posts({Key? key, required this.snap}) : super(key: key);

  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Text(
      widget.snap['title'],
    ));
  }
}
