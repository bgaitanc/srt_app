import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'routes.dart';
import 'core/infrastructure/services/toast_service.dart';
import 'core/theme/bloc/theme_bloc.dart';
import 'core/theme/app_theme.dart';
import 'core/di/injection.dart' as di;

class MyApp extends StatelessWidget {
  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<ThemeBloc>(),
      child: FutureBuilder<ThemeMode>(
        future: _loadInitialTheme(),
        builder: (context, snapshot) {
          final themeMode = snapshot.data ?? ThemeMode.light;
          
          return MaterialApp(
            title: 'SRT',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeMode,
            navigatorKey: navigatorKey,
            scaffoldMessengerKey: ToastService.scaffoldMessengerKey,
            onGenerateRoute: generateRoute,
            initialRoute: initialRoute,
          );
        },
      ),
    );
  }

  Future<ThemeMode> _loadInitialTheme() async {
    final themeBloc = di.sl<ThemeBloc>();
    // Wait a bit for the bloc to load saved theme
    await Future.delayed(const Duration(milliseconds: 100));
    return themeBloc.state.mode;
  }
}
