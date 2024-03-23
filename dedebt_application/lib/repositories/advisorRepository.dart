import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/models/assignmentModel.dart';
import 'package:dedebt_application/models/requestModel.dart';

class AdvisorRepository {
  final FirebaseFirestore _firestore;

  AdvisorRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Future<List<Request>?> getAdvisorAllRequests(String advisorId) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection("requests");
      QuerySnapshot<Object?> querySnapshot =
          await collection.where('advisorId', isEqualTo: advisorId).get();
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

  Future<void> createAssignment(Assignment assignment) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection("assignments");
      await collection.add(assignment.toMap());
    } catch (e) {
      print('Error creating assignment: $e');
    }
  }

  Future<String?> getUserFullnameByID(String userId) async {
    try {
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection("users");
      DocumentSnapshot userSnapshot = await usersCollection.doc(userId).get();

      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        String firstName = userData['firstName'] ?? '';
        String lastName = userData['lastName'] ?? '';
        return '$firstName $lastName';
      } else {
        print('User with ID $userId not found');
        return null;
      }
    } catch (e) {
      print('Error getting user data: $e');
      return null;
    }
  }

  Future<List<String>> getAdvisorAllRequestsIds(String advisorId) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection("requests");
      QuerySnapshot<Object?> querySnapshot =
          await collection.where('userId', isEqualTo: advisorId).get();
      List<String> requestsData = [];
      if (querySnapshot.docs.isNotEmpty) {
        requestsData = querySnapshot.docs.map((doc) => doc.id).toList();
      }
      return requestsData;
    } catch (e) {
      print('Error getting user  request: $e');
      return [];
    }
  }

  Future<List<Assignment>> getAssignmentByDay(
      List<String> requestList, Timestamp day) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection("assignments");
      QuerySnapshot<Object?> querySnapshot = await collection
          .where('taskId', whereIn: requestList)
          .where('starttime', isGreaterThanOrEqualTo: day)
          .where('starttime', isLessThan: day.toDate().add(Duration(days: 1)))
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
      print('Error getting user  request: $e');
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
}
