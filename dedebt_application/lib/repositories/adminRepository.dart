import 'package:cloud_firestore/cloud_firestore.dart';

class AdminRepository {
  final FirebaseFirestore firestore;

  AdminRepository({required this.firestore});

  Future<List<Map<String, dynamic>>> getAllUsersData(int currentindex) async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot;
      if (currentindex == 1) {
        snapshot = await firestore.collection('users').get();
      } else {
        snapshot = await firestore.collection('advisor').get();
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
}
