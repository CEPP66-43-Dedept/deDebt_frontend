import 'package:dedebt_application/routes/route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String tel,
    required BuildContext context,
  }) async {
    try {
      CollectionReference users = _firestore.collection('users');
      final user = <String, String>{
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'tel': tel,
        'role': 'user'
      };
      await users.add(user);
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential != null) {
        context.go(AppRoutes.INITIAL);
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<bool?> checkData(User? currentUser) async {
    try {
      CollectionReference users = _firestore.collection('users');
      final QuerySnapshot querySnapshot =
          await users.where('email', isEqualTo: currentUser!.email).get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      return false;
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
            accessToken: googleSignInAuthentication.accessToken);
        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        final currentUser = _firebaseAuth.currentUser;

        final userExists = await checkData(currentUser);
        if (currentUser != null && userExists != null && userExists) {
          context.go(AppRoutes.INITIAL);
        } else {
          context.go(AppRoutes.Register + "/" + currentUser!.email!);
        }
      }
    } catch (e) {
      print('Error signing in with Google: $e');
    }
  }
}
