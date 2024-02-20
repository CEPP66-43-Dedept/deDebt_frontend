import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepository {
  final FirebaseFirestore _firestore;

  UserRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Future<Map<String, dynamic>?> getUserData(String userId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> userSnapshot =
          await _firestore.collection('users').doc(userId).get();
      if (userSnapshot.exists) {
        return userSnapshot.data();
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> getUserActiveRequest(String userId) async {
    try {
      print(userId);
      CollectionReference collection =
          FirebaseFirestore.instance.collection("requests");
      QuerySnapshot<Object?> querySnapshot = await collection
          .where('userId', isEqualTo: userId)
          .where('requestStatus', isEqualTo: 1)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }
}
