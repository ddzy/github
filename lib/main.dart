import 'package:flutter/material.dart';
import 'package:github/pages/commit/commit.dart';
import 'package:github/pages/commit_detail/commit_detail.dart';
import 'package:github/pages/create_user_list/create_user_list.dart';
import 'package:github/pages/issue/issue.dart';
import 'package:github/pages/issue_detail/issue_detail.dart';
import 'package:github/pages/repo/repo.dart';
import 'package:github/pages/repo_code/repo_code.dart';
import 'package:github/pages/repo_detail/repo_detail.dart';
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
late final ValueNotifier<GraphQLClient> $client;

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
  var client = $client = ValueNotifier<GraphQLClient>(
    GraphQLClient(
      link: link,
      cache: GraphQLCache(),
      defaultPolicies: DefaultPolicies(
        query: Policies(fetch: FetchPolicy.noCache),
      ),
    ),
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
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const Login(),
      ),
      ShellRoute(
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: '/notification',
            builder: (context, state) => const NotificationPage(),
          ),
          GoRoute(
            path: '/explore',
            builder: (context, state) => const ExplorePage(),
          ),
          GoRoute(
            path: '/my',
            builder: (context, state) {
              return const MyPage(
                user: 'ddzy',
              );
            },
          ),
          GoRoute(
            path: '/create-user-list',
            builder: (context, state) => const CreateUserListPage(),
          ),
          GoRoute(
            path: '/user/:user',
            builder: (context, state) {
              var user = state.pathParameters['user'] ?? '';
              return MyPage(user: user);
            },
          ),
          GoRoute(
            path: '/user/:user/starred',
            builder: (context, state) {
              var user = state.pathParameters['user'] ?? '';
              return StarredPage(user: user);
            },
          ),
          GoRoute(
            path: '/user/:user/repository',
            builder: (context, state) {
              var user = state.pathParameters['user'] ?? '';
              return RepoPage(
                user: user,
              );
            },
          ),
          GoRoute(
            path: '/user/:user/issue',
            builder: (context, state) {
              var user = state.pathParameters['user'] ?? '';
              return IssuePage(user: user);
            },
          ),
          GoRoute(
            path: '/user/:user/repository/:repoName',
            builder: (context, state) {
              var user = state.pathParameters['user'] ?? '';
              var repoName = state.pathParameters['repoName'] ?? '';
              return RepoDetailPage(
                user: user,
                repoName: repoName,
              );
            },
          ),
          GoRoute(
            path: '/user/:user/repository/:repoName/issue',
            builder: (context, state) {
              var user = state.pathParameters['user'] ?? '';
              var repoName = state.pathParameters['repoName'] ?? '';
              return IssuePage(
                user: user,
                repoName: repoName,
              );
            },
          ),
          GoRoute(
            path: '/user/:user/repository/:repoName/issue/:issueNumber',
            builder: (context, state) {
              var user = state.pathParameters['user'] ?? '';
              var repoName = state.pathParameters['repoName'] ?? '';
              var issueNumber = state.pathParameters['issueNumber'] ?? '0';
              return IssueDetailPage(
                user: user,
                repoName: repoName,
                issueNumber: int.parse(issueNumber),
              );
            },
          ),
          GoRoute(
            path: '/user/:user/repository/:repoName/commit/:branch',
            builder: (context, state) {
              var user = state.pathParameters['user'] ?? '';
              var repoName = state.pathParameters['repoName'] ?? '';
              var branch = state.pathParameters['branch'] ?? '';
              var isDetail = state.uri.queryParameters['detail'];

              return isDetail != null
                  ? CommitDetailPage(
                      user: user,
                      repoName: repoName,
                      commitId: branch,
                    )
                  : CommitPage(
                      user: user,
                      repoName: repoName,
                      branch: branch,
                    );
            },
          ),
          GoRoute(
            path: '/user/:user/repository/:repoName/:type/:branch',
            builder: (context, state) {
              var user = state.pathParameters['user'] ?? '';
              var repoName = state.pathParameters['repoName'] ?? '';
              var type = state.pathParameters['type'] ?? '';
              var branch = state.pathParameters['branch'] ?? 'HEAD';
              return RepoCodePage(
                user: user,
                repoName: repoName,
                branch: branch,
                type: type,
              );
            },
          ),
          GoRoute(
            path: '/user/:user/repository/:repoName/:type/:branch/:path',
            builder: (context, state) {
              var user = state.pathParameters['user'] ?? '';
              var repoName = state.pathParameters['repoName'] ?? '';
              var type = state.pathParameters['type'] ?? '';
              var branch = state.pathParameters['branch'] ?? 'HEAD';
              var path = state.pathParameters['path'] ?? '';
              var language = state.uri.queryParameters['language'];
              return RepoCodePage(
                user: user,
                repoName: repoName,
                type: type,
                branch: branch,
                path: Uri.decodeComponent(path),
                language: language,
              );
            },
          ),
        ],
        pageBuilder: (context, state, child) {
          var visibleNavBar = ['/home', '/notification', '/explore', '/my'];
          return MaterialPage(
            child: Scaffold(
              body: child,
              bottomNavigationBar: visibleNavBar.contains(state.uri.path) ? const CustomBottomNavigationBar() : null,
            ),
          );
        },
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
        theme: ThemeData(
          useMaterial3: true,
          primaryColor: Colors.blue,
        ),
      ),
    );
  }
}
