import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './pages/login/login.dart' show Login;
import './pages/not_found/not_found.dart' show NotFound;
import './pages/home/home.dart' show HomePage;
import './pages/my/my.dart' show MyPage;
import './pages/explore/explore.dart' show ExplorePage;
import './pages/notification/notification.dart' show NotificationPage;
import './constants/constants.dart' show $constants;
import 'components/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart'
    show CustomBottomNavigationBar;

final GlobalKey<NavigatorState> $router = GlobalKey<NavigatorState>();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    navigatorKey: $router,
    routes: [
      ShellRoute(
        routes: [
          GoRoute(
            path: '/',
            redirect: (context, state) async {
              // 每次 hotreload 时，根据 token 来判断跳到登录页或者停留在当前页
              final storage = await SharedPreferences.getInstance();
              var token = storage
                  .getString($constants.storageToken.githubAccessToken);
              return token == null ? '/login' : '/my';
            },
          ),
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: '/my',
            builder: (context, state) => const MyPage(),
          ),
          GoRoute(
            path: '/notification',
            builder: (context, state) => const NotificationPage(),
          ),
          GoRoute(
            path: '/explore',
            builder: (context, state) => const ExplorePage(),
          ),
        ],
        pageBuilder: (context, state, child) {
          return MaterialPage(
              child: Scaffold(
            body: child,
            bottomNavigationBar: const CustomBottomNavigationBar(),
          ));
        },
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const Login(),
      ),
    ],
    errorBuilder: (context, state) => const NotFound(),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: _router,
    );
  }
}
