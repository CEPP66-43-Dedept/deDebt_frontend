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
    type: 1,
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

  Container getAssignmentStatusContainer(String status) {
    var textColor;
    var containerColor;
    switch (status) {
      case "ดำเนินการ":
        containerColor = const Color(0xFFE1E4F8);
        textColor = const Color(0xFF7673D3);
        break;
      case "เสร็จสิ้น":
        containerColor = const Color(0xFF2DC09C);
        textColor = const Color(0xFFFAFEFF);
        break;
      case "ยกเลิก":
        containerColor = const Color(0xFFF18F80);
        textColor = const Color(0xFFF0E6EC);
        break;
      default:
        return Container(
          child: Text(status),
        );
    }
    return Container(
      width: 83,
      height: 21,
      decoration: BoxDecoration(
          color: containerColor, borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Text(
          status,
          style: TextStyle(color: textColor),
        ),
      ),
    );
  }

  Container getButton(Assignment assignment) {
    //แก้ชื่อเงื่อนไขด้วย
    if (assignment.type == "การนัดหมาย") {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ElevatedButton(
          onPressed: () {
            //นัดหมาย function
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFBBB9F4),
          ),
          child: const Text(
            'เลือกเวลาเพื่อนัดหมาย',
            style: TextStyle(
                fontSize: 18.0, color: Colors.white), // Set text color
          ),
        ),
      );
    } else if (assignment.type == "กรอกเอกสาร") {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: ElevatedButton(
          onPressed: () {
            //redirect ไปหน้าเอกสาร
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
      ;
    }
    return Container();
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
                                              //แก้
                                              userAppointment.status
                                                  .toString()),
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
