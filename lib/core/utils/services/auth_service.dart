import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flight_management_system/core/utils/custom_alert.dart';
import 'package:flight_management_system/core/utils/validators/form_validators.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../routes.dart';

class AuthServices {
  final FirebaseAuth _authorization = FirebaseAuth.instance;
  final customAlert = CustomAlertBox();

/*  Future<User?> registerUser(String firstName, String lastName, String email,
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
  }*/

  Future<User?> registerUser(String firstName, String lastName, String email,
      String password, BuildContext context) async {
    try {
      // Create the user with email and password
      UserCredential result = await _authorization
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      // Save additional user information in the Firebase Firestore
      await FirebaseFirestore.instance.collection('users').doc(user?.uid).set({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
      });

      // Showing a success dialog.
      customAlert.buildShowDialog(
        context,
        'Registration Successful',
        '',
        'Your account has been created successfully! Welcome, $firstName.',
        'Close',
      );

      return user;
    } catch (e) {
      // Showing the error dialog
      customAlert.buildShowDialog(
        context,
        'Registration Failed',
        '',
        'Your account could\'nt be created due to ${e.toString().replaceFirst('[firebase_auth/user-not-found]', '')}',
        'Close',
      );

      return null;
    }
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential result = await _authorization.signInWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;
      Navigator.pushNamed(context, AppRoutes.dashboard);
      return user;
    } catch (e) {
      customAlert.buildShowDialog(
        context,
        'Login Failed',
        '',
        'You cannot login due to ${e.toString()}, ' ')}',
        'Close',
      );
      return null;
    }
  }

  Future<void> resetPassword(String email, BuildContext context) async {
    try {
      await _authorization.sendPasswordResetEmail(email: email);

      // If the email address is valid and exists, then only show a  message
      customAlert.buildShowDialog(
        context,
        'Reset Password',
        '',
        'A password reset link has been sent to $email. Please check your email. Have a nice day',
        'Close',
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      // Handle specific error cases from Firebase
      if (e.code == 'user-not-found') {
        errorMessage =
            'No user found with that email address. Please check the email and try again.';
      } else {
        errorMessage = 'Failed to reset password. Error: ${e.message}';
      }

      // Show error dialog
      customAlert.buildShowDialog(
        context,
        'Reset Password Failed',
        '',
        errorMessage,
        'Close',
      );
    } catch (e) {
      // Handles other unexpected errors...
      customAlert.buildShowDialog(
        context,
        'Reset Password Failed',
        '',
        'An unexpected error occurred. Please try again later. Error: ${e.toString()}',
        'Close',
      );
    }
  }

  Future<void> updateUserInfo(String firstName, String lastName, String email,
      BuildContext context) async {
    User? user = _authorization.currentUser;
    if (user != null) {
      try {
        // Update Firebase Firestore with the new user data
        await FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .update({
          'firstName': firstName,
          'lastName': lastName,
          'email': email,
        });

        // Show success dialog
        customAlert.buildShowDialog(
          context,
          'Success',
          '',
          'Your information has been updated successfully.',
          'Close',
        );
      } catch (e) {
        // Show error dialog
        customAlert.buildShowDialog(
          context,
          'Update Failed',
          '',
          'Your information could not be updated due to ${e.toString()}',
          'Close',
        );
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

  /* void _showAlert(BuildContext context, String title, String desc) {
    Alert(
      context: context,
      title: title,
      desc: desc,
    ).show();
  }*/
}
