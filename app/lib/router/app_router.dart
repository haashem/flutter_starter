import 'package:authentication/authentication.dart';
import 'package:browse/browse.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static const String home = '/';
  static const String login = '/login';

  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: login,
        builder: (context, state) => const SigninPage(),
      ),
      GoRoute(
        path: home,
        builder: (context, state) => BrowsePage(
          onLogout: () {
            AuthScope.of(context).signOut();
          },
        ),
      ),
    ],
    redirect: (context, state) {
      if (AuthScope.of(context).status == AuthenticationStatus.authenticated) {
        return home;
      } else {
        return login;
      }
    },
  );
}
