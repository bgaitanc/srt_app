import 'package:flutter/material.dart';
import 'package:srt_app/features/auth/presentation/pages/login_page.dart';
import 'package:srt_app/features/home/presentation/pages/home_page.dart';

class Routes {
  static const String root = '/';
  static const String login = '/login';
  static const String home = '/home';
}

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.root:
    case Routes.home:
      return MaterialPageRoute(builder: (_) => const HomePage());
    case Routes.login:
      return MaterialPageRoute(builder: (_) => const LoginPage());
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}
