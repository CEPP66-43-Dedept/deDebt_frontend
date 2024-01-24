import 'package:dedebt_application/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dedebt_application/routes/pages.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  /// Constructs a [MyApp]
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: ROUTE().router,
    );
  }
}
