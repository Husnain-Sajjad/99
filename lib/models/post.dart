import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String postId;
  final String title;
  int time;
  final datePublished;
  final endDate;
  bool isMostLiked;
  int score;
  List<dynamic> likes;
  List<dynamic> dislikes;
  StreamController<Post>? updatingStream;

  Post(
      {required this.postId,
      required this.time,
      required this.title,
      required this.datePublished,
      required this.isMostLiked,
      required this.score,
      required this.likes,
      required this.dislikes,
      this.updatingStream,
      required this.endDate}) {
    if (updatingStream != null) {
      updatingStream!.stream
          .where((event) => event.postId == postId)
          .listen((event) {
        likes = event.likes;
        dislikes = event.dislikes;
        score = event.score;
      });
    }
  }

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "datePublished": datePublished,
        "title": title,
        "time": time,
        "isMostLiked": isMostLiked,
        "likes": likes,
        "dislikes": dislikes,
        "score": score,
        "endDate": endDate,
      };

  static Post fromSnap(
    DocumentSnapshot snap,
  ) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return fromMap(
      snapshot,
    );
  }

  static Post fromMap(
    Map<String, dynamic> snapshot,
  ) {
    return Post(
      postId: snapshot['postId'] ?? "",
      title: snapshot['title'] ?? "",
      datePublished: snapshot['datePublished'],
      time: snapshot['time'],
      score: snapshot['score'],
      endDate: snapshot['endDate'],
      likes: (snapshot['likes'] ?? []).cast<String>(),
      dislikes: (snapshot['dislikes'] ?? []).cast<String>(),
      isMostLiked: snapshot['isMostLiked'],
      updatingStream: snapshot['updatingStream'],
    );
  }
}
