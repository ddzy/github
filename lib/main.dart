import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import './pages/login/login.dart' show Login;
import './pages/not_found/not_found.dart' show NotFound;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            redirect: (context, state) => '/login',
          ),
          GoRoute(
            path: '/login',
            builder: (context, state) => const Login(),
          ),
        ],
        errorBuilder: (context, state) => const NotFound(),
      ),
    );
  }
}
