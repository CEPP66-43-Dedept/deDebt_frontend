import 'package:dedebt_application/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdminLayout extends StatefulWidget {
  const AdminLayout({super.key});

  @override
  State<AdminLayout> createState() => _AdminLayoutState();
}

class _AdminLayoutState extends State<AdminLayout> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main-admin')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go(AppRoutes.INITIAL),
          child: const Text('Go to the user screen'),
        ),
      ),
    );
  }
}
