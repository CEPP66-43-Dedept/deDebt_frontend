import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/models/advisorModel.dart';
import 'package:dedebt_application/models/requestModel.dart';
import 'package:dedebt_application/repositories/matcherRepository.dart';
import 'package:dedebt_application/variables/color.dart';
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
        width: MediaQuery.of(context).size.width,
        height: 700,
        child: DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.black,
                fontSize: 25.0,
              ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.arrow_back_ios, color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                    ),
                    Text("รายชื่อผู้ให้คำปรึกษา"),
                  ],
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Icon(
                    Icons.person_rounded,
                    size: 80,
                    color: ColorGuide.blueAccent,
                  ),
                  Text(
                    "${advisor.firstname} ${advisor.lastname}",
                    style: TextStyle(color: ColorGuide.blueAccent),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 25,
                  ),
                  Text("รายละเอียดผู้ให้คำปรึกษา"),
                ],
              ),
              Container(
                width: 338,
                height: 395,
                margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: ColorGuide.blueLight,
                ),
                child: SingleChildScrollView(
                    child: Text(
                  "ข้อมูลการติดต่อ\nEmail: ${advisor.email}\nเบอร์โทร ${advisor.tel}\nSpacialist\n${advisor.specialist}",
                  style: TextStyle(fontSize: 18),
                )),
              ),
              Container(
                width: 325,
                height: 62,
                child: ElevatedButton(
                  child: Center(
                      child: Text(
                    "จับคู่",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  )),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorGuide.greenAccent,
                  ),
                  onPressed: () {
                    _assignAdvisorToRequest(advisor, currentRequest);
                    context.go(AppRoutes.INITIAL);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
