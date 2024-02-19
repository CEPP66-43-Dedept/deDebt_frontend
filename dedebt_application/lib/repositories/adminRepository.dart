// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/models/advisorModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminRepository {
  final FirebaseFirestore firestore;

  AdminRepository({required this.firestore});

  Future<List<Map<String, dynamic>>> getAllUsersData(int currentindex) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot;
      if (currentindex == 1) {
        snapshot = await firestore.collection('users').get();
      } else {
        snapshot = await firestore.collection('advisors').get();
      }

      List<Map<String, dynamic>> usersData = [];
      print(currentindex);
      snapshot.docs.forEach((doc) {
        Map<String, dynamic> userData = {
          'firstName': doc['firstName'],
          'lastName': doc['lastName'],
        };
        usersData.add(userData);
      });

      return usersData;
    } catch (e) {
      print('Error fetching users data: $e');
      return [];
    }
  }

  Future<void> createAdvisor({required Advisors advisor}) async {
    String? token;
    FirebaseAuth.instance.authStateChanges().listen((user) async {
      if (user != null) {
        token = await user.getIdToken();
      } else {
        print('User is not signed in.');
      }
    });
    try {
      CollectionReference advisors = firestore.collection('advisors');
      await advisors.add(advisor.toMap());
    } catch (e) {
      print('Error creating advisor: $e');
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: advisor.email,
        password: advisor.password,
      );
      await FirebaseAuth.instance.signInWithCustomToken(token!);
    } catch (e) {
      print('Error creating user: $e');
    }
  }
}
