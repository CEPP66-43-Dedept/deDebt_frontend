import 'dart:async';

import 'package:dedebt_application/repositories/userRepository.dart';
import 'package:dedebt_application/routes/route.dart';
import 'package:dedebt_application/services/userService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dedebt_application/models/assignmentModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class appointmentUserScreen extends StatefulWidget {
  final assignmentId;
  const appointmentUserScreen({super.key, this.assignmentId});

  @override
  State<appointmentUserScreen> createState() => _appointmentUserScreen();
}

class _appointmentUserScreen extends State<appointmentUserScreen> {
  late final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final UserRepository userRepository =
      UserRepository(firestore: firestore);
  late final UserService userService =
      UserService(userRepository: userRepository);
  late StreamController<Assignment?> _userAssignmentController;
  //Mockup Data
  Future<Assignment?> _getAssignmentByID(String assign) async {
    return userService.getAssignmentByID(assign);
  }

  Assignment? userAppointment = Assignment(
      type: 1,
      title: '',
      detail: '',
      status: 1,
      taskId: '',
      startTime: Timestamp.now(),
      endTime: Timestamp.now());
  static Color appBarColor = const Color(0xFF444371);
  @override
  void initState() {
    super.initState();
    _userAssignmentController = StreamController<Assignment?>();
    _getAssignmentByID(widget.assignmentId).then((assignmentData) {
      _userAssignmentController.add(assignmentData);
    }).catchError((error) {
      _userAssignmentController.addError(error);
    });
  }

  Future<void> _updateAssignmentStatus(String assignmentId) async {
    return userService.updateAssignmentStatus(assignmentId);
  }

  void dispose() {
    _userAssignmentController.close();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return StreamBuilder<Assignment?>(
        stream: _userAssignmentController.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching assignments'));
          }
          userAppointment = snapshot.data;

          return Scaffold(
            appBar: AppBar(
                backgroundColor: appBarColor,
                surfaceTintColor: Colors.transparent,
                toolbarHeight: 55,
                title: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        context.go(AppRoutes.ASSIGNMENT_USER +
                            '/' +
                            widget.assignmentId);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        size: 35,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      width: 65,
                    ),
                    const Text(
                      "นัดหมายเวลา",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    )
                  ],
                )),
            body: Align(
              alignment: Alignment.center,
              child: DefaultTextStyle(
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: const Color(0xFF000000),
                      fontSize: 18.0,
                    ),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.access_time,
                            size: 65,
                            color: Color(0xFF36338C),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "ยืนยันวันเวลานัดหมาย",
                            style: TextStyle(
                                fontSize: 24, color: Color(0xFF36338C)),
                          )
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 45),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("เวลาที่นัดหมาย"),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              width: 304,
                              height: 46,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    offset: Offset(0.0, 4.0),
                                    blurRadius: 4.0,
                                    spreadRadius: 1.0,
                                  ),
                                ],
                              ),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${DateFormat("HH:mm").format(userAppointment!.startTime.toDate())} - ${DateFormat("HH:mm").format(userAppointment!.endTime.toDate())}",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 45),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("รายละเอียด"),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 25),
                              width: 304,
                              height: 280,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    offset: Offset(0.0, 4.0),
                                    blurRadius: 4.0,
                                    spreadRadius: 1.0,
                                  ),
                                ],
                              ),
                              child: SingleChildScrollView(
                                child: Text(
                                  userAppointment!.detail,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ),
            bottomNavigationBar: Container(
              width: 390,
              height: 165,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              color: Colors.white,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // แจ้งหมายเหตุ function
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFF18F80),
                            ),
                            child: const Text(
                              'ไม่สะดวกวันเวลาที่นัดหมาย',
                              style: TextStyle(
                                  fontSize: 18.0, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              // Handle button press
                              _updateAssignmentStatus(widget.assignmentId);
                              context.go(AppRoutes.ASSIGNMENT_SUCCESS_USER +
                                  '/' +
                                  '${widget.assignmentId}' +
                                  '/' +
                                  '1');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF2DC09C),
                            ),
                            child: const Text(
                              'ยืนยันการนัด',
                              style: TextStyle(
                                  fontSize: 18.0,
                                  color: Colors.white), // Set text color
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
