import 'package:cloud_firestore/cloud_firestore.dart';

class AdminRepository {
  final FirebaseFirestore firestore;

  AdminRepository({required this.firestore});

  Future<List<Map<String, dynamic>>> getAllUsersData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await firestore.collection('users').get();

      List<Map<String, dynamic>> usersData = [];
      snapshot.docs.forEach((doc) {
        Map<String, dynamic> userData = {
          'username': doc['username'],
          'lastname': doc['lastname'],
        };
        usersData.add(userData);
      });

      return usersData;
    } catch (e) {
      // Handle error
      print('Error fetching users data: $e');
      return [];
    }
  }
}
