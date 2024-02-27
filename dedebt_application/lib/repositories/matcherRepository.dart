import 'package:cloud_firestore/cloud_firestore.dart';
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
}
