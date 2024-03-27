import 'package:flutter/material.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:go_router/go_router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dedebt_application/routes/route.dart';
import 'package:dedebt_application/models/assignmentModel.dart';

class assignmentUserScreen extends StatefulWidget {
  final String assignmentId;
  const assignmentUserScreen({super.key, required this.assignmentId});

  @override
  State<assignmentUserScreen> createState() => _assignmentUserScreen();
}

class _assignmentUserScreen extends State<assignmentUserScreen> {
  //mockup data
  final _assignment = Assignment(
    id: "abc123",
    type: 1,
    title: "ทำเอกสารหักเงิยของธนาคารกรุงเทพ",
    detail: "โปรดตรวขสอบข้อมูลก่อนที่จะส่งเอกสาร",
    status: 1,
    taskId: "def456",
    startTime: Timestamp.now(),
    endTime: Timestamp.fromDate(DateTime.now().add(Duration(days: 3))),
  );
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

  IconData getIcon(int index) {
    return _normalIcon[index];
  }

  Color getIconColors(int index) {
    return Colors.grey;
  }

  void onTap(int page) {
    switch (page) {
      case 0:
        context.go(AppRoutes.HOME_USER);

        break;
      case 1:
        context.go(AppRoutes.REQUEST_USER);

        break;
      case 2:
        context.go(AppRoutes.HISTORY_USER);

        break;
      case 3:
        context.go(AppRoutes.PROFILE_USER);

        break;
    }
  }

  Widget getAssignmentButton(Assignment _assignment) {
    String text_btn = "";
    switch (_assignment.type) {
      case 0:
        text_btn = "เริ่มทำเอกสาร";
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFBBB9F4),
          ),
          onPressed: () {
            //function ที่เปลี่ยนไปหน้ากรอกเอกสาร
            //fillDocumentUserScreen.dart
          },
          child: Text(
            text_btn,
            style: const TextStyle(fontSize: 20, color: Color(0xFF36338C)),
          ),
        );

      case 1:
        text_btn = "ยืนยันเวลานัดหมาย";
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFBBB9F4),
          ),
          onPressed: () {
            //function ที่เปลี่ยนไปหน้ายืนยันเวลานัดหมาย
            //appointmentUserScreen.dart
          },
          child: Text(
            text_btn,
            style: const TextStyle(fontSize: 20, color: Color(0xFF36338C)),
          ),
        );
    }
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFBBB9F4),
      ),
      onPressed: () {},
      child: Text(
        text_btn,
        style: const TextStyle(fontSize: 20, color: Color(0xFF36338C)),
      ),
    );
  }

  Container getAssignmentStatusContainer(Assignment _assignment) {
    var textColor;
    var containerColor;
    String text_status = "";
    switch (_assignment.status) {
      case 1:
        containerColor = const Color(0xFFE1E4F8);
        textColor = const Color(0xFF7673D3);
        text_status = "ดำเนินการ";
        break;
      case 0:
        containerColor = const Color(0xFF2DC09C);
        textColor = const Color(0xFFFAFEFF);
        text_status = "เสร็จสิ้น";
        break;
      case 2:
        containerColor = const Color(0xFFF18F80);
        textColor = const Color(0xFFF0E6EC);
        text_status = "ยกเลิก";
        break;
      default:
        return Container(
          child: Text(text_status),
        );
    }
    return Container(
      width: 83,
      height: 21,
      decoration: BoxDecoration(
          color: containerColor, borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Text(
          text_status,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }

  @override
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
                      //Icon function
                      context.go(AppRoutes.REQUEST_USER);
                    },
                    icon: Icon(
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
                      height: 501,
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
                                        _assignment.title,
                                        overflow: TextOverflow.visible,
                                        style: const TextStyle(
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
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    _assignment.detail,
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
                                              "${_assignment.startTime.toDate().day}/${_assignment.startTime.toDate().month}/${_assignment.startTime.toDate().year}")
                                        ],
                                      ),
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          height: 55,
                                          width: 258,
                                          child:
                                              getAssignmentButton(_assignment)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        ]),
                      )),
                ),
                Container(
                  width: 390,
                  height: 165,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
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
                                  'แจ้งหมายเหตุ',
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
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF2DC09C),
                                ),
                                child: const Text(
                                  'เสร็จสิ้น',
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
