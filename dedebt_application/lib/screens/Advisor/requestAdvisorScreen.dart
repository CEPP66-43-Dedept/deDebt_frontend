import 'dart:async';

import 'package:dedebt_application/repositories/advisorRepository.dart';
import 'package:dedebt_application/services/advisorService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dedebt_application/screens/layouts/advisorLayout.dart';
import 'package:dedebt_application/models/userModel.dart';
import 'package:dedebt_application/models/requestModel.dart';
import 'package:dedebt_application/models/assignmentModel.dart';
import 'package:go_router/go_router.dart';
import 'package:dedebt_application/routes/route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class requestAdvisorScreen extends StatefulWidget {
  final String requestId;
  const requestAdvisorScreen({super.key, required this.requestId});

  @override
  State<requestAdvisorScreen> createState() => _requestAdvisorScreen();
}

class _requestAdvisorScreen extends State<requestAdvisorScreen> {
  static Color primaryColor = const Color(0xFFF3F5FE);
  late final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final AdvisorRepository _advisorRepository =
      AdvisorRepository(firestore: firestore);
  late final AdvisorService _advisorService =
      AdvisorService(advisorRepository: _advisorRepository);
  late StreamController<Request> _requestController;
  late StreamController<List<Assignment>> _assignmentController;
  bool isExpanded = false;
  @override
  void initState() {
    super.initState();
    _assignmentController = StreamController<List<Assignment>>();
    _getAllAssignment(widget.requestId).then((requestData) {
      _assignmentController.add(requestData!);
    }).catchError((error) {
      _assignmentController.addError(error);
    });
    _requestController = StreamController<Request>();
    _getAdvisorRequestByID(widget.requestId).then((requestData) {
      _requestController.add(requestData!);
    }).catchError((error) {
      _requestController.addError(error);
    });
  }

  late User? user = FirebaseAuth.instance.currentUser;

  Future<Request?> _getAdvisorRequestByID(String requestId) async {
    return _advisorService.getRequestByrequestID(requestId);
  }

  Future<List<Assignment>?> _getAllAssignment(String requestId) async {
    return _advisorService.getAllAssignments(requestId);
  }

  //Mockup Data

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
          "$returnString${_request.provider[i]}ที่สาขา${_request.branch[i]}สถานะหนี้ ณ ตอนนี้ $debtStatus,\n";
    }
    returnString += "\n";
    for (int i = 0; i < _request.revenue.length; i++) {
      String revenue = "";

      switch (i) {
        case 0:
          revenue = "รายได้หลักต่อเดือน";
          break;
        case 1:
          revenue = "รายได้เสริม";
          break;
        case 2:
          revenue = "ผลตอบแทนการลงทุน";
          break;
        case 3:
          revenue = "รายได้จากธุรกิจส่วนตัว";
          break;
      }
      returnString = "$returnString $revenue ${_request.revenue[i]} บาท,\n";
    }
    returnString += "\n";
    for (int i = 0; i < _request.expense.length; i++) {
      String expense = "";

      switch (i) {
        case 0:
          expense = "ค่าใช้จ่ายในชีวิตประจำวันต่อเดือน";
          break;
        case 1:
          expense = "ภาระหนี้";
          break;
      }
      returnString = "$returnString $expense ${_request.expense[i]} บาท,\n";
    }
    returnString += "\nสัดส่วนการผ่อนหนี้ต่อรายได้";
    switch (_request.burden) {
      case 0:
        returnString += " : ผ่อนหนี้ 1/3 ของรายได้ต่อเดือน";
        break;
      case 1:
        returnString +=
            " : ผ่อนหนี้มากกว่า 1/3 แต่ยังน้อยกว่า 1/2 ของรายได้ต่อเดือน";
        break;
      case 2:
        returnString +=
            " : ผ่อนหนี้มากกว่า 1/2 รายได้ต่อเดือนแต่น้อยกว่า 2/3 ต่อเดือน";
        break;
      case 3:
        returnString += " : ผ่อนหนี้ 2/3 ของรายได้ต่อเดือน";
        break;
    }
    returnString +=
        "\nทรัพย์สินส่วนตัว ${_request.property} บาท\nรายละเอียดเพิ่มเติม : ${_request.detail}";
    return returnString;
  }

  dynamic getmiddleBody() {
    bool isHavedata = false;

    ScrollController _scrollController = ScrollController();

    var u_assignment = [];
    List<Widget> AssignmentStatusContainerList = [
      const SizedBox(height: 5),
    ];
    for (Assignment assignment_item in u_assignment) {
      Widget container =
          AdvisorLayout.createAssignmentContainer(context, assignment_item);
      AssignmentStatusContainerList.add(container);
      AssignmentStatusContainerList.add(const SizedBox(height: 5));
    }
    return StreamBuilder<Request>(
        stream: _requestController.stream,
        builder: (context, requestSnapshot) {
          print(widget.requestId);
          if (requestSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (requestSnapshot.hasError || !requestSnapshot.hasData) {
            return Center(child: Text('Error fetching data'));
          } else {
            final _request = requestSnapshot.data!;
            return StreamBuilder<List<Assignment>>(
                stream: _assignmentController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasError || !snapshot.hasData) {
                    return Center(child: Text('Error fetching data'));
                  }
                  List<Assignment> assignments = snapshot.data!;
                  u_assignment = snapshot.data!;
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: SizedBox(
                                          width: 310,
                                          child: Text(_request.title,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 24)),
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              const Text("สถานะ : "),
                                              AdvisorLayout
                                                  .getRequestStatusContainer(
                                                      _request),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Row(
                                            children: [
                                              const Text("เจ้าของคำร้อง : "),
                                              Flexible(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color:
                                                        const Color(0xFFF0F4FD),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                  ),
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 10.0),
                                                  child: Text(
                                                    _request.userFullName,
                                                    style: const TextStyle(
                                                        color:
                                                            Color(0xFF2DC09C)),
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
                                                      _request.type.join(","),
                                                      overflow: isExpanded
                                                          ? TextOverflow.visible
                                                          : TextOverflow
                                                              .ellipsis,
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
                                                          _request),
                                                      overflow: isExpanded
                                                          ? TextOverflow.visible
                                                          : TextOverflow
                                                              .ellipsis,
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
                                      itemCount: assignments.length,
                                      itemBuilder: (context, index) {
                                        Assignment assignment =
                                            assignments[index];
                                        return AdvisorLayout
                                            .createAssignmentContainer(
                                          context,
                                          assignment,
                                        );
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
                });
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Stack(
          children: [
            getmiddleBody(),
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
                      context.go(AppRoutes.ADD_ASSIGNMENT_ADVISOR);
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
            ),
          ],
        ),
      ),
    );
  }
}
