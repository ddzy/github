import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './pages/login/login.dart' show Login;
import './pages/not_found/not_found.dart' show NotFound;
import './pages/home/home.dart' show Home;
import './constants/constants.dart' as constants;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            redirect: (context, state) async {
              // 每次 hotreload 时，根据 token 来判断跳到登录页或首页
              final storage = await SharedPreferences.getInstance();
              var token = storage
                  .getString(constants.StorageTokens.githubAccessToken.name);
              return token == null ? '/login' : '/home';
            },
          ),
          GoRoute(
            path: '/login',
            builder: (context, state) => const Login(),
          ),
          GoRoute(
            path: '/home',
            builder: (context, state) => const Home(),
          )
        ],
        errorBuilder: (context, state) => const NotFound(),
      ),
    );
  }
}
