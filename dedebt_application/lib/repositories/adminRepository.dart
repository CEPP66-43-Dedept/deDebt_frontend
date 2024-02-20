// ignore_for_file: avoid_print, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/models/advisorModel.dart';
import 'package:dedebt_application/services/authService.dart';
import 'package:dedebt_application/variables/rolesEnum.dart';
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
          'uid': doc['uid'],
        };
        usersData.add(userData);
      });

      return usersData;
    } catch (e) {
      print('Error fetching users data: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>> getUserDataById(String uid, Roles role) async {
    try {
      if (role == Roles.USER) {
        QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
            .instance
            .collection('users')
            .where('uid', isEqualTo: uid)
            .get();

        if (snapshot.docs.isNotEmpty) {
          Map<String, dynamic> userData = snapshot.docs.first.data();
          return userData;
        } else {
          return {};
        }
      } else if (role == Roles.ADVISOR) {
        QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
            .instance
            .collection('advisors')
            .where('uid', isEqualTo: uid)
            .get();
        if (snapshot.docs.isNotEmpty) {
          Map<String, dynamic> userData = snapshot.docs.first.data();
          return userData;
        } else {
          return {};
        }
      } else {
        return {};
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return {};
    }
  }

/*  Future<void> deleteUserByID(
      {required String uid, required Roles role}) async {
    late String collectionName;
    if (role == Roles.ADVISOR) {
      collectionName = "advisors";
    } else {
      collectionName = "users";
    }
    CollectionReference collection =
        FirebaseFirestore.instance.collection(collectionName);
    await collection.doc(uid).delete();
  }*/
  Future<void> deleteUserByID(
      {required String uid, required Roles role}) async {
    try {
      String collectionName = role == Roles.ADVISOR ? "advisors" : "users";
      CollectionReference collection =
          FirebaseFirestore.instance.collection(collectionName);

      QuerySnapshot<Object?> querySnapshot =
          await collection.where('uid', isEqualTo: uid).get();
      if (querySnapshot.docs.isNotEmpty) {
        await querySnapshot.docs.first.reference.delete();
        print(
            'Document with UID: $uid deleted successfully from $collectionName collection');
      } else {
        print('No document with UID: $uid found in $collectionName collection');
      }
    } catch (e) {
      print('Error deleting document: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await Auth().signOut();
    } on FirebaseAuthException {}
  }

  Future<void> createAdvisor({required Advisors advisor}) async {
    String? token = '';
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        token = await user.getIdToken();
        print("nowToken$token");
      } else {
        print('No user is currently signed in.');
      }
    } catch (e) {
      print('Error getting Firebase auth token: $e');
    }

    try {
      CollectionReference advisors = firestore.collection('advisors');
      DocumentReference docRef = await advisors.add(advisor.toMap());
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: advisor.email,
          password: advisor.password,
        );
        String advisorUid = userCredential.user?.uid ?? '';
        FirebaseAuth.instance.signOut();
        FirebaseAuth.instance.signInWithCustomToken(token!);

        advisor.uid = await advisorUid;
        await docRef.update({'uid': advisorUid});
      } else {
        print('User is not signed in.');
      }
    } catch (e) {
      print('Error creating advisor or user: $e');
    }
  }
}
