import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'posts.dart';

class Feed2 extends StatefulWidget {
  const Feed2({Key? key}) : super(key: key);

  @override
  State<Feed2> createState() => _Feed2State();
}

class _Feed2State extends State<Feed2> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          //minutes
          //countdown from 59 to 0
          Row(
            children: [
              Text('59'),
            ],
          ),

          //hours
          //countdown from 23 to 0
          Row(
            children: [
              Text('23'),
            ],
          ),
        ],
      )),
    );
  }
}
