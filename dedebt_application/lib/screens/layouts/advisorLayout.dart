import 'package:dedebt_application/routes/route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dedebt_application/services/authService.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      appBar: AppBar(title: const Text('Main-consult')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => signOut(),
          child: const Text('Sign out'),
        ),
      ),
    );
  }
}
