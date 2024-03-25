import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/models/advisorModel.dart';
import 'package:dedebt_application/models/assignmentModel.dart';
import 'package:dedebt_application/models/requestModel.dart';

class AdvisorRepository {
  final FirebaseFirestore _firestore;

  AdvisorRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  Future<Advisors?> getAdvisorData(String advisorId) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> advisorSnapshot =
          await _firestore.collection('advisors').doc(advisorId).get();
      if (advisorSnapshot.exists) {
        Map<String, dynamic>? advisorData = advisorSnapshot.data();
        if (advisorData != null) {
          return Advisors.fromMap(advisorData);
        } else {
          print(2);
          return null;
        }
      } else {
        print(3);
        return null;
      }
    } catch (e) {
      print('Error getting advisor data: $e');
      return null;
    }
  }

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

  Future<Request?> getRequestByrequestID(String requestID) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection("requests");
      QuerySnapshot<Object?> querySnapshot =
          await collection.where('id', isEqualTo: requestID).limit(1).get();
      if (querySnapshot.docs.isNotEmpty) {
        return Request.fromMap(
            querySnapshot.docs.first.data() as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      print('Error getting request By requestID: $e');
      return null;
    }
  }

  Future<List<Request>?> getAdvisorActiveRequest(String advisorId) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection("requests");
      QuerySnapshot<Object?> querySnapshot = await collection
          .where('advisorId', isEqualTo: advisorId)
          .where('requestStatus', whereIn: [0, 1]).get();
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
          await collection.where('advisorId', isEqualTo: advisorId).get();
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
    List<String> requestList,
    Timestamp day,
  ) async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection("assignments");

      Timestamp startOfDay = Timestamp.fromDate(
          DateTime(day.toDate().year, day.toDate().month, day.toDate().day));
      Timestamp endOfDay = Timestamp.fromDate(DateTime(
          day.toDate().year, day.toDate().month, day.toDate().day + 1));

      // Fetch documents matching taskIds
      QuerySnapshot<Object?> tasksSnapshot =
          await collection.where('taskId', whereIn: requestList).get();

      // Filter documents by appointmentTime
      List<DocumentSnapshot<Object?>> filteredDocs = [];
      for (var doc in tasksSnapshot.docs) {
        if (doc.get('appointmentTime') is Timestamp) {
          Timestamp appointmentTime = doc.get('appointmentTime') as Timestamp;
          if (appointmentTime.compareTo(startOfDay) >= 0 &&
              appointmentTime.compareTo(endOfDay) < 0) {
            filteredDocs.add(doc);
          }
        }
      }

      List<Assignment> assignments = [];
      for (var doc in filteredDocs) {
        assignments.add(Assignment.fromMap(doc.data() as Map<String, dynamic>));
      }

      return assignments;
    } catch (e) {
      print('Error getting user request: $e');
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
