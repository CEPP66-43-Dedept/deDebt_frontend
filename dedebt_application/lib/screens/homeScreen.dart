import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/screens/layouts/advisorLayout.dart';
import 'package:dedebt_application/screens/layouts/userLayout.dart';
import 'package:dedebt_application/screens/loginScreen.dart';
import 'package:dedebt_application/screens/registerScreen.dart';
import 'package:dedebt_application/services/authService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Auth _auth = Auth();
  final StreamController<User?> userStateController = StreamController();

  void initState() {
    super.initState();
    _auth.authStateChanges.listen((user) {
      userStateController.add(user); // Update with current user
    });
  }

  String? errorMessage = '';
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  final StreamController<String> controller = StreamController();

  void addData() {
    controller.add("user");
  }

  Future<bool> checkUserAndNavigate(BuildContext context) async {
    final User? currentUser = FirebaseAuth.instance.currentUser;
    final bool userExists = await _checkIfUserExists(currentUser);

    if (userExists) {
      addData();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> _checkIfUserExists(User? currentUser) async {
    if (currentUser == null) {
      return false;
    }

    final CollectionReference users =
        FirebaseFirestore.instance.collection('users');
    final QuerySnapshot querySnapshot =
        await users.where('email', isEqualTo: currentUser.email).get();

    return querySnapshot.docs.isNotEmpty;
  }

  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: userStateController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final User? currentUser = snapshot.data;
          return _handleUserNavigation(currentUser);
        } else {
          return LoginScreen();
        }
      },
    );
  }

  Widget _handleUserNavigation(User? currentUser) {
    if (currentUser == null) {
      return LoginScreen();
    }

    return FutureBuilder<bool>(
      future: _checkIfUserExists(currentUser),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final bool userExists = snapshot.data!;
          if (userExists) {
            if (currentUser.email!.endsWith('@kmitl.ac.th')) {
              return AdvisorLayout();
            } else {
              return UserLayout();
            }
          } else {
            return RegisterScreen(email: currentUser.email!);
          }
        } else if (snapshot.hasError) {
          return Text('Error checking user data');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  @override
  void dispose() {
    userStateController.close();
    super.dispose();
  }
}
