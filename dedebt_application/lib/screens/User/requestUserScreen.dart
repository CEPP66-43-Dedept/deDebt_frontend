import 'package:dedebt_application/models/advisorModel.dart';
import 'package:flutter/material.dart';
import 'package:dedebt_application/screens/layouts/userLayout.dart';
import 'package:dedebt_application/models/userModel.dart';
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
  bool isExpanded = false;

  //Mockup Data
  Users thisuser = Users(
    id: 0,
    ssn: 0,
    firstname: "สมชาย",
    lastname: "ชายมาก",
    roles: "user",
    requests: [0],
    email: "somchai@mail.com",
    tel: "0123456789",
    password: "SecureP@ssw0rd",
  );
  Users advisorUser = Users(
      id: 1,
      ssn: 1,
      firstname: "นายสมปอง",
      lastname: "งอปมส",
      roles: "Advisor",
      requests: [0],
      email: "sompong@mail.com",
      tel: "0987654321",
      password: "AdvisorSecureP@ssw0rd");
  request userrequest = request(
      id: 0,
      title: "การแก้หนี้กับธนาคารกสิกรไทย",
      detail:
          "123456แก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมาย1234567890แก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมาย1234567890แก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมายแก้หนี้ที่ค้างคามานานมากมาย1234567890",
      userId: 0,
      advisorId: 0,
      advisorFullName: "นายสมปอง งอปมส",
      requestStatus: "เสร็จสิ้น",
      type: [
        "หนี้บัตรเครติด",
        "สินเชื่อส่วนบุคคล",
      ], //[หนี้บัตรเครติด,สินเชื่อส่วนบุคคล,หนี้บ้าน,หนี้จำนำรถ,หนี้เช่าซื้อรถ]
      debtStatus: ["Normal"],
      provider: ["กสิกร"],
      revenue: [10000],
      expense: [1000000],
      burden:
          "1/3ของรายได้", //ผ่อนหนี้ [1/3ของรายได้,1/3-1/2ของรายได้,1/2-2/3ของรายได้,มากกว่า 2/3 ของรายได้ ]
      propoty: 25000,
      assignmentId: [],
      appointmentDate: [DateTime(2024, 2, 17)],
      appointmentStatus: [
        "เสร็จสิ้น",
      ]);
  Assignment userAppointment = Assignment(
      id: 0,
      type: "การนัดหมาย",
      title: "การนัดคุยทางโทรศัพท์",
      detail: "โทรทางมือถือเบอร์ 123-456-7890",
      status: "ยกเลิก",
      tid: null,
      advisorTimeslot: [],
      userTimeslot: DateTime(2024, 2, 21));
  Assignment userAssignment = Assignment(
      id: 1,
      type: "งาน'",
      title: "กรอกเอกสาร",
      detail: "กรอกเอกสารหักเงินของกสิกร",
      status: "ดำเนินการ",
      tid: 0,
      advisorTimeslot: [],
      userTimeslot: DateTime(2024, 2, 22));
  Assignment userAssignment_2 = Assignment(
      id: 1,
      type: "งาน'",
      title: "กรอกเอกสาร",
      detail: "กรอกเอกสารหักเงินของกสิกร",
      status: "เสร็จสิ้น",
      tid: 0,
      advisorTimeslot: [],
      userTimeslot: DateTime(2024, 2, 22));

  @override
  void initState() {
    super.initState();
  }

  dynamic getmiddleBody() {
    bool isHavedata = false;
    if (isHavedata) {
      return Stack(
        children: [
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
        ],
      );
    } else {
      ScrollController _scrollController = ScrollController();

      var u_assignment = [userAppointment, userAssignment, userAssignment_2];
      List<Widget> AssignmentStatusContainerList = [
        const SizedBox(height: 5),
      ];
      for (Assignment assignment_item in u_assignment) {
        Widget container =
            UserLayout.createAssignmentContainer(assignment_item);

        AssignmentStatusContainerList.add(container);
        AssignmentStatusContainerList.add(const SizedBox(height: 5));
      }
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
                    margin: const EdgeInsets.symmetric(vertical: 16.0),
                    child: DefaultTextStyle(
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                            fontSize: 15.0,
                          ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: SizedBox(
                              width: 310,
                              child: Text(userrequest.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 24)),
                            ),
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  const Text("สถานะ : "),
                                  UserLayout.getRequestStatusContainer(
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
                                        color: const Color(0xFFF0F4FD),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(
                                        "${advisorUser.firstname} ${advisorUser.lastname}",
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("รายละเอียด : "),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          userrequest.detail,
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
                                visualDensity:
                                    VisualDensity(horizontal: -4, vertical: -4),
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
                      child: ListView.builder(
                        itemCount: AssignmentStatusContainerList.length,
                        itemBuilder: (context, index) {
                          return AssignmentStatusContainerList[index];
                        },
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
            ),
          ],
        ),
      ),
    );
  }
}
