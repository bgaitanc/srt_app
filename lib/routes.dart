import 'package:flutter/material.dart';
import 'package:srt_app/features/auth/presentation/pages/login_page.dart';

class Routes {
  static const String login = '/login';
  static const String home = '/home';
}

Route<dynamic>? generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.login:
      return MaterialPageRoute(builder: (_) => const LoginPage());
    // add other routes here
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text('No route defined for ${settings.name}')),
        ),
      );
  }
}
