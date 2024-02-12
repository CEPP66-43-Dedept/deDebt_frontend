import 'package:dedebt_application/services/authService.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

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

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main-user')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => signOut(),
          child: const Text('Sign out'),
        ),
      ),
    );
  }
}
