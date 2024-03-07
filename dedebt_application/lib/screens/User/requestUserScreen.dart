import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/repositories/userRepository.dart';
import 'package:dedebt_application/services/userService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dedebt_application/screens/layouts/userLayout.dart';
import 'package:dedebt_application/models/requestModel.dart';
import 'package:dedebt_application/models/assignmentModel.dart';
import 'package:go_router/go_router.dart';
import 'package:dedebt_application/routes/route.dart';

class requestUserScreen extends StatefulWidget {
  const requestUserScreen({super.key});

  @override
  State<requestUserScreen> createState() => _requestUserScreen();
}

class _requestUserScreen extends State<requestUserScreen> {
  late final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final UserRepository userRepository =
      UserRepository(firestore: firestore);
  late final UserService userService =
      UserService(userRepository: userRepository);
  late StreamController<Map<String, dynamic>?> _userRequestController;
  late User? user = FirebaseAuth.instance.currentUser;
  bool isExpanded = false;

  //Mockup Data

  @override
  void initState() {
    super.initState();
    _userRequestController = StreamController<Map<String, dynamic>?>();
    _getUserActiveRequest(user!.uid).then((requestData) {
      _userRequestController.add(requestData);
    }).catchError((error) {
      _userRequestController.addError(error);
    });
  }

  @override
  void dispose() {
    _userRequestController.close();
    super.dispose();
  }

  String getRequestDetailString(Request _request) {
    String returnString = "ขณะนี้เป็นหนี้กับผู้ให้บริการ";
    for (int i = 0; i < _request.provider.length; i++) {
      String debtStatus = "";
      switch (_request.debtStatus[i]) {
        case 0:
          debtStatus = "ปกติหรือค้างชำระไม่เกิน 90 วัน";
          break;
        case 1:
          debtStatus = "Non-performing Loan(NPL)(ค้างชำระไม่เกิน 90 วัน)";
          break;
        case 2:
          debtStatus = "อยู่ระหว่างกระบวนการกฎหมายหรือศาลพิพากษาแล้ว";
          break;
      }
      returnString =
          "$returnString${_request.provider[i]}ที่สาขา${_request.branch[i]}สถานะหนี้ ณ ตอนนี้ $debtStatus, ";
    }
    returnString += "\n";
    for (int i = 0; i < _request.revenue.length; i++) {
      String revenue = "";
      if (_request.revenue[i] != 0) {
        switch (i) {
          case 0:
            revenue = "รายได้หลักต่อเดือน";
            break;
          case 1:
            revenue = "ผลตอบแทนการลงทุน";
            break;
          case 2:
            revenue = "รายได้จากธุรกิจส่วนตัว";
            break;
        }
        returnString = "$returnString $revenue ${_request.revenue[i]} บาท, ";
      } else {
        continue;
      }
    }
    returnString += "\n";
    for (int i = 0; i < _request.expense.length; i++) {
      String expense = "";
      if (_request.revenue[i] != 0) {
        switch (i) {
          case 0:
            expense = "ค่าใช้จ่ายในชีวิตประจำวันต่อเดือน";
            break;
          case 1:
            expense = "ภาระหนี้";
            break;
        }
        returnString = "$returnString $expense ${_request.expense[i]} บาท, ";
      } else {
        continue;
      }
    }
    returnString +=
        "\nทรัพย์สินส่วนตัว ${_request.propoty} บาท\nรายละเอียดเพิ่มเติม : ${_request.detail}";
    return returnString;
  }

  Future<Map<String, dynamic>?> _getUserActiveRequest(String userId) async {
    return userService.getUserActiveRequest(userId);
  }

  Future<List<Assignment>> _getAllAssignments(String taskId) async {
    return userService.getAllAssignments(taskId);
  }

  List<Widget> createAssignmentStatusContainerList(
      BuildContext context, List<Assignment> u_assignment) {
    List<Widget> AssignmentStatusContainerList = [
      const SizedBox(height: 5),
    ];
    for (Assignment assignment_item in u_assignment) {
      Widget container =
          UserLayout.createAssignmentContainer(context, assignment_item);
      AssignmentStatusContainerList.add(container);
      AssignmentStatusContainerList.add(const SizedBox(height: 5));
    }
    return AssignmentStatusContainerList;
  }

  dynamic getmiddleBody() {
    ScrollController _scrollController = ScrollController();

    return StreamBuilder<Map<String, dynamic>?>(
        stream: _userRequestController.stream,
        builder: (context, requestSnapshot) {
          if (requestSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (requestSnapshot.hasError) {
            return const Center(child: Text('Error fetching data'));
          } else if (!requestSnapshot.hasData) {
            return Stack(children: [
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    "คำร้องปัจจุบัน",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/Nothing.png"),
                      const Text("ไม่มีคำร้องที่ดำเนินการอยู่ในขณะนี้ "),
                      const Text("สามารถกดลงทะเบียนคำร้องได้ที่ปุ่ม \‘+\’")
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 16,
                bottom: 16,
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF444371),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        context.go(AppRoutes.SEND_REQUEST_USER);
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(16),
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ]);
          }
          print(requestSnapshot.data);
          Request userrequest = Request.fromMap(requestSnapshot.data!);
          return FutureBuilder<List<Assignment>>(
            future: _getAllAssignments(userrequest.id),
            builder: (context, assignmentSnapshot) {
              if (assignmentSnapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (assignmentSnapshot.hasError) {
                return const Center(child: Text('Error fetching assignments'));
              } else {
                List<Assignment> assignments = assignmentSnapshot.data!;
                List<Widget> assignmentWidget =
                    createAssignmentStatusContainerList(context, assignments);
                return Container(
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(90, 25, 10, 0),
                            child: Text(
                              "คำร้องปัจจุบัน",
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          SizedBox(
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF36338C),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              width: 324,
                              padding: const EdgeInsets.all(16.0),
                              margin:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: DefaultTextStyle(
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                      color: Colors.white,
                                      fontSize: 15.0,
                                    ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 10),
                                      child: SizedBox(
                                        width: 310,
                                        child: Text(
                                          userrequest.title,
                                          style: const TextStyle(fontSize: 24),
                                          overflow: isExpanded
                                              ? TextOverflow.visible
                                              : TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            const Text("สถานะ : "),
                                            UserLayout
                                                .getRequestStatusContainer(
                                                    userrequest),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          children: [
                                            const Text("ผู้รับผิดชอบ : "),
                                            Flexible(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xFFF0F4FD),
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0),
                                                child: Text(
                                                  userrequest.advisorFullName,
                                                  style: const TextStyle(
                                                      color: Color(0xFF2DC09C)),
                                                  softWrap: true,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("ประเภท : "),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    userrequest.type.join(","),
                                                    overflow: isExpanded
                                                        ? TextOverflow.visible
                                                        : TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 5),
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text("รายละเอียด : "),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    getRequestDetailString(
                                                        userrequest),
                                                    overflow: isExpanded
                                                        ? TextOverflow.visible
                                                        : TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          visualDensity: VisualDensity(
                                              horizontal: -4, vertical: -4),
                                          icon: Icon(
                                            isExpanded
                                                ? Icons.keyboard_arrow_up
                                                : Icons.keyboard_arrow_down,
                                            size: 42,
                                            color: Colors.white,
                                          ),
                                          onPressed: () {
                                            print(getRequestDetailString(
                                                userrequest));
                                            setState(() {
                                              isExpanded = !isExpanded;
                                            });
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Text(
                            "ประวัติการดำเนิน",
                            style: TextStyle(fontSize: 24),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            child: RawScrollbar(
                              thumbColor: const Color(0xFFBBB9F4),
                              thumbVisibility: true,
                              radius: const Radius.circular(20),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6.0, vertical: 10),
                              thickness: 5,
                              child: Container(
                                height: 309,
                                width: 324,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: DefaultTextStyle(
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        color: const Color(0xFF36338C),
                                        fontSize: 15.0,
                                      ),
                                  child: ListView.builder(
                                    itemCount: assignmentWidget.length,
                                    itemBuilder: (context, index) {
                                      return assignmentWidget[index];
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Stack(
          children: [getmiddleBody()],
        ),
      ),
    );
  }
}
