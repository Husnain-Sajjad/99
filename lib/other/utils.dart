import 'package:flutter/material.dart';
import 'package:flutter_application_1/mobile.dart';

import '../authentication/login.dart';

Future<String?> usernameValidator({required String? username}) async {
  // Validates username complexity
  bool isUsernameComplex(String? text) {
    final String _text = (text ?? "");
    // String? p = r"^(?=(.*[0-9]))(?=(.*[A-Za-z]))";
    String? p = r"^(?=(.*[ @$!%*?&=_+/#^.~`]))";
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(_text);
  }
}

String trimText({
  required String text,
}) {
  String trimmedText = text;
  // Removes all line breaks and end blank spaces
  trimmedText = trimmedText.replaceAll('\n', ' ').trim();

  // Removes all consecutive blank spaces
  while (trimmedText.contains('  ')) {
    trimmedText = trimmedText.replaceAll('  ', ' ');
  }

  return trimmedText;
}

showSnackBar(
  String content,
  BuildContext context,
) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
      duration: Duration(seconds: 4),
      // width: MediaQuery.of(context).size.width * 0.85,
      // elevation: 0,
      // behavior: SnackBarBehavior.floating,
      backgroundColor: Color.fromARGB(255, 105, 105, 105).withOpacity(0.8),
      shape: RoundedRectangleBorder(
          // borderRadius: BorderRadius.circular(25.0),
          )));
}

void goToHome(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (context) => const MobileScreenLayout(),
    ),
    (route) => false,
  );
}

void goToLogin(BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(
      builder: (context) => const LoginScreen(),
    ),
    (route) => false,
  );
}
