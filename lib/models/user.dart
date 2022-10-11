import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class User {
  final String aEmail;
  final String UID;
  final String username;
  final String usernameLower;

  User({
    required this.aEmail,
    required this.UID,
    required this.username,
    required this.usernameLower,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "usernameLower": usernameLower,
        "UID": UID,
        "aEmail": aEmail,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      username: snapshot['username'],
      usernameLower: snap['usernameLower'],
      UID: snapshot['UID'],
      aEmail: snapshot['aEmail'],
    );
  }

  static fromJson(json) {}
}
