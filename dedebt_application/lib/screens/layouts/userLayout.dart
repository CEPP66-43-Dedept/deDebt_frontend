import 'package:dedebt_application/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserLayout extends StatefulWidget {
  const UserLayout({super.key});

  @override
  State<UserLayout> createState() => _UserLayoutState();
}

class _UserLayoutState extends State<UserLayout> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main-user')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go(AppRoutes.INITIAL),
          child: const Text('Go to the user screen'),
        ),
      ),
    );
  }
}
