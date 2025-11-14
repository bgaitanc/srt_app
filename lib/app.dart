import 'package:flutter/material.dart';
import 'routes.dart';

class MyApp extends StatelessWidget {
  final Widget home;
  const MyApp({super.key, required this.home});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SRT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      onGenerateRoute: generateRoute,
      home: home,
    );
  }
}
