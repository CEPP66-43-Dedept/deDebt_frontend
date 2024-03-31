import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/models/advisorModel.dart';
import 'package:dedebt_application/models/assignmentModel.dart';
import 'package:dedebt_application/models/requestModel.dart';

class MatcherRepository {
  final FirebaseFirestore _firestore;

  MatcherRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;
  Stream<List<Request>> getWaitingRequest() {
    try {
      CollectionReference collection = _firestore.collection("requests");
      Stream<QuerySnapshot> snapshots =
          collection.where('requestStatus', isEqualTo: 0).snapshots();

      return snapshots.map((snapshot) {
        List<Request> requests = snapshot.docs.map((doc) {
          return Request.fromMap(doc.data() as Map<String, dynamic>);
        }).toList();
        return requests;
      });
    } catch (e) {
      print('Error getting user data: $e');
      return Stream.error('Error getting user data: $e');
    }
  }

  Future<List<Advisors>> getAllAdvisorsData() async {
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('advisors').get();

      List<Advisors> usersData = [];
      snapshot.docs.forEach((doc) {
        usersData.add(Advisors.fromMap(doc.data()));
      });
      print(usersData);
      return usersData;
    } catch (e) {
      print('Error fetching users data: $e');
      return [];
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

  Future<void> createFirstAssignment(Request request) async {
    try {
      QuerySnapshot assignmentSnapshot = await FirebaseFirestore.instance
          .collection("assignments")
          .where("taskId", isEqualTo: request.id)
          .get();

      if (assignmentSnapshot.docs.isNotEmpty) {
        print("Assignment already exists for this request.");
        return;
      }
      Assignment assignment = Assignment(
        type: 1,
        title: "การนัดหมายครั้งแรก",
        detail: "การนัดหมายสำหรับพูดคุยครั้งแรก",
        status: 1,
        taskId: request.id,
        startTime: Timestamp.now(),
        endTime: Timestamp.now(),
      );
      DocumentReference docRef = await FirebaseFirestore.instance
          .collection("assignments")
          .add(assignment.toMap());
      String assignmentId = docRef.id;
      assignment.id = assignmentId;
      await docRef.update({"id": assignmentId});

      print('Assignment created successfully with ID: $assignmentId');
    } catch (e) {
      print('Error creating assignment: $e');
    }
  }

  Future<void> matchRequestWithAdvisor(
      Advisors advisors, Request request) async {
    try {
      await FirebaseFirestore.instance
          .collection('requests')
          .doc(request.id)
          .update({
        'advisorId': advisors.uid,
        'advisorFullName': "${advisors.firstname} ${advisors.lastname}",
        'requestStatus': 1
      });
      await createFirstAssignment(request);
      print('Successfully updated aid in the request document.');
    } catch (e) {
      print('Error updating aid in the request document: $e');
    }
  }
}
