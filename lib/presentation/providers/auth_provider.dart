import 'package:flutter/material.dart';
import '../../core/utils/services/auth_service.dart';

class AuthProvider with ChangeNotifier {
  final AuthServices _authServices = AuthServices();

  Future<void> registerUser(
      String email, String password, BuildContext context) async {
    await _authServices.registerWithEmailAndPassword(email, password, context);
    notifyListeners();
  }
}
