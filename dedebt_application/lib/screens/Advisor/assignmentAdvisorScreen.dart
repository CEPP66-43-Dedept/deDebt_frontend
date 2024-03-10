import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dedebt_application/routes/route.dart';
import 'package:dedebt_application/models/assignmentModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class assignmentAdvisorScreen extends StatefulWidget {
  const assignmentAdvisorScreen({super.key});
  @override
  State<assignmentAdvisorScreen> createState() => _assignmentAdvisorScreen();
}

class _assignmentAdvisorScreen extends State<assignmentAdvisorScreen> {
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
  Assignment userAppointment = Assignment(
    id: "0",
    type: 0,
    title: "การนัดคุยทางโทรศัพท์",
    detail: "โทรทางมือถือเบอร์ 123-456-7890",
    status: 0,
    taskId: "TSETTaskID",
    startTime: Timestamp.fromDate(DateTime(2023, 2, 27, 13, 0)),
    endTime: Timestamp.fromDate(DateTime(2023, 2, 27, 17, 0)),
  );
  Assignment userAssignment = Assignment(
    id: "1",
    type: 0,
    title: "กรอกเอกสาร",
    detail: "กรอกเอกสารหักเงินของกสิกร",
    status: 0,
    taskId: "TSETTaskID",
    startTime: Timestamp.fromDate(DateTime(2023, 2, 26, 13, 0)),
    endTime: Timestamp.fromDate(DateTime(2023, 2, 26, 17, 0)),
  );
  Assignment userAssignment_2 = Assignment(
    id: "1",
    type: 0,
    title: "กรอกเอกสาร",
    detail: "กรอกเอกสารหักเงินของกสิกร",
    status: 0,
    taskId: "TSETTaskID",
    startTime: Timestamp.fromDate(DateTime(2023, 2, 26, 13, 0)),
    endTime: Timestamp.fromDate(DateTime(2023, 2, 26, 17, 0)),
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
            'เริ่มทำเอกสาร',
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
    if (isAppointmentconfirmed) {
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
                                      "วันที่ ${userAppointment.startTime.toDate().day}/${userAppointment.startTime.toDate().month}/${userAppointment.startTime.toDate().year}\nเวลา ${DateFormat("HH:mm").format(userAppointment.startTime.toDate())} : ${DateFormat("HH:mm").format(userAppointment.endTime.toDate())}")
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

  void showDocumentDialog() {
    bool isFillDoc = false;

    String UsersName = "Areeya Suwannathot";
    String Action = "";
    var Content;
    //เป็นการนัดหมาย
    if (isFillDoc) {
      Action = "กรอกเอกสารแล้ว";
    } else {
      Action = "ยังไม่ได้กรอกเอกสาร";
      Content = Row(
        children: [
          Icon(
            Icons.account_balance,
            size: 55,
            color: Colors.black,
          ),
          Text("${userAssignment.title}")
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
                      context.go(AppRoutes.REQUEST_ADVISOR);
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10),
                  thickness: 5,
                  child: Container(
                      width: 415,
                      height: 601,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: DefaultTextStyle(
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: const Color(0xFF36338C),
                              fontSize: 15,
                            ),
                        child: ListView(children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(33, 29, 33, 25),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(28, 21, 28, 13),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDAEAFA),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        userAppointment.title,
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
                                              userAppointment),
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
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    //Add Detail
                                                    userAppointment.detail,
                                                    overflow:
                                                        TextOverflow.visible,
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
                                              //แก้
                                              "แก้")
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                getButton(userAppointment),
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
                                  backgroundColor: const Color(0xFFF18F80),
                                ),
                                child: const Text(
                                  'แจ้งหมายเหตุ',
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
                      icon: Icon(getIcon(0), size: 35, color: getIconColors(0)),
                      onPressed: () {
                        onTap(0);
                      },
                    ),
                    IconButton(
                      icon: Icon(getIcon(1), size: 35, color: getIconColors(1)),
                      onPressed: () {
                        onTap(1);
                      },
                    ),
                    IconButton(
                      icon: Icon(getIcon(2), size: 35, color: getIconColors(2)),
                      onPressed: () {
                        onTap(2);
                      },
                    ),
                    IconButton(
                      icon: Icon(getIcon(3), size: 35, color: getIconColors(3)),
                      onPressed: () {
                        onTap(3);
                      },
                    )
                  ],
                ),
              ))),
    );
  }
}
