import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AuthServices {
  final FirebaseAuth _authorization = FirebaseAuth.instance;

  Future<User?> registerUser(String firstName, String lastName, String email,
      String password, BuildContext context) async {
    try {
      UserCredential result = await _authorization
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // Save also user information in the Firebase Firestore
      await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      });

      return user;
    } catch (e) {
      _showAlert(context, 'Registration Failed',
          e.toString().replaceFirst('[firebase_auth/weak-password]', ''));
      if (kDebugMode) {
        print("Register error: ${e.toString()}");
      }
      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential result = await _authorization.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      _showAlert(context, 'Login Failed',
          e.toString().replaceFirst('[firebase_auth/user-not-found]', ''));
      if (kDebugMode) {
        print("Login error: ${e.toString()}");
      }
      return null;
    }
  }

  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      await _authorization.sendPasswordResetEmail(email: email);
      _showAlert(context, 'Password Reset',
          'A password reset link has been sent to $email. Please check your email. Have a Nice day');
    } catch (e) {
      _showAlert(context, 'Reset Password Failed', e.toString());
      if (kDebugMode) {
        print("Reset password error: ${e.toString()}");
      }
    }
  }

  Future<Map<String, dynamic>?> getUserInfo() async {
    User? user = _authorization.currentUser;
    if (user != null) {
      DocumentSnapshot userInfo = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return userInfo.data() as Map<String, dynamic>?;
    }
    return null;
  }

  void _showAlert(BuildContext context, String title, String desc) {
    Alert(
      context: context,
      title: title,
      desc: desc,
    ).show();
  }
}
