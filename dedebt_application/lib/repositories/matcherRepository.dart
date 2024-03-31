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

  Future<List<Advisors>> processTimestampData(Timestamp timestamp) async {
    try {
      DateTime dateTime = timestamp.toDate();
      print(dateTime);
      QuerySnapshot<Map<String, dynamic>> assignmentSnapshotStartTime =
          await FirebaseFirestore.instance
              .collection('assignments')
              .where('startTime', isLessThanOrEqualTo: dateTime)
              .get();
      QuerySnapshot<Map<String, dynamic>> assignmentSnapshotEndTime =
          await FirebaseFirestore.instance
              .collection('assignments')
              .where('endTime', isGreaterThanOrEqualTo: dateTime)
              .get();
      List<String> taskIdsStartTime = assignmentSnapshotStartTime.docs
          .map((doc) => doc['taskId'] as String)
          .toList();
      List<String> taskIdsEndTime = assignmentSnapshotEndTime.docs
          .map((doc) => doc['taskId'] as String)
          .toList();

      List<String> commonTaskIds = taskIdsStartTime
          .where((taskId) => taskIdsEndTime.contains(taskId))
          .toList();

      if (commonTaskIds.isNotEmpty) {
        QuerySnapshot<Map<String, dynamic>> requestSnapshot =
            await FirebaseFirestore.instance
                .collection('requests')
                .where('id', whereIn: commonTaskIds)
                .get();

        List<String> advisorIds = requestSnapshot.docs
            .map((doc) => doc['advisorId'] as String)
            .toList();

        List<Advisors> allAdvisors = await getAllAdvisorsData();
        List<Advisors> unavailableAdvisors = await FirebaseFirestore.instance
            .collection('advisors')
            .where('uid', whereNotIn: advisorIds)
            .get()
            .then((querySnapshot) => querySnapshot.docs
                .map((doc) => Advisors.fromMap(doc.data()))
                .toList());
        print('Unavailable Advisors:');
        for (var advisor in unavailableAdvisors) {
          print('Advisor UID: ${advisor.uid}');
        }

        return unavailableAdvisors;
      } else {
        return [];
      }
    } catch (e) {
      print('Error processing timestamp data: $e');
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
