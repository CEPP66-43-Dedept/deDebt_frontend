import 'package:dedebt_application/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdvisorLayout extends StatefulWidget {
  const AdvisorLayout({super.key});

  @override
  State<AdvisorLayout> createState() => _AdvisorLayoutState();
}

class _AdvisorLayoutState extends State<AdvisorLayout> {
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
