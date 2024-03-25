import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/repositories/advisorRepository.dart';
import 'package:dedebt_application/services/advisorService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dedebt_application/screens/layouts/advisorLayout.dart';
import 'package:dedebt_application/models/requestModel.dart';

class requestListAdvisorScreen extends StatefulWidget {
  const requestListAdvisorScreen({super.key});
  @override
  State<requestListAdvisorScreen> createState() => _requestListAdvisorScreen();
}

class _requestListAdvisorScreen extends State<requestListAdvisorScreen> {
  //Mockup Data
  static Color primaryColor = const Color(0xFFF3F5FE);
  late final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final AdvisorRepository _advisorRepository =
      AdvisorRepository(firestore: firestore);
  late final AdvisorService _advisorService =
      AdvisorService(advisorRepository: _advisorRepository);
  late StreamController<List<Request>> _advisorRequestController;
  late User? user = FirebaseAuth.instance.currentUser;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _advisorRequestController = StreamController<List<Request>>();
    _getAdvisorActiveRequests(user!.uid).then((requestData) {
      _advisorRequestController.add(requestData!);
    }).catchError((error) {
      print('Error fetching user requests: $error');
      _advisorRequestController.addError(error);
    });
  }

  @override
  void dispose() {
    _advisorRequestController.close();
    super.dispose();
  }

  Future<List<Request>?> _getAdvisorActiveRequests(String userId) async {
    return _advisorService.getAdvisorActiveRequest(userId);
  }

  dynamic getBody(List<Request>? requests) {
    bool isHavedata = false;
    List<Widget> containerList = [
      const SizedBox(height: 10),
    ];

    List<Request> _request = requests ?? [];
    //สร้าง Listview ที่จะมีคำร้องต่างๆ ของ User
    for (Request requestItem in _request) {
      Widget container = AdvisorLayout.createRequestBox(context, requestItem);
      containerList.add(container);
      containerList.add(const SizedBox(height: 10));
    }
    return Scaffold(
      body: Center(
          child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(10, 25, 10, 20),
            child: Text(
              "คำร้องปัจจุบัน",
              style: TextStyle(fontSize: 24),
            ),
          ),
          RawScrollbar(
            thumbColor: const Color(0xFFBBB9F4),
            thumbVisibility: true,
            radius: const Radius.circular(20),
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
            thickness: 5,
            child: DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
              child: SizedBox(
                height: 552,
                width: 344,
                child: ListView.builder(
                  itemCount: containerList.length,
                  itemBuilder: (context, index) {
                    return containerList[index];
                  },
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Request>>(
        stream: _advisorRequestController.stream,
        builder: (context, snapshot) {
          return Scaffold(
            body: getBody(snapshot.data),
          );
        });
  }
}
