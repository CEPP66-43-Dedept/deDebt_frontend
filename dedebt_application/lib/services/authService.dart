import 'package:dedebt_application/routes/route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/material.dart';

import 'package:dedebt_application/variables/rolesEnum.dart' as role;

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

  Future<void> updatePassword(User user, String newPassword) async {
    try {
      await user.updatePassword(newPassword);
      // ignore: empty_catches
    } catch (e) {}
  }

  bool isGoogleSignIn(User user) {
    return user.providerData
        .any((userInfo) => userInfo.providerId == 'google.com');
  }

  bool isEmailPasswordSignIn(User user) {
    return user.providerData
        .any((userInfo) => userInfo.providerId == 'password');
  }

  void updateUserPassword(User user, String newPassword) {
    if (isEmailPasswordSignIn(user)) {
      updatePassword(user, newPassword);
    } else {}
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
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser != null) {
        updateUserPassword(currentUser, password);
      }

      CollectionReference users = _firestore.collection('users');

      final user = <String, dynamic>{
        'uid': currentUser?.uid,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'tel': tel,
        'role': role.Roles.USER.index,
      };

      await users.doc(currentUser?.uid).set(user);
      // ignore: empty_catches
    } catch (e) {}
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
    final GoogleSignIn googleSignIn = GoogleSignIn();
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final currentUser = _firebaseAuth.currentUser;

        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);
        // ignore: unused_local_variable
        final UserCredential userCredential =
            await _firebaseAuth.signInWithCredential(credential);
        final userExists = await checkData(currentUser);
        if (currentUser != null && userExists != null && userExists) {
          // ignore: use_build_context_synchronously
          context.go(AppRoutes.INITIAL);
        } else {
          // ignore: use_build_context_synchronously
          context.go("${AppRoutes.Register}/${currentUser!.email!}");
        }
      }
    } catch (e) {}
  }
}
