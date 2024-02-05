import 'package:dedebt_application/routes/route.dart';
import 'package:dedebt_application/screens/loginScreen.dart';
import 'package:dedebt_application/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: null,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(title: const Text('Home')),
              body: Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () => context.go(AppRoutes.MAIN_USER),
                      child: const Text('Go to main_user'),
                    ),
                    ElevatedButton(
                      onPressed: () => context.go(AppRoutes.SIGN_IN),
                      child: const Text('Go to sign in'),
                    ),
                    ElevatedButton(
                      onPressed: () => context.go(AppRoutes.MAIN_ADVISOR),
                      child: const Text('Go to consult'),
                    ),
                    ElevatedButton(
                      onPressed: () => context.go(AppRoutes.MAIN_ADMIN),
                      child: const Text('Go to admin'),
                    ),
                    ElevatedButton(
                      onPressed: () => context.go(AppRoutes.MAIN_MATCHER),
                      child: const Text('Go to matcher'),
                    )
                  ],
                ),
              ),
            );
          } else {
            return LoginScreen();
          }
        });
  }
}
