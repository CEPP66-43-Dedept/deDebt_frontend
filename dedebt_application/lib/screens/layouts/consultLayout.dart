import 'package:dedebt_application/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConsultLayout extends StatefulWidget {
  const ConsultLayout({super.key});

  @override
  State<ConsultLayout> createState() => _ConsultLayoutState();
}

class _ConsultLayoutState extends State<ConsultLayout> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main-consult')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go(AppRoutes.INITIAL),
          child: const Text('Go to the user screen'),
        ),
      ),
    );
  }
}
