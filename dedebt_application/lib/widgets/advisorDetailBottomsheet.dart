import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/models/advisorModel.dart';
import 'package:dedebt_application/models/requestModel.dart';
import 'package:dedebt_application/repositories/matcherRepository.dart';
import 'package:dedebt_application/routes/route.dart';
import 'package:dedebt_application/services/matcherService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AdvisorDetailBotomsheet extends StatelessWidget {
  final Request currentRequest;
  final Advisors advisor;

  AdvisorDetailBotomsheet(
      {required this.advisor, required this.currentRequest, Key? key})
      : super(key: key);

  @override
  late final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final MatcherRepository _matcherRepository =
      MatcherRepository(firestore: firestore);
  late MatcherService _matcherService =
      MatcherService(matcherRepository: _matcherRepository);
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> _assignAdvisorToRequest(
      Advisors advisors, Request request) async {
    try {
      await _matcherService.matchRequestWithAdvisor(advisor, currentRequest);
      print('Advisor assigned successfully to request.');
    } catch (e) {
      print('Error assigning advisor to request: $e');
    }
  }

  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: ElevatedButton(
          child: Text("Assign Advisor"),
          onPressed: () {
            _assignAdvisorToRequest(advisor, currentRequest);
            context.go(AppRoutes.INITIAL);
          },
        ),
      ),
    );
  }
}
