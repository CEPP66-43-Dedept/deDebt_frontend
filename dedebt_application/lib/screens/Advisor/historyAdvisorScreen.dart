import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/models/requestModel.dart';
import 'package:dedebt_application/repositories/advisorRepository.dart';
import 'package:dedebt_application/screens/layouts/advisorLayout.dart';
import 'package:dedebt_application/services/advisorService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class historyAdvisorScreen extends StatefulWidget {
  const historyAdvisorScreen({super.key});

  State<historyAdvisorScreen> createState() => _historyAdvisorScreen();
}

class _historyAdvisorScreen extends State<historyAdvisorScreen> {
  static Color primaryColor = const Color(0xFFF3F5FE);
  //Mockup Data
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
    _getAdvisorAllRequests(user!.uid).then((requestData) {
      _advisorRequestController.add(requestData!);
    }).catchError((error) {
      print('Error fetching user requests: $error');
      _advisorRequestController.addError(error);
    });
  }

  Future<String?> _getUserName(String userId) async {
    return _advisorService.getUserFullnameByID(userId);
  }

  @override
  void dispose() {
    _advisorRequestController.close();
    super.dispose();
  }

  Future<List<Request>?> _getAdvisorAllRequests(String userId) async {
    return _advisorService.getAdvisorAllRequests(userId);
  }

  List<Request> requests = [
    Request(
        id: "xx",
        title: "แก้หนี้",
        detail: "หนี้",
        userId: "xxx",
        advisorId: "advisorId",
        userFullName: " userFullName",
        advisorFullName: " advisorFullName",
        requestStatus: 0,
        type: ["type"],
        debtStatus: [0],
        provider: ["ser"],
        branch: ["sef"],
        revenue: [12345],
        expense: [123],
        burden: 1,
        property: 123,
        appointmentDate: [1])
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text('ประวัติคำร้อง'),
      ),
      body: StreamBuilder<List<Request>>(
        stream: _advisorRequestController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return RawScrollbar(
              thumbColor: const Color(0xFFBBB9F4),
              thumbVisibility: true,
              radius: const Radius.circular(20),
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20),
              thickness: 5,
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder<String?>(
                      future: _getUserName(snapshot.data![index].userId),
                      builder: (context, userSnapshot) {
                        if (userSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Container();
                        }
                        if (userSnapshot.hasError) {
                          return Text('Error: ${userSnapshot.error}');
                        }
                        final userName = userSnapshot.data ?? 'สมศรี มีดี';
                        return Column(
                          children: [
                            AdvisorLayout.createRequestBox(
                              context,
                              snapshot.data![index],
                              userName,
                            ),
                            SizedBox(height: 10),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Image(image: AssetImage('assets/images/Nothing.png')),
                  Text('ไม่มีคำร้อง'),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
