import 'package:flutter/material.dart';
import 'pages/not_found/not_found.dart' show NotFound;
import 'pages/login/login.dart' show Login;

class CustomRouter {
  const CustomRouter(this.context);

  final BuildContext context;

  Route<dynamic> generateRouter(RouteSettings settings) {
    switch (settings.name) {
      case '/':
      case "/login":
        return MaterialPageRoute(builder: (context) {
          return const Login();
        });
      default:
        return MaterialPageRoute(builder: (context) {
          return const NotFound();
        });
    }
  }
}
