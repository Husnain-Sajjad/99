import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/post.dart';
import 'package:ntp/ntp.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../methods/firestore_methods.dart';
import '../models/user.dart';
import '../providers/user_provider.dart';

class Posts extends StatefulWidget {
  final Post post;
  const Posts({Key? key, required this.post}) : super(key: key);
  @override
  State<Posts> createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  late Post _post;

  @override
  void initState() {
    super.initState();
    // getAllUserDetails();
    _post = widget.post;
    // asyncInitState();
  }

  // void asyncInitState() async {
  //   var a = await NTP.now(lookUpAddress: '1.amazon.pool.ntp.org');
  //   setState(() {
  //     ntpTime = a;
  //   });
  // }

  //  getAllUserDetails() async {
  //   User userProfile = await _authMethods.getUserProfileDetails(_post.UID);
  //   if (!mounted) return;
  //   setState(() {
  //     _userProfile = userProfile;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final User? user = Provider.of<UserProvider>(context).getUser;
    _post = widget.post;
    return SafeArea(
        child: Column(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
          height: 200,
          child: Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.thumb_up,
                            color: _post.likes.contains(user?.UID)
                                ? Colors.blue
                                : Colors.black),
                        iconSize: 16.0,
                        onPressed: () async {
                          await FirestoreMethods().likeMessage(
                            _post.postId,
                            user?.UID ?? '',
                            _post.likes,
                          );
                          await FirestoreMethods().scoreMessage(
                            _post.postId,
                            _post.likes.length - _post.dislikes.length,
                          );
                        },
                      ),
                      SizedBox(width: 3),
                      Text('${_post.likes.length}'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.thumb_down,
                            color: _post.likes.contains(user?.UID)
                                ? Colors.blue
                                : Colors.black),
                        iconSize: 16.0,
                        onPressed: () async {
                          await FirestoreMethods().dislikeMessage(
                            _post.postId,
                            user?.UID ?? '',
                            _post.dislikes,
                          );
                          await FirestoreMethods().scoreMessage(
                            _post.postId,
                            _post.likes.length - _post.dislikes.length,
                          );
                        },
                      ),
                      SizedBox(width: 3),
                      Text('${_post.dislikes.length}'),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text('Score: ${_post.score}'),
                  Text('Time: ${_post.time}')
                ],
              ),
              SizedBox(width: 10),
              Text(_post.title),
            ],
          ),
        ),
      ],
    ));
  }
}
