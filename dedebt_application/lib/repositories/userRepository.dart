import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/models/assignmentModel.dart';
import 'package:dedebt_application/models/requestModel.dart';

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
          .where('requestStatus', whereIn: [0, 1])
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting user active request: $e');
      return null;
    }
  }

  Future<List<Request>?> getUserAllRequests(String userId) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection("requests");
      QuerySnapshot<Object?> querySnapshot =
          await collection.where('userId', isEqualTo: userId).get();
      List<Map<String, dynamic>> requestsData = [];
      print(querySnapshot.docs.map((doc) => doc.data()));
      if (querySnapshot.docs.isNotEmpty) {
        requestsData = querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      }
      List<Request> requests =
          requestsData.map((data) => Request.fromMap(data)).toList();
      return requests;
    } catch (e) {
      print('Error getting user  request: $e');
      return null;
    }
  }

  Future<List<Assignment>> getActiveAssignments(String taskId) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection("assignments");
      QuerySnapshot<Object?> querySnapshot = await collection
          .where('taskId', isEqualTo: taskId)
          .where('status', isEqualTo: 1)
          .get();
      List<Map<String, dynamic>> assignmentsData = [];
      if (querySnapshot.docs.isNotEmpty) {
        assignmentsData = querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      }
      List<Assignment> assignments =
          assignmentsData.map((data) => Assignment.fromMap(data)).toList();

      return assignments;
    } catch (e) {
      print('Error getting active assignments: $e');
      return [];
    }
  }

  Future<List<Assignment>> getAllAssignments(String taskId) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection("assignments");
      QuerySnapshot<Object?> querySnapshot =
          await collection.where('taskId', isEqualTo: taskId).get();
      List<Map<String, dynamic>> assignmentsData = [];
      if (querySnapshot.docs.isNotEmpty) {
        assignmentsData = querySnapshot.docs
            .map((doc) => doc.data() as Map<String, dynamic>)
            .toList();
      }
      List<Assignment> assignments =
          assignmentsData.map((data) => Assignment.fromMap(data)).toList();
      return assignments;
    } catch (e) {
      print('Error getting all assignments: $e');
      return [];
    }
  }
}
