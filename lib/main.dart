import 'package:flutter/material.dart';
import 'package:github/pages/create_user_list/create_user_list.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './pages/login/login.dart' show Login;
import './pages/not_found/not_found.dart' show NotFound;
import './pages/home/home.dart' show HomePage;
import './pages/my/my.dart' show MyPage;
import './pages/explore/explore.dart' show ExplorePage;
import './pages/notification/notification.dart' show NotificationPage;
import './pages/starred/starred.dart' show StarredPage;
import './constants/constants.dart' show $constants;
import 'components/custom_bottom_navigation_bar/custom_bottom_navigation_bar.dart' show CustomBottomNavigationBar;

typedef CustomRouteObserverFunc = void Function(Route route, Route? previousRoute);

class CustomRouteObserver extends NavigatorObserver {
  final List<CustomRouteObserverFunc> _listeners = [];
  Route? _route;
  Route? _previousRoute;

  void _flushListener() {
    for (var element in _listeners) {
      element(_route!, _previousRoute);
    }
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    _route = previousRoute;
    _previousRoute = route;
    _flushListener();
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    _route = route;
    _previousRoute = previousRoute;
    _flushListener();
    super.didPush(route, previousRoute);
  }

  void addListener(CustomRouteObserverFunc listener) {
    _listeners.add(listener);
  }
}

final GlobalKey<NavigatorState> $router = GlobalKey<NavigatorState>();
final CustomRouteObserver $routeObserver = CustomRouteObserver();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var storage = await SharedPreferences.getInstance();
  var token = storage.getString($constants.storageToken.githubAccessToken);
  var httpLink = HttpLink('https://api.github.com/graphql');
  var authLink = AuthLink(
    getToken: () async {
      return 'Bearer $token';
    },
  );
  var link = authLink.concat(httpLink);
  var client = ValueNotifier<GraphQLClient>(
    GraphQLClient(link: link, cache: GraphQLCache()),
  );

  runApp(
    MyApp(
      client: client,
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.client});

  final ValueNotifier<GraphQLClient> client;
  final GoRouter _router = GoRouter(
    observers: [$routeObserver],
    navigatorKey: $router,
    routes: [
      ShellRoute(
        routes: [
          GoRoute(
            path: '/',
            redirect: (context, state) async {
              // 每次 hotreload 时，根据 token 来判断跳到登录页或者停留在当前页
              final storage = await SharedPreferences.getInstance();
              var token = storage.getString($constants.storageToken.githubAccessToken);
              return token == null ? '/login' : '/starred';
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
            ),
          );
        },
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const Login(),
      ),
      GoRoute(
        path: '/starred',
        builder: (context, state) => const StarredPage(),
      ),
      GoRoute(
        path: '/create-user-list',
        builder: (context, state) => const CreateUserListPage(),
      ),
    ],
    errorBuilder: (context, state) => const NotFound(),
  );

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: client,
      child: MaterialApp.router(
        title: 'Flutter Demo',
        routerConfig: _router,
      ),
    );
  }
}
