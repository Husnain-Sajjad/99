import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'posts.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key, this.durationInDay}) : super(key: key);
  final durationInDay;
  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // print('_FeedState ${widget.durationInDay}');
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .where('time', isEqualTo: widget.durationInDay)
              .snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            // snapshot.data!.docs.length
            return snapshot.data == null
                ? const SizedBox()
                : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) => Posts(
                      snap: snapshot.data!.docs[index].data(),
                    ),
                  );
          },
        ),
      ),
    );
  }
}
