import 'package:dedebt_application/routes/route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String firstName,
      required String lastName,
      required String tel,
      required BuildContext context}) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final FirebaseFirestore _firestore = FirebaseFirestore.instance;
      CollectionReference users = _firestore.collection('users');
      final user = <String, String>{
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'tel': tel,
      };
      users.add(user);

      if (userCredential != null) {
        context.go(AppRoutes.INITIAL);
      } else {
        print('Error creating user');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        print('Email: ${googleSignInAccount.email}');

        context.go(
          AppRoutes.Register + "/" + googleSignInAccount.email,
        );
      }
    } catch (e) {}
  }
}
