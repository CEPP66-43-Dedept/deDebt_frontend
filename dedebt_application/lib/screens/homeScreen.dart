// ignore: file_names
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/screens/User/homeUserScreen.dart';
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
  final Auth _auth = Auth();
  final StreamController<User?> userStateController = StreamController();

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges.listen((user) {
      userStateController.add(user);
    });
  }

  String? errorMessage = '';
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException {}
  }

  final StreamController<String> controller = StreamController();

  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: userStateController.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final User? currentUser = snapshot.data;
          return _handleUserNavigation(currentUser);
        } else {
          return const LoginScreen();
        }
      },
    );
  }

  Widget _handleUserNavigation(User? currentUser) {
    if (currentUser == null) {
      return const LoginScreen();
    }

    return FutureBuilder<Map<String, dynamic>>(
      future: _getUserData(currentUser),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else {
          if (snapshot.hasError) {
            return const Text('Error checking user data');
          } else {
            final userData = snapshot.data!;
            final String? collection = userData['collection'];
            print(userData);

            if (collection == 'advisor') {
              return const AdvisorLayout();
            } else if (collection == 'users') {
              return UserLayout(Body: const homeUserScreen(), currentPage: 0);
            } else {
              return RegisterScreen(
                email: currentUser.email,
              );
            }
          }
        }
      },
    );
  }

  Future<Map<String, dynamic>> _getUserData(User currentUser) async {
    final QuerySnapshot<Map<String, dynamic>> userSnapshot =
        await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: currentUser.email)
            .get();
    if (userSnapshot.docs.isNotEmpty) {
      return {'collection': 'users'};
    }

    final QuerySnapshot<Map<String, dynamic>> advisorSnapshot =
        await FirebaseFirestore.instance
            .collection('advisor')
            .where('email', isEqualTo: currentUser.email)
            .get();
    if (advisorSnapshot.docs.isNotEmpty) {
      return {'collection': 'advisor'};
    }

    return {'collection': 'none'};
  }
  // Future<Map<String, dynamic>> _getUserData(User currentUser) async {
  //   final DocumentSnapshot<Map<String, dynamic>> userSnapshot =
  //       await FirebaseFirestore.instance
  //           .collection('users')
  //           .doc(currentUser.uid)
  //           .get();
  //   if (userSnapshot.exists) {
  //     if (userSnapshot.data()!['email'] == currentUser.email) {
  //       return {'collection': 'users'};
  //     }
  //   }

  //   final DocumentSnapshot<Map<String, dynamic>> advisorSnapshot =
  //       await FirebaseFirestore.instance
  //           .collection('advisor')
  //           .doc(currentUser.uid)
  //           .get();
  //   if (advisorSnapshot.exists) {
  //     if (advisorSnapshot.data()!['email'] == currentUser.email) {
  //       return {'collection': 'advisor'};
  //     }
  //   }

  //   return {'collection': 'none'};
  // }

  @override
  void dispose() {
    userStateController.close();
    super.dispose();
  }
}
