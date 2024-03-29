import 'dart:async';

import 'package:dedebt_application/models/fillAssignModel.dart';
import 'package:dedebt_application/models/requestModel.dart';
import 'package:dedebt_application/repositories/advisorRepository.dart';
import 'package:dedebt_application/screens/User/docAssignmentScreen.dart';
import 'package:dedebt_application/services/advisorService.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dedebt_application/routes/route.dart';
import 'package:dedebt_application/models/assignmentModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class assignmentAdvisorScreen extends StatefulWidget {
  final String assignmentID;
  const assignmentAdvisorScreen({super.key, required this.assignmentID});
  @override
  State<assignmentAdvisorScreen> createState() => _assignmentAdvisorScreen();
}

class _assignmentAdvisorScreen extends State<assignmentAdvisorScreen> {
  static Color primaryColor = const Color(0xFFF3F5FE);
  late final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final AdvisorRepository _advisorRepository =
      AdvisorRepository(firestore: firestore);
  late final AdvisorService _advisorService =
      AdvisorService(advisorRepository: _advisorRepository);
  late StreamController<Assignment> _assignmentController;
  @override
  void initState() {
    super.initState();

    _assignmentController = StreamController<Assignment>();

    _getAssignmentByID(widget.assignmentID).then((assignmentData) {
      if (assignmentData != null) {
        _assignmentController.add(assignmentData);
        setState(() {
          _assignment = assignmentData;
        });
      }
    }).catchError((error) {
      _assignmentController.addError(error);
    });
  }

  Future<FillAssignment?> _getDocumentData(String documentId) async {
    try {
      final DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection('documents')
          .doc(documentId)
          .get();

      if (documentSnapshot.exists) {
        final data = documentSnapshot.data()
            as Map<String, dynamic>; // Access data as a Map
        if (data != null && data['data'] is List<dynamic>) {
          Map<String, dynamic> dataMap = {'data': data['data']};
          return FillAssignment.fromMap(dataMap);
        } else {
          print('Document data does not have a valid "data" list');
          return null;
        }
      } else {
        print('Document does not exist');
        return null;
      }
    } catch (error) {
      print('Error getting document data: $error');
      return null;
    }
  }

  Future<Assignment?> _getAssignmentByID(String assignmentID) async {
    return await _advisorService.getAssignmentByID(assignmentID);
  }

  static Color navbarColor = const Color(0xFF444371);
  int currentPage = 0;
  final List<IconData> _normalIcon = [
    Icons.home,
    Icons.attach_money,
    Icons.replay,
    Icons.person
  ];
  final List<IconData> _outlinedIcon = [
    Icons.home_outlined,
    Icons.attach_money_outlined,
    Icons.replay_outlined,
    Icons.person_outline
  ];
  //Mockup Data
  Assignment _assignment = Assignment(
    id: "0",
    type: 0,
    title: "",
    detail: "",
    status: 0,
    taskId: "",
    startTime: Timestamp.fromDate(DateTime(2023, 2, 27, 13, 0)),
    endTime: Timestamp.fromDate(DateTime(2023, 2, 27, 17, 0)),
  );
  IconData getIcon(int index) {
    return _normalIcon[index];
  }

  Color getIconColors(int index) {
    return Colors.grey;
  }

  void onTap(int page) {
    switch (page) {
      case 0:
        context.go(AppRoutes.HOME_ADVISOR);

        break;
      case 1:
        context.go(AppRoutes.REQUEST_LIST_ADVISOR);

        break;
      case 2:
        context.go(AppRoutes.HISTORY_ADVISOR);

        break;
      case 3:
        context.go(AppRoutes.PROFILE_ADVISOR);

        break;
    }
  }

  Container getAssignmentStatusContainer(Assignment _assignment) {
    var containerColor;
    var textColor;

    switch (_assignment.status) {
      case 0:
        //เสร็จสิ้น
        containerColor = const Color(0xFF2DC09C);
        textColor = const Color(0xFFFAFEFF);
        break;
      case 1:
        //ดำเนินการ
        containerColor = const Color(0xFFE1E4F8);
        textColor = const Color(0xFF7673D3);
        break;
      case 2:
        //ยกเลิก
        containerColor = const Color(0xFFF18F80);
        textColor = const Color(0xFFF0E6EC);
        break;
    }
    return Container(
      decoration: BoxDecoration(
        color: containerColor,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Text(
        _assignment.status == 0
            ? "เสร็จสิ้น"
            : _assignment.status == 1
                ? "ดำเนินการ"
                : _assignment.status == 1
                    ? "ยกเลิก"
                    : "",
        style: TextStyle(color: textColor),
      ),
    );
  }

  Container getButton(Assignment assignment) {
    if (assignment.type == 0) {
      return Container(
        width: 392,
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ElevatedButton(
          onPressed: () {
            showDocumentDialog();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFBBB9F4),
          ),
          child: const Text(
            'รายละเอียดเอกสาร',
            style: TextStyle(
                fontSize: 18.0, color: Colors.white), // Set text color
          ),
        ),
      );
    } else if (assignment.type == 1) {
      return Container(
        width: 392,
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ElevatedButton(
          onPressed: () {
            showAppointmentDialog();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFBBB9F4),
          ),
          child: const Text(
            'รายละเอียดการนัดหมาย',
            style: TextStyle(
                fontSize: 18.0, color: Colors.white), // Set text color
          ),
        ),
      );
    }
    return Container();
  }

  void showAppointmentDialog() {
    bool isAppointmentconfirmed = true;

    String UsersName = "Areeya Suwannathot";
    String Action = "";
    //เป็นการนัดหมาย
    if (_assignment.status == 0) {
      Action = "ยืนยันการนัดหมาย";
    } else {
      Action = "ยังไม่ยืนยันการนัดหมาย";
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.black,
                fontSize: 15.0,
              ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 340.0, // Set width
                    height: 243.0, // Set height
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Stack(
                      // stack ของ ข้อความและ ปุ่ม"X"
                      children: [
                        Positioned(
                          top: 60,
                          left: 36,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "ผู้ใช้ [\"${UsersName}\"]",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationThickness: 0.0,
                                      fontSize: 20.0,
                                      color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  //แสดงตัวแปร Action
                                  Action,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationThickness: 0.0,
                                      fontSize: 20.0,
                                      color: Colors.black),
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 55,
                                    color: Colors.black,
                                  ),
                                  Text(
                                      "วันที่ ${_assignment.startTime.toDate().day}/${_assignment.startTime.toDate().month}/${_assignment.startTime.toDate().year}\nเวลา ${DateFormat("HH:mm").format(_assignment.startTime.toDate())} : ${DateFormat("HH:mm").format(_assignment.endTime.toDate())}")
                                ],
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          top: 5.0,
                          right: 15.0,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.grey,
                              size: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> showDocumentDialog() async {
    bool isFillDoc = true;

    String UsersName = "Areeya Suwannathot";
    String Action = "";
    var Content;
    //เป็นการนัดหมาย
    FillAssignment? fillAssignment =
        await _getDocumentData(_assignment.id ?? '');

    if (fillAssignment != null) {
      Action = "กรอกเอกสารแล้ว";
      Content = Container(
        width: 280,
        height: 280,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(28.0)),
          color: Color(0xFFDAEAFA),
        ),
        padding: const EdgeInsets.fromLTRB(19, 11, 18, 35),
        child: Stack(
          children: [
            Container(
              width: 302,
              height: 328,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: Colors.white,
              ),
              child: DocAssignScreen(
                lstString: fillAssignment ?? FillAssignment(),
              ),
            ),
            Positioned(
              bottom: 1.0,
              right: 1.0,
              child: IconButton(
                icon: Icon(
                  Icons.zoom_out_map,
                  color: Colors.black,
                ),
                onPressed: () {
                  // ปุ่มดู pdf
                  print('Info button pressed!');
                },
              ),
            ),
          ],
        ),
      );
    } else {
      Action = "ยังไม่ได้กรอกเอกสาร";
      Content = Row(
        children: [
          Icon(
            Icons.account_balance,
            size: 55,
            color: Colors.black,
          ),
          Text("ยังไม่ได้กรอกเอกสาร")
        ],
      );
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.black,
                fontSize: 15.0,
              ),
          child: Stack(
            children: [
              Positioned.fill(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 340.0, // Set width
                    height: 443.0, // Set height
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    child: Stack(
                      // stack ของ ข้อความและ ปุ่ม"X"
                      children: [
                        Positioned(
                          top: 60,
                          left: 36,
                          child: Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  "ผู้ใช้ [\"${UsersName}\"]",
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationThickness: 0.0,
                                      fontSize: 20.0,
                                      color: Colors.black),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  //แสดงตัวแปร Action
                                  Action,
                                  style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      decorationThickness: 0.0,
                                      fontSize: 20.0,
                                      color: Colors.black),
                                ),
                              ),
                              //เพิ่มให้สแดงเอกสารรตรงนี้
                              Content,
                            ],
                          ),
                        ),
                        Positioned(
                          top: 5.0,
                          right: 15.0,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              color: Colors.grey,
                              size: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget build(BuildContext context) {
    return StreamBuilder<Assignment>(
        stream: _assignmentController.stream,
        builder: (context, assignmentSnapshot) {
          if (assignmentSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (assignmentSnapshot.hasError ||
              !assignmentSnapshot.hasData) {
            return Center(child: Text('Error fetching data'));
          }
          print(widget.assignmentID);
          print(assignmentSnapshot.data);
          _assignment = assignmentSnapshot.data ?? _assignment;
          if (assignmentSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (assignmentSnapshot.hasError ||
              !assignmentSnapshot.hasData) {
            return Center(child: Text('Error fetching data'));
          }
          return GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: Scaffold(
                appBar: AppBar(
                    backgroundColor: navbarColor,
                    surfaceTintColor: Colors.transparent,
                    toolbarHeight: 55,
                    title: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            context.go(AppRoutes.REQUEST_ADVISOR +
                                '/${_assignment.taskId}');
                            //Icon function
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 35,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        const Text(
                          "งานที่มอบหมาย",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        )
                      ],
                    )),
                body: Scaffold(
                    body: Align(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      RawScrollbar(
                        thumbColor: const Color(0xFFBBB9F4),
                        radius: const Radius.circular(20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 10),
                        thickness: 5,
                        child: Container(
                            width: 415,
                            height: 601,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 15),
                            child: DefaultTextStyle(
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(
                                    color: const Color(0xFF36338C),
                                    fontSize: 15,
                                  ),
                              child: ListView(children: [
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(33, 29, 33, 25),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            28, 21, 28, 13),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFDAEAFA),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _assignment.title,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "สถานะ: ",
                                                  style: TextStyle(
                                                      color: Color(0xFF5A55CA)),
                                                ),
                                                // create status container
                                                getAssignmentStatusContainer(
                                                    _assignment),
                                              ],
                                            ),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "รายละเอียด: ",
                                                  style: TextStyle(
                                                      color: Color(0xFF5A55CA)),
                                                ),
                                                Expanded(
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          //Add Detail
                                                          _assignment.detail,
                                                          overflow: TextOverflow
                                                              .visible,
                                                        )
                                                      ]),
                                                )
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                    "วันสิ้นสุดการดำเนินการ: "),
                                                //วันดำเนินการ
                                                Text(
                                                    "${_assignment.startTime.toDate().day}/${_assignment.startTime.toDate().month}/${_assignment.startTime.toDate().year}")
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      getButton(_assignment),
                                    ],
                                  ),
                                )
                              ]),
                            )),
                      ),
                      Container(
                        width: 390,
                        height: 65,
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
                                        print('Next button pressed');
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                            const Color(0xFFF18F80),
                                      ),
                                      child: const Text(
                                        'แจ้งหมายเหตุ',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color:
                                                Colors.white), // Set text color
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )),
                bottomNavigationBar: SizedBox(
                    height: 55,
                    child: BottomAppBar(
                      color: navbarColor,
                      padding: const EdgeInsets.all(0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            icon: Icon(getIcon(0),
                                size: 35, color: getIconColors(0)),
                            onPressed: () {
                              onTap(0);
                            },
                          ),
                          IconButton(
                            icon: Icon(getIcon(1),
                                size: 35, color: getIconColors(1)),
                            onPressed: () {
                              onTap(1);
                            },
                          ),
                          IconButton(
                            icon: Icon(getIcon(2),
                                size: 35, color: getIconColors(2)),
                            onPressed: () {
                              onTap(2);
                            },
                          ),
                          IconButton(
                            icon: Icon(getIcon(3),
                                size: 35, color: getIconColors(3)),
                            onPressed: () {
                              onTap(3);
                            },
                          )
                        ],
                      ),
                    ))),
          );
        });
  }
}
