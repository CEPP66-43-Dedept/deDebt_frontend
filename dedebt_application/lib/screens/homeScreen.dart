import 'package:dedebt_application/routes/route.dart';
import 'package:dedebt_application/screens/layouts/advisorLayout.dart';
import 'package:dedebt_application/screens/layouts/userLayout.dart';
import 'package:dedebt_application/screens/loginScreen.dart';
import 'package:dedebt_application/services/authService.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  String? errorMessage = '';
  Future<void> signOut() async {
    try {
      await Auth().signOut();
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: Auth().authStateChanges,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final User? currentUser = snapshot.data;
            if (currentUser != null &&
                currentUser.email!.endsWith('@kmitl.ac.th')) {
              return AdvisorLayout();
            } else {
              return UserLayout();
            }

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
                    ),
                    ElevatedButton(
                      onPressed: () => signOut(),
                      child: const Text('Sign out'),
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
