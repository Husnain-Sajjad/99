import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user.dart' as model;
import 'package:ntp/ntp.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../other/utils.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap =
        await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }

//sign up user
  Future<String> signUpUser({
    required String aEmail,
    required String password,
    required String username,
  }) async {
    String res = "Some error occured";
    try {
      if (aEmail.isNotEmpty && password.isNotEmpty && username.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(
            email: aEmail, password: password);
        print(cred.user!.uid);
        //add user to our database
        model.User user = model.User(
          username: username,
          usernameLower: username.toLowerCase(),
          UID: cred.user!.uid,
          aEmail: aEmail,
        );

        await _firestore.collection('users').doc(cred.user!.uid).set(
              user.toJson(),
            );
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('userPassword', password);
        res = "success";
      } else if (aEmail.isEmpty || username.isEmpty || password.isEmpty) {
        res = "Input fields cannot be blank.";
      }
    }
    //IF YOU WANT TO PUT MORE DETAILS IN ERRORS
    on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'The email address is badly formatted.';
      } else if (err.code == 'email-already-in-use') {
        res = 'The email address is already in use by another account.';
      } else if (err.code == 'weak-password') {
        res = 'Password needs to be at least 6 characters long.';
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  //logging in user
  Future<String> loginUser(
      {required String email, required String password}) async {
    String res = "Some error ocurred";

    try {
      if (email.isNotEmpty && password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('userPassword', password);
        res = "success";
      } else if (email.isEmpty && password.isEmpty) {
        res = "Input fields cannot be blank.";
      } else if (email.isEmpty) {
        res = "Username/email input field cannot be blank.";
      } else if (password.isEmpty) {
        res = "Password input field cannot be blank.";
      }
    }

    //OTHER DETAILED ERRORS
    on FirebaseAuthException catch (e) {
      if (e.code == 'too-many-requests') {
        res = "Too many login attempts, please try again later.";
      } else if (e.code == 'user-disabled') {
        res =
            "This account has been disabled. If you believe this was a mistake, please contact us at: email@gmail.com";
      } else if (e.code == 'user-not-found') {
        res = "No registered user found under these credentials";
        // } else if (e.code == 'invalid-email') {
        //   res = "No registered user found under this email address.";

      } else if (e.code == 'invalid-email' && !email.contains('@')) {
        res = "No registered user found under these credentials.";
      } else if (e.code == 'wrong-password') {
        res = "Wrong password!";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
