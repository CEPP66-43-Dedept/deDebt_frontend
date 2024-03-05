import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/models/assignmentModel.dart';
import 'package:dedebt_application/repositories/userRepository.dart';
import 'package:dedebt_application/services/userService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dedebt_application/screens/layouts/userLayout.dart';
import 'package:dedebt_application/models/requestModel.dart';

class HistoryUserScreen extends StatefulWidget {
  const HistoryUserScreen({Key? key});

  @override
  State<HistoryUserScreen> createState() => _HistoryUserScreenState();
}

class _HistoryUserScreenState extends State<HistoryUserScreen> {
  static Color primaryColor = const Color(0xFFF3F5FE);
  late final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final UserRepository userRepository =
      UserRepository(firestore: firestore);
  late final UserService userService =
      UserService(userRepository: userRepository);
  late StreamController<List<Request>> _userRequestController;
  late User? user = FirebaseAuth.instance.currentUser;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    _userRequestController = StreamController<List<Request>>();
    _getUserAllRequests(user!.uid).then((requestData) {
      _userRequestController.add(requestData!);
    }).catchError((error) {
      print('Error fetching user requests: $error');
      _userRequestController.addError(error);
    });
  }

  @override
  void dispose() {
    _userRequestController.close();
    super.dispose();
  }

  Future<List<Request>?> _getUserAllRequests(String userId) async {
    // Call the service method to get all user requests
    return userService.getUserAllRequests(userId);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Request>>(
      stream: _userRequestController.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading indicator while waiting for data
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Show error message if there's an error
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData) {
          // Show empty state if there's no data
          return Scaffold(
            appBar: AppBar(
              title: const Text('ประวัติคำร้อง'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Image(image: AssetImage('assets/images/Nothing.png')),
                  Text('ไม่มีคำร้อง'),
                ],
              ),
            ),
          );
        } else {
          List<Request> requests = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              backgroundColor: primaryColor,
              title: const Text('ประวัติคำร้อง'),
            ),
            body: RawScrollbar(
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
                  itemCount: requests.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        UserLayout.createRequestBox(requests[index]),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
