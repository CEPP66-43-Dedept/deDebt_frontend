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
      print("assignmentsData");
      print(querySnapshot.docs.map((doc) => doc.data()));
      List<Assignment> assignments =
          assignmentsData.map((data) => Assignment.fromMap(data)).toList();
      return assignments;
    } catch (e) {
      print('Error getting all assignments: $e');
      return [];
    }
  }

  Future<Assignment?> getAssignmentByID(String assignmentID) {
    CollectionReference collection =
        FirebaseFirestore.instance.collection("assignments");
    return collection
        .doc(assignmentID)
        .get()
        .then(
            (value) => Assignment.fromMap(value.data() as Map<String, dynamic>))
        .catchError((error) {
      print('Error getting assignment by ID: $error');
      return null;
    });
  }

  Future<void> updateAssignmentByID(String assignmentID) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection("assignments");
      await collection.doc(assignmentID).update({'status': 0});
      print('Assignment with ID $assignmentID updated successfully.');
    } catch (error) {
      print('Error updating assignment: $error');
      throw error;
    }
  }

  Future<void> createRequest(Request userRequest) async {
    try {
      Map<String, dynamic> requestData = userRequest.toMap();
      CollectionReference requests =
          FirebaseFirestore.instance.collection('requests');
      DocumentReference newRequestRef = await requests.add(requestData);
      String requestId = newRequestRef.id;
      await newRequestRef.update({
        "id": requestId,
      });
      print('Request created successfully with ID: $requestId');
    } catch (e) {
      print('Error creating request: $e');
    }
  }
}
