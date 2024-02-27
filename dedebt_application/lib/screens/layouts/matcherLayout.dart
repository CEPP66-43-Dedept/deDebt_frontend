import 'package:dedebt_application/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MatcherLayout extends StatefulWidget {
  const MatcherLayout({super.key});

  @override
  State<MatcherLayout> createState() => _MatcherLayoutState();
}

class _MatcherLayoutState extends State<MatcherLayout> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main-matcher')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => context.go(AppRoutes.INITIAL),
          child: const Text('Go to the user screen'),
        ),
      ),
    );
  }
}
