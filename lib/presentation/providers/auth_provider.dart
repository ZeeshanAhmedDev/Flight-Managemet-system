import 'package:flutter/material.dart';
import '../../core/utils/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthServices _authorizationServices = AuthServices();

  Future<void> registerUser(String firstName, String lastName, String email,
      String password, BuildContext context) async {
    await _authorizationServices.registerUser(
        firstName, lastName, email, password, context);
    notifyListeners();
  }

  Future<void> loginUser(
      String email, String password, BuildContext context) async {
    await _authorizationServices.signInWithEmailAndPassword(
        email, password, context);
    notifyListeners();
  }

  Future<void> resetPassword(String email, BuildContext context) async {
    await _authorizationServices.resetPassword(email, context);
    notifyListeners();
  }

  Future<Map<String, dynamic>?> fetchUserInfo() async {
    return await _authorizationServices.getUserInfo();
  }
}
