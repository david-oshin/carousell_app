import 'package:carousell_sample/utils/utils.dart';
import 'package:flutter/material.dart';

void main() {
  final router = AppRouter();
  runApp(MyApp(router: router));
}

class MyApp extends StatelessWidget {
  final AppRouter router;

  const MyApp({required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      title: 'Carousell Demo',
      onGenerateRoute: router.onGenerateRoute,
    );
  }
}
