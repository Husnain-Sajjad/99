import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/models/post.dart';
import 'package:ntp/ntp.dart';
import 'package:uuid/uuid.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String title,
    var time,
  ) async {
    String res = "some error occurred";
    print(Timestamp.now().toDate());
    var timeNow = await NTP.now(lookUpAddress: '1.amazon.pool.ntp.org');
    try {
      String postId = const Uuid().v1();

      Post post = Post(
        postId: postId,
        datePublished: FieldValue.serverTimestamp(),
        title: title,
        time: time,
        likes: [],
        dislikes: [],
        score: 0,
        isMostLiked: false,
        endDate: timeNow.add(const Duration(
          days: 0,
          hours: 1,
          minutes: 0,
        )),
      );

      _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );
      res = "success";
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> scoreMessage(String postId, int score) async {
    try {
      await _firestore.collection('posts').doc(postId).update(
        {'score': score},
      );
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  Future<void> likeMessage(
    String postId,
    String uid,
    List likes,
  ) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
          'dislikes': FieldValue.arrayRemove([uid]),
        });
      }
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  Future<void> dislikeMessage(
    String postId,
    String uid,
    List dislikes,
  ) async {
    try {
      if (dislikes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'dislikes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'dislikes': FieldValue.arrayUnion([uid]),
          'likes': FieldValue.arrayRemove([uid]),
        });
      }
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }
}
