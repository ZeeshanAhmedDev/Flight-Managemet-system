import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AuthServices {
  final FirebaseAuth _authorization = FirebaseAuth.instance;

  Future<User?> registerWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential result = await _authorization
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      if (kDebugMode) {
        _showAlert(
            context,
            'Registration Failed',
            e.toString().replaceFirst('[firebase_auth/weak-password]',
                '')); // Show the alert using context
        print("Register error : >>>>>>>>  ${e.toString()}");
      }
      return null;
    }
  }

  void _showAlert(BuildContext context, String title, String desc) {
    Alert(
      context: context,
      title: title,
      desc: desc,
    ).show();
  }
}
