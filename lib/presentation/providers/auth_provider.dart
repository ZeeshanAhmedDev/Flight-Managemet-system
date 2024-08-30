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

  // add flight details
  Future<void> addFlights(
      String date,
      String departCity,
      String destCity,
      String duration,
      int price,
      String stopDate,
      String stopTime,
      int stops,
      String time,
      BuildContext context) async {
    await _authorizationServices.addFlights(date, departCity, destCity,
        duration, price, stopDate, stopTime, stops, time, context);
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

  Future<void> updateUserInfo(String firstName, String lastName, String email,
      BuildContext context) async {
    await _authorizationServices.updateUserInfo(
        firstName, lastName, email, context);
    notifyListeners();
  }

  Future<Map<String, dynamic>?> fetchUserInfo() async {
    return await _authorizationServices.getUserInfo();
  }

  Future<List<Map<String, dynamic>>> getFlightDetails() async {
    return await _authorizationServices.getFlightDetails();
  }

  // New method for logout
  Future<void> logout(BuildContext context) async {
    await _authorizationServices.signOut(context);
    notifyListeners();
  }
}
