import 'package:flutter/material.dart';

import '../../presentation/views/dashboard_screen.dart';
import '../../presentation/views/login_screen.dart';
import '../../presentation/views/register_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String dashboard = '/dashboard';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterPage());
      case dashboard:
        return MaterialPageRoute(builder: (_) => const DashboardPage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('There is No any Route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
